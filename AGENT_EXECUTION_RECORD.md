# Agent Execution Record

## Purpose

This file records the database workflow and the ad hoc analyses requested for the Walmart dataset. It is intended to make the work reproducible from the repository without storing credentials.

## Workflow Performed

1. Installed Ghost tooling with PowerShell:

   ```powershell
   irm https://install.ghost.build/install.ps1 | iex
   ```

2. Installed `uv`:

   ```powershell
   pip install uv
   ```

3. Initialized and synchronized the Python project:

   ```powershell
   uv init
   uv sync
   .venv\Scripts\activate
   ```

4. Added `uv` and the virtual-environment scripts to the local PATH as needed.

5. Logged in to Ghost and used the Ghost MCP server.

6. Created the Walmart database and an API key locally. Secret values are intentionally excluded from this repository:

   ```text
   ghost create --name walmart_db
   ghost api-key create --name "ghost_api_key"
   ```

7. Inspected the available Ghost databases.

8. Uploaded the Walmart CSV files into the PostgreSQL `raw` schema.

9. Applied the table definitions from `walmart_dataset/ddl/walmart_schema.sql`.

10. Ran ad hoc SQL analysis against the `raw` schema.

## Analysis Evidence

The reproducible SQL is in the individual files under [walmart_dataset/analysis](walmart_dataset/analysis). They contain queries for:

- Top 10 customers by total spend for each order year
- Top 10 products for each order year
- Total number of stores
- Total number of customers

The committed Python implementation for the direct top-customer query is in [src/data_project/top_customers.py](src/data_project/top_customers.py). The separate result files record the database outputs for each analysis.


## Security

Do not commit `.env`, PostgreSQL connection strings, Ghost API keys, or other credentials. Rotate any credential that has been exposed.
