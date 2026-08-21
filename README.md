# Walmart Customer Analytics

## AI Agent-Assisted Project

This project was completed with assistance from an AI coding agent. The agent helped to:

- initialize and configure the Python project with `uv`
- install the PostgreSQL dependency
- inspect the Ghost-managed databases
- load the Walmart CSV data into the PostgreSQL `raw` schema
- create tables from `walmart_dataset/ddl/walmart_schema.sql`
- write and run ad hoc SQL analysis
- implement the top-customers Python query
- document the workflow and results for reproducibility

The detailed workflow and evidence notes are available in [AGENT_EXECUTION_RECORD.md](AGENT_EXECUTION_RECORD.md).

This project contains a PostgreSQL analytics workflow built from the Walmart dataset. Data was loaded into a Ghost-managed PostgreSQL database, tables were created from the DDL, and ad hoc analysis was run through the database connection.

## What Was Implemented

- Added the Walmart CSV datasets under `walmart_dataset/data/`.
- Added PostgreSQL table definitions in `walmart_dataset/ddl/walmart_schema.sql`.
- Added `psycopg2-binary` as the PostgreSQL driver.
- Added a top-customers query in `src/data_project/top_customers.py`.
- Added reproducible ad hoc SQL in `walmart_dataset/analysis/adhoc_analysis.sql` for customer, product, store, and customer-count analysis.
- The query joins customers, orders, and order items, then returns:
  - customer ID and name
  - email address
  - number of orders
  - total spend
- Results are sorted by total spend in descending order and limited to ten customers.

## Project Structure

```text
src/data_project/
  __init__.py
  top_customers.py
walmart_dataset/
  data/                 # Source CSV files
  ddl/walmart_schema.sql # PostgreSQL table definitions
	analysis/adhoc_analysis.sql # Reproducible ad hoc analysis
AGENT_EXECUTION_RECORD.md # Workflow and evidence record
```

## Requirements

- Python 3.13 or later
- PostgreSQL database containing the Walmart tables
- `uv` for dependency and project management

Install the project dependencies with:

```bash
uv sync
```

## Database Setup

Run `walmart_dataset/ddl/walmart_schema.sql` against PostgreSQL, then load the CSV files into the corresponding tables. The query currently expects the tables in the `raw` schema:

```text
raw.customers
raw.orders
raw.order_items
```

The DDL creates the table definitions but does not load the CSV data or create the `raw` schema automatically.

## Ghost Database Workflow

The following workflow was used to provision and access the database:

```powershell
irm https://install.ghost.build/install.ps1 | iex
pip install uv
uv init
uv sync
.venv\Scripts\activate
```

After adding the required executables to PATH, Ghost was used to log in, create the database, and create an API key:

```text
ghost login
ghost create --name walmart_db
ghost api-key create --name "ghost_api_key"
```

The Walmart CSV files were uploaded to the `raw` schema, the DDL was applied, and the ad hoc queries were run through the Ghost PostgreSQL connection. The analysis statements are preserved in [walmart_dataset/analysis/adhoc_analysis.sql](walmart_dataset/analysis/adhoc_analysis.sql).

## Configuration

Set the PostgreSQL connection string in the shell before running the script:

PowerShell:

```powershell
$env:POSTGRE_CONNECTION = "postgresql://user:password@host:5432/database"
```

Bash:

```bash
export POSTGRE_CONNECTION="postgresql://user:password@host:5432/database"
```

The local `.env` file is ignored by Git and is not loaded automatically by the Python script. Do not commit database passwords or API keys.

## Run the Query

```bash
uv run python -m data_project.top_customers
```

To run all ad hoc analyses directly against PostgreSQL, use the SQL file with Ghost MCP SQL or a PostgreSQL client after setting `POSTGRE_CONNECTION`.

Example output format:

```text
Rank | Customer ID | Customer | Orders | Total Spend
   1 |        1138 | Customer Name <customer@example.com> |     12 | $35,447.22
```

## Evidence and AI Agent Usage

[AGENT_EXECUTION_RECORD.md](AGENT_EXECUTION_RECORD.md) records the requested setup sequence and separates repository evidence from screenshot-based evidence. The committed Python query is executed directly through `psycopg2`; the ad hoc SQL can also be run through Ghost MCP SQL. The repository does not contain a standalone AI-agent application or a committed Ghost MCP configuration. A local `GHOST_API_KEY` alone does not prove or establish an MCP connection.
