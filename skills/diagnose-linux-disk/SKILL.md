---
name: diagnose-linux-disk
description: Diagnose excessive Linux disk usage, especially df reporting far more used space than du, unexplained or hidden disk usage (disk ẩn), and suspected Docker growth. Reconcile filesystem usage with files, open deleted files, container storage, mounts, and filesystem accounting before proposing cleanup.
---

# Diagnose Linux disk usage

Find what accounts for the occupied space on the affected filesystem. Distinguish confirmed consumers from incomplete scans and unexplained usage. Reply in the user's language, concisely; use Vietnamese when the conversation is Vietnamese.

## Establish the actual target

- Identify the affected host, filesystem, mountpoint, and observation time from the user's evidence. Use an existing authorized connection when available. Never present measurements from the assistant's sandbox or an unrelated container as measurements of the user's server.
- When no connection exists, provide a small batch of commands for the user to run on that host, then interpret their output. Do not request SSH secrets or fabricate access.
- Treat an audit request as authorization for diagnostic reads. Do not infer authorization to delete files, prune Docker, restart services, truncate logs, change reserved blocks, or remove snapshots. If cleanup is already authorized, honor that scope and explain the concrete impact before the relevant action; do not ask again merely because this skill mentions cleanup.
- Reuse complete, recent evidence. A statement such as “AI found only 200 GB” does not establish a complete `du` scan; obtain the command, target, errors, completion state, and total.

## Get a comparable baseline

Use the affected filesystem's mountpoint for `disk_target`; `/` below is an example. For GNU/Linux, collect:

```bash
disk_target=/
date -Is
hostname
df -B1 --output=source,fstype,size,used,avail,pcent,target "$disk_target"
findmnt --target "$disk_target" -o TARGET,SOURCE,FSTYPE,OPTIONS
sudo du -x -B1 --max-depth=1 "$disk_target" | sort -nr
```

- Run the scan with sufficient permissions on the host. Preserve stderr and the `du` exit status, including when output is piped through `sort`. Permission errors, timeouts, interrupted scans, and unreadable paths make the result incomplete. Do not hide errors with `2>/dev/null`.
- Scan the directory itself, not a shell wildcard such as `*`, so dot directories are included. A depth limit limits reporting, not the depth of traversal. Allow the scan to finish; do not repeatedly launch full-disk scans.
- Use allocated bytes for reconciliation. Do not use `ls -lh`, `find -size`, or `du --apparent-size` as physical usage totals. Convert to GiB for presentation using 2^30 bytes; do not mix GB, GiB, and rounded `df -h` output.
- Use `-x` to stay on the same device. It does not guarantee exclusion of same-device bind mounts, and Btrfs subvolumes can require native accounting. Inspect mounts before interpreting gaps or duplicate totals.
- Explain `tmpfs` Size as a memory-backed capacity limit, not occupied disk; inspect Used and swap only if relevant. Do not add repeated filesystem rows or overlay mounts from `df`.
- Obtain `df -i "$disk_target"` when writes fail despite available bytes or many small files suggest inode exhaustion.

## Follow the evidence

Choose the next branch from the baseline; do not run every advanced command automatically.

| Observation | Next investigation |
| --- | --- |
| Complete `du` broadly accounts for `df` Used | Descend into the largest directories, one level at a time; identify application ownership. |
| Incomplete scan or insufficient access | Report the coverage gap and obtain the missing readable paths or output. |
| Complete `du` is much smaller than `df` Used | Check open deleted files, covered mountpoints, and accounting specific to the detected filesystem. |
| Docker or container directories are large, or Docker is suspected | Read the Docker section of [storage-layers.md](references/storage-layers.md). |
| `du` exceeds `df` or totals look duplicated | Check parent/child summation, bind mounts, overlay views, shared blocks, hard links, and unit mismatches. |

### Trace visible consumers

Run `sudo du -xhd1 /verified/large/directory | sort -hr` only after replacing the example path with one found in the evidence. Inspect large files in that subtree by allocated blocks when necessary.

Identify likely owners from measured paths: model/checkpoint directories, Hugging Face or package caches, Conda environments, database data, recordings, backups, and system logs. Do not assume these exist because the user works with AI. Check other users and `/root` when they are on the affected filesystem and in scope.

Use `journalctl --disk-usage` only when journal storage is relevant. Treat that number as a breakdown of files already measured by `du`, not additional usage.

### Find open deleted files

```bash
sudo lsof -nP +L1
```

An unlinked file may retain allocated space while a process holds it open. Read the PID, file descriptor, device, inode, and name; identify the owning service or container.

- Do not add every `SIZE/OFF` row. The same file can appear for multiple descriptors, threads, and processes, and logical size is not allocated size.
- For a live numeric descriptor, substitute the observed PID and descriptor into the following read-only check:

```bash
sudo stat -Lc 'dev=%d inode=%i blocks=%b block_unit=%B logical_bytes=%s' -- "/proc/$disk_pid/fd/$disk_fd"
```

- Estimate allocated bytes with `blocks * block_unit`, deduplicate by device and inode, and attribute only files backed by the affected filesystem. Account for overlay backing paths; exclude unrelated filesystems and memory-only `memfd`/tmpfs objects.
- Report inaccessible descriptors, missing `lsof`, process races, and container namespace visibility limits as incomplete evidence. A small or empty listing alone does not prove that no space is retained.
- Describe release through the owning application closing the file as a possible remedy. Do not restart or kill processes merely to verify the diagnosis.

### Investigate a remaining gap

Read the mount and filesystem sections of [storage-layers.md](references/storage-layers.md) when the completed scan and open-file investigation leave a material difference. Use the detected filesystem's tools; do not label hundreds of unexplained GB as generic “system overhead.”

## Reconcile and report

Maintain the distinction between a breakdown and an additional amount:

- The `du` root total already contains measured child directories, Docker data, caches, and logs. Never add those breakdowns to it again.
- Treat Docker-reported usage as a cross-check, not a separate addend. Account for shared layers and filesystem-specific sharing.
- State `df` Used, complete visible-file allocation, separately verified retained allocation, any quantified filesystem accounting, and the remaining unexplained difference. When measurements overlap or cannot yet be quantified, keep an explicit unknown instead of forcing totals to match.
- Separate `Size - Used - Avail` from the `df Used - du` difference. Reserved free blocks can reduce Avail; they do not automatically explain a large Used-versus-file-allocation gap.
- Expect some metadata and changes during a live scan. If concurrent writes materially affect reconciliation, take a fresh small baseline or repeat only the necessary branch.

Lead with the finding and its confidence. Use a compact table of measured consumers and evidence when useful. Finish with the unresolved amount and the next specific check, or with an appropriately scoped cleanup proposal when requested. Do not stop at finding one large directory while a much larger gap remains; stop when the difference is explained to a stated tolerance, or when a concrete access/data limitation is clearly reported.

## Authoritative references

Consult local manuals first for installed flags; use these upstream sources when version-specific behavior needs checking:

- [GNU du manual](https://www.gnu.org/software/coreutils/manual/html_node/du-invocation.html)
- [lsof manual](https://man7.org/linux/man-pages/man8/lsof.8.html)
- [Linux unlink semantics](https://man7.org/linux/man-pages/man2/unlink.2.html)
- [Linux tmpfs documentation](https://docs.kernel.org/filesystems/tmpfs.html)
