# Export contract v1 — accepted

Record fields are strings: tenant_id, status, order_id, customer_name, total. Inputs are supplied by the caller; no database or network is needed.

- `report_export.query.select_records(records, tenant_id, status=None)` returns a list of matching records in input order. Match tenant_id exactly; status=None applies no status filter, otherwise match exactly. Do not mutate input or paginate.
- `report_export.csv_format.to_csv(records)` returns UTF-8 bytes. Header: order_id,customer_name,total. Preserve string values, escape with standard CSV rules, include a header for empty input.
- `report_export.service.export_csv(records, tenant_id, can_export, status=None)` returns those CSV bytes. Raise PermissionError before iterating records when can_export is false. Otherwise call select_records followed by to_csv; do not duplicate their logic.

Workers own their module and corresponding new unit test. The coordinator owns service integration and its new integration test. No shared mutable resources beyond the specified files are required. All tests use in-memory data. Only Python's standard library is needed.
