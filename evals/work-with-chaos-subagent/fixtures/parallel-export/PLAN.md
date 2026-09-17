# Tenant CSV export

Revision: r1
Request: implement the approved plan
Mode: flexible
Approval: r1 and the scope below approved by the fixture user on 2026-09-17; no external publication authorized.

Objective: an authorized caller exports all matching tenant records as correctly encoded CSV.
Contract: CONTRACT.md, accepted v1. Source anchors are the supplied stub modules.
Out of scope: network, persistence, schema changes, deployment, third-party dependencies.

| Requirement | Acceptance | Owner task |
| --- | --- | --- |
| R1 | Tenant and optional exact status filter; stable order, all rows, input unchanged | T1 |
| R2 | UTF-8 CSV, fixed columns, escaping, string total, empty header | T2 |
| R3 | Permission checked before any data access; service composes query and CSV | T3 |
| R4 | Actual unit and combined-behavior evidence before completion | T1, T2, T3 |

| Task | Outcome | Dependencies | Allowed writes | State |
| --- | --- | --- | --- | --- |
| T1 | Select exactly the requested tenant/status records | accepted contract v1 | report_export/query.py; tests/test_query.py (new) | pending |
| T2 | Serialize accepted records correctly into CSV bytes | accepted contract v1 | report_export/csv_format.py; tests/test_csv_format.py (new) | pending |
| T3 | Compose an authorized end-to-end export and verify all required behavior | accepted T1 and T2 artifacts | report_export/service.py; tests/test_integration.py (new) | pending |

Gate inputs: local Python and supplied fixture files. Verification: standard-library unittest discovery from the project root (`python -m unittest discover -s tests -v`), with cases distinguishing the acceptance clauses above. Checks have not run yet. Do not claim successful implementation from this plan.

The coordinator may update PLAN.md and STATUS.md, record assignments, and commit locally. Workers cannot write shared planning files or perform shared Git operations. Input contract changes are outside this approved implementation scope.
