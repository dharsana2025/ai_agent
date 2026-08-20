"""Retrieve the ten customers with the highest total order spend."""

import os

import psycopg2


QUERY = """
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        COUNT(DISTINCT o.order_id) AS order_count,
        ROUND(SUM(oi.line_amount), 2) AS total_spend
    FROM raw.customers AS c
    JOIN raw.orders AS o ON o.customer_id = c.customer_id
    JOIN raw.order_items AS oi ON oi.order_id = o.order_id
    GROUP BY c.customer_id, c.first_name, c.last_name, c.email
    ORDER BY total_spend DESC, c.customer_id
    LIMIT 10;
"""


def get_top_customers() -> list[tuple]:
    """Return the ten customers ranked by total order spend."""
    connection_string = os.getenv("POSTGRE_CONNECTION")
    if not connection_string:
        raise RuntimeError(
            "POSTGRE_CONNECTION is not set. Load the database connection string "
            "from .env before running this script."
        )

    with psycopg2.connect(connection_string) as connection:
        with connection.cursor() as cursor:
            cursor.execute(QUERY)
            return cursor.fetchall()


def main() -> None:
    print("Rank | Customer ID | Customer | Orders | Total Spend")
    for rank, customer in enumerate(get_top_customers(), start=1):
        customer_id, first_name, last_name, email, order_count, total_spend = customer
        print(
            f"{rank:>4} | {customer_id:>11} | "
            f"{first_name} {last_name} <{email}> | "
            f"{order_count:>6} | ${total_spend:,.2f}"
        )


if __name__ == "__main__":
    main()
