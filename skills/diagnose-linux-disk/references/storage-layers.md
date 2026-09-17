# Storage layers and retained usage

Read the relevant section after the baseline identifies a Docker, mount, or filesystem accounting question.

## Docker and containerd

1. Identify the daemon being queried. `docker context show` and narrowly selected context endpoint information distinguish local, remote, and rootless daemons. A Docker CLI on the host may target another server. Do not silently change contexts or assume `sudo docker` queries the same rootless daemon as `docker`.
2. Query the verified daemon with the required existing privileges:

```bash
docker info --format 'Root={{.DockerRootDir}} Driver={{.Driver}} Logging={{.LoggingDriver}}'
docker system df
```

3. Use `docker system df -v` only when the breakdown is needed. Inspect the measured Docker root on the daemon's actual host, rather than assuming `/var/lib/docker`. Rootless and custom configurations may use other paths.
4. Inspect containerd's configured persistent root when the image store uses it. Common Linux paths are `/var/lib/docker` and `/var/lib/containerd`, but either can be customized. With the containerd image store, changing Docker's data-root does not also relocate the containerd store. Derive the active configuration; do not equate every containerd directory with Docker because other workloads may share the service.
5. Attribute a relevant container with narrow inspect templates, replacing `disk_container` with its observed ID or name:

```bash
docker inspect --format 'Name={{.Name}} LogPath={{.LogPath}} Logging={{.HostConfig.LogConfig.Type}}' "$disk_container"
docker inspect --format '{{range .Mounts}}{{println .Type .Source .Destination}}{{end}}' "$disk_container"
```

Measure returned log paths, rotated siblings, and bind-mount source directories on the daemon host, checking their backing filesystems. Avoid full inspect dumps because environment values may include credentials.

Interpretation:

- Images, writable container layers, volumes, and build cache are distinct categories. Images share layers; do not sum image virtual sizes as physical allocation.
- Docker CLI usage summaries are not a complete disk census. Container logs, bind-mounted host data, other build workers, or another daemon may require direct measurement. An empty Docker summary cannot explain a large gap by itself.
- Check the actual logging driver. For json-file logging, inspect rotation settings and allocated size; an unrestricted log can grow substantially. An empty LogPath or journald driver requires a different branch. Do not read or stream the entire log to measure it.
- Measure the storage directories and avoid traversing both overlay merged views and their backing directories. Relate every container measurement to the existing host `du` total; do not count it twice.
- “Reclaimable” describes Docker references, not the business value of the data. A stopped container, unused volume, or cached model can still matter to the user. Propose a precise target and expected impact if cleanup is requested; never use blanket prune as a diagnostic command.

Sources: [Docker daemon storage](https://docs.docker.com/engine/daemon/), [Docker usage](https://docs.docker.com/reference/cli/docker/system/df/), [JSON file logging](https://docs.docker.com/engine/logging/drivers/json-file/).

## Files hidden beneath mounts

Inspect mount topology on the affected host:

```bash
findmnt -R "$disk_target" -o TARGET,SOURCE,FSTYPE,OPTIONS
```

Files written into a directory before another filesystem was mounted over it can remain allocated on the underlying filesystem while a normal pathname scan sees the new mount's contents.

- Use this as a hypothesis when a mount and residual gap support it; topology alone does not quantify hidden files.
- Keep production mounts in place. When privileged diagnostic access is available, a non-recursive bind view of the affected filesystem in a private mount namespace can reveal the underlying directories without changing the service's view. Make only the temporary inspection view read-only; never remount the production filesystem read-only or use a recursive bind that reproduces the covered mounts.
- Construct and verify such an inspection for the actual host and mount layout. Clean up only the temporary namespace/view you created. If the needed privileges are unavailable, ask for the specific measurement or report that coverage limit; do not suggest unmounting an active service filesystem as routine diagnosis.
- Attribute any discovered files to the underlying filesystem and avoid duplicate bind-view counts.

Source: [Linux mount manual](https://man7.org/linux/man-pages/man8/mount.8.html).

## Filesystem-specific accounting

Select by the `findmnt`/`df` filesystem type and installed tool version. These examples are diagnostic reads; substitute the verified mountpoint, block device, or dataset.

| Filesystem | Useful read-only evidence | Interpretation |
| --- | --- | --- |
| ext2/3/4 | `sudo tune2fs -l "$disk_device"` | Read block counts, block size, and reserved-block configuration. Reserved free space affects availability; distinguish it from Used. Quantify relevant metadata only with evidence. |
| Btrfs | `sudo btrfs filesystem usage -b "$disk_target"`; `sudo btrfs subvolume list -s "$disk_target"` | Check allocation, metadata, subvolumes, and snapshot presence. Use native sharing/exclusive accounting if needed; snapshot apparent sizes cannot simply be added. |
| ZFS | `zfs list -p -o name,used,avail,refer,mountpoint`; `zfs get -p usedbysnapshots,usedbydataset,usedbychildren,usedbyrefreservation "$disk_dataset"` | Reconcile the affected dataset and its native usage categories. Avoid summing a parent dataset's Used with its descendants. |
| Other | Installed filesystem documentation and read-only native reports | Do not assume ext4 reserve rules or snapshot behavior applies. |

Do not enable quotas, destroy snapshots, run repair, change allocation settings, or reduce reserved blocks merely to diagnose usage. A snapshot's existence is evidence of a possible retention mechanism, not proof that it accounts for the missing amount. On filesystems with reflinks, compression, or shared extents, per-file allocated sizes may not represent independently reclaimable physical space.

Sources: [tune2fs](https://man7.org/linux/man-pages/man8/tune2fs.8.html), [Btrfs filesystem accounting](https://btrfs.readthedocs.io/en/latest/btrfs-filesystem.html), [OpenZFS properties](https://openzfs.github.io/openzfs-docs/man/master/7/zfsprops.7.html).
