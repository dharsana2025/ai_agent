# Result: Top 10 Customers by Year

Executed against the `raw` schema on 2026-08-21.

The query starts from `raw.customers` and uses `LEFT JOIN` to `raw.orders` and `raw.order_items`. Customers are ranked separately within each order year by `total_spend DESC`.

| Year | Rank | Customer ID | Customer | Email | Orders | Total Spend |
|---:|---:|---:|---|---|---:|---:|
| 2026 | 1 | 1138 | Spencer Barber | richardcampbell@example.net | 12 | 35447.22 |
| 2026 | 2 | 925 | Vanessa Juarez | patrickshelton@example.org | 14 | 34157.29 |
| 2026 | 3 | 1260 | Shannon Hanson | cindy68@example.com | 12 | 31721.66 |
| 2026 | 4 | 532 | Colton Hendrix | edwardcynthia@example.net | 11 | 31708.66 |
| 2026 | 5 | 908 | Kelly Ruiz | nathanlevy@example.net | 8 | 30498.99 |
| 2026 | 6 | 30 | Sarah Young | dwilliams@example.org | 14 | 29952.89 |
| 2026 | 7 | 1370 | Anthony Peterson | crystal93@example.org | 9 | 29595.41 |
| 2026 | 8 | 1844 | Cheryl Thomas | nicholaswilson@example.com | 11 | 28269.63 |
| 2026 | 9 | 809 | Anthony Lester | rogeroneal@example.net | 10 | 27398.12 |
| 2026 | 10 | 1458 | Amanda Scott | brandonmurray@example.org | 12 | 26898.65 |
| 2027 | 1 | 842 | Jessica Davis | karicastillo@example.net | 1 | 4345.61 |
| 2027 | 2 | 884 | David Sanchez | erinbrown@example.net | 1 | 4076.66 |
| 2027 | 3 | 739 | Deborah Carter | myoung@example.net | 1 | 2628.59 |
| 2027 | 4 | 1362 | Joe Brown | phillipsjeffrey@example.net | 1 | 2613.81 |
| 2027 | 5 | 1047 | Calvin Richards | josedavis@example.org | 1 | 2143.16 |
| 2027 | 6 | 1471 | Robert Davila | gabrielponce@example.net | 1 | 2140.55 |
| 2027 | 7 | 1713 | Michele Brooks | natalie24@example.org | 1 | 2116.14 |
| 2027 | 8 | 1778 | Ann Marks | michael34@example.net | 1 | 1879.87 |
| 2027 | 9 | 1282 | Austin Hampton | douglasnewton@example.net | 1 | 1725.84 |
| 2027 | 10 | 1715 | Michelle Cruz | melissa69@example.org | 1 | 1551.08 |
