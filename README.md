# Walmart Business Analytics AI Agent

## Project Objective

This project provides a natural-language interface for Walmart business analytics. A business analyst, manager, or other stakeholder can submit a question in plain English, including imperfect or informal English. The AI agent interprets the request, generates the appropriate analytical query, sends it through the Ghost MCP server to the Walmart PostgreSQL database, and presents the result in a clear business-friendly format.

The user does not need to know SQL, database table names, or query syntax.

Example request:

> Show me the top 10 customers by total spend in each year.

The expected workflow is:

```text
Business question in plain English
              |
              v
          AI agent
  interprets intent and creates SQL
              |
              v
       Ghost MCP server
   provides controlled DB access
              |
              v
    Walmart PostgreSQL database
       raw schema and tables
              |
              v
     Result and business summary
```

## Scope

The project uses Walmart data to answer questions about:

- customers
- orders and order items
- products and sales
- stores
- employees

The current analytical examples are:

1. Top 10 customers by total spend for each year
2. Top 10 products by sales for each year
3. Total number of distinct stores
4. Total number of customers

Each analysis is stored as an individual SQL file with a corresponding database-result file in [walmart_dataset/analysis](walmart_dataset/analysis).

## Technology Stack

- Python 3.13+
- PostgreSQL
- Ghost-managed database and Ghost MCP server
- `uv` for Python project and dependency management
- `psycopg2-binary` for the direct Python database example

## Data and Database Model

The source data files are stored in [walmart_dataset/data](walmart_dataset/data). The table definitions are stored in [walmart_dataset/ddl/walmart_schema.sql](walmart_dataset/ddl/walmart_schema.sql).

The expected PostgreSQL schema is `raw` and contains:

```text
raw.customers
raw.stores
raw.products
raw.employees
raw.orders
raw.order_items
```

The DDL defines the tables. The CSV loading step populates the tables in the Ghost-managed PostgreSQL database.

## Repository Structure

```text
src/data_project/
  __init__.py
  top_customers.py                  # Direct Python query example
walmart_dataset/
  data/                             # Walmart source CSV files
  ddl/walmart_schema.sql            # Database table definitions
  analysis/
    01_top_customers_by_year.sql
    01_top_customers_by_year.result.md
    02_top_products_by_year.sql
    02_top_products_by_year.result.md
    03_store_count.sql
    03_store_count.result.md
    04_customer_count.sql
    04_customer_count.result.md
AGENT_EXECUTION_RECORD.md           # Setup and execution record
```

## Ghost MCP Setup

The development environment was prepared with the following PowerShell commands:

```powershell
irm https://install.ghost.build/install.ps1 | iex
pip install uv
uv init
uv sync
.venv\Scripts\activate
```

After the Ghost tools were added to PATH, the database connection workflow was used to log in, create the Walmart database, and create an API key:

```text
ghost login
ghost create --name walmart_db
ghost api-key create --name "ghost_api_key"
```

The Walmart data was uploaded to the `raw` schema, the DDL was applied, and the ad hoc analyses were run against the database. The API key and database connection details are intentionally excluded from this repository.

## Running the Direct Python Example

Install dependencies with:

```bash
uv sync
```

Set the PostgreSQL connection string in the local environment:

PowerShell:

```powershell
$env:POSTGRE_CONNECTION = "postgresql://user:password@host:5432/database"
```

Run the committed direct-query example:

```bash
uv run python -m data_project.top_customers
```

The ad hoc SQL files can be executed through Ghost MCP SQL or another PostgreSQL client connected to the same database.

## Results and Evidence

The result files contain the outputs obtained from the `raw` schema. For example, the store analysis returned 25 distinct stores, and the customer analysis returned 2,000 customers.

The detailed setup sequence and evidence notes are available in [AGENT_EXECUTION_RECORD.md](AGENT_EXECUTION_RECORD.md). Screenshots from the agent/MCP session may be added under `docs/screenshots/` as supplementary evidence, with all credentials redacted.

## Implementation Status

The database setup, DDL, data model, separate ad hoc SQL analyses, result artifacts, and direct Python query example are represented in this repository. The intended product is an AI agent connected to Ghost MCP that translates plain-English business requests into database-backed analysis.

The agent interaction and MCP connection are runtime capabilities rather than a standalone agent application committed to this repository. The repository therefore documents and preserves the database workflow and reproducible SQL, while the AI agent/MCP client configuration remains in the execution environment.

## Security

Never commit `.env`, PostgreSQL passwords, connection strings, Ghost API keys, or screenshots containing secrets. Rotate any credential that has been exposed.
