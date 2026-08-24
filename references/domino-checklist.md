# Domino checklist

The ordering discipline for ticket sequencing — CHIA–CHỌN–CHUỖI (timvu.vn/fast): among the things worth doing, pick the domino that makes later steps easier to test, easier to change, or unnecessary.

When ordering tickets after `/to-tickets` drafts them, run this checklist top-down. The first rule that discriminates between two tickets decides their order. Record the reason as one line in the ticket's **Domino Note**.

1. **Unblocks the most** — the ticket that, once done, lets the most other tickets start or get tested goes first.
2. **Makes later testing easier** — the ticket that creates the seam/harness/fixture the later tickets test through goes before the tickets that use it.
3. **Simple before clever** — between equal tickets, the simpler one first; it may make the clever one unnecessary.
4. **Immutable before dependent** — schema, contracts, and types (hard to change later, everything hangs off them) before the code that consumes them.
5. **Shared before local** — the module several tickets touch before the module one ticket owns.
6. **Kills work** — the ticket that might make another ticket *unnecessary* outranks both; a done domino that deletes future work is the cheapest work there is.

A **Domino Note** reads like: *"First: creates the test harness tickets 03–06 test through (rule 2)."* One line, rule cited. If no rule discriminates, either order is fine — say so and stop; don't manufacture a reason.
