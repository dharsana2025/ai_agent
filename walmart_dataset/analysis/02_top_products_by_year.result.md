# Result: Top 10 Products by Year

Executed against the Ghost PostgreSQL `raw` schema on 2026-08-21.

Source tables used:

- `raw.products`
- `raw.order_items`

The query uses `order_items.created_timestamp` for the year and includes negative `line_amount` values in the aggregation. The database currently contains no negative `line_amount` records, so no negative product sales are present.

| Year | Rank | Product ID | Product | Units Sold | Total Sales |
|---:|---:|---:|---|---:|---:|
| 2026 | 1 | 142 | Arm Product | 201 | 60900.45 |
| 2026 | 2 | 29 | Left Product | 220 | 60838.21 |
| 2026 | 3 | 357 | Quickly Product | 225 | 58573.26 |
| 2026 | 4 | 355 | East Product | 199 | 55132.95 |
| 2026 | 5 | 466 | Board Product | 211 | 54114.11 |
| 2026 | 6 | 38 | Everyone Product | 194 | 53742.35 |
| 2026 | 7 | 175 | Attack Product | 179 | 53565.31 |
| 2026 | 8 | 5 | Each Product | 179 | 53081.77 |
| 2026 | 9 | 473 | Hospital Product | 209 | 52231.31 |
| 2026 | 10 | 127 | Mean Product | 183 | 52107.68 |

## Negative Sales Check

| Check | Result |
|---|---:|
| Negative order-item rows | 0 |
| Negative total sales products | 0 |
