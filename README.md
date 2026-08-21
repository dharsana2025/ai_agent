# Walmart Customer Analytics

This project contains a small PostgreSQL analytics workflow built from the Walmart dataset. It identifies the ten customers with the highest total order spend.

## What Was Implemented

- Added the Walmart CSV datasets under `walmart_dataset/data/`.
- Added PostgreSQL table definitions in `walmart_dataset/ddl/walmart_schema.sql`.
- Added `psycopg2-binary` as the PostgreSQL driver.
- Added a top-customers query in `src/data_project/top_customers.py`.
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

Example output format:

```text
Rank | Customer ID | Customer | Orders | Total Spend
	1 |        1138 | Customer Name <customer@example.com> |     12 | $35,447.22
```

## Ghost MCP / AI Agent Status

The current repository does not contain an AI agent implementation or a Ghost MCP server connection. The query is executed directly by Python through `psycopg2` in `top_customers.py`. A `GHOST_API_KEY` in a local environment file alone does not connect an MCP server.
