Solutions to the Free Stay Challenge
===

The queries to solve the challenge are found in this folder. There are 2 table structures for solving it: *v1* which is simpler, with one row for each night at the hotel, and *v2* which is more similar to what would be in stored in a hotel database, with check-in and check-out dates for each record.

Customers
---

Both versions of the solution share the same *customers* table, with the following structure:

Column Name | Type
----------- | ----
id          | uuid
full_name   | varchar

The table is populated with the following values:

id                                   | full_name
------------------------------------ | ---------
a3a97187-30eb-48f9-9dff-d1d670495e65 | Jane Doe
0a05782e-b5e7-47a9-b94e-62a0f6d2af05 | John Doe
2ed10ec4-bdcb-422c-9533-cd4944d661b8 | Mark Smith
2b73d1cd-8756-49f3-a977-d1a2de021445 | Mary Smith

**Note:** The names in the table are fictious, and don't correspond to any actual person. They were simply added to simulate customer names.

Solution for v1
---

The table structure for *stays_v1* is the following:

Column Name | Type
----------- | -------
customer_id | uuid
stay_date   | date
free_stay   | boolean

As mentioned, for each night at the hotel, the customer would have a new record in this table. If the client paid for the stay, *free_stay* will be false, otherwise, it will be true.

This is the data for this table in the seed:

customer_id                          | stay_date  | free_stay
------------------------------------ | ---------- | ---------
a3a97187-30eb-48f9-9dff-d1d670495e65 | 2023-01-07 | false
a3a97187-30eb-48f9-9dff-d1d670495e65 | 2023-01-16 | false
a3a97187-30eb-48f9-9dff-d1d670495e65 | 2023-01-18 | false
a3a97187-30eb-48f9-9dff-d1d670495e65 | 2023-05-16 | false
a3a97187-30eb-48f9-9dff-d1d670495e65 | 2023-06-24 | false
a3a97187-30eb-48f9-9dff-d1d670495e65 | 2023-07-18 | true
0a05782e-b5e7-47a9-b94e-62a0f6d2af05 | 2023-01-30 | false
0a05782e-b5e7-47a9-b94e-62a0f6d2af05 | 2023-05-31 | false
0a05782e-b5e7-47a9-b94e-62a0f6d2af05 | 2023-06-07 | false
2b73d1cd-8756-49f3-a977-d1a2de021445 | 2022-08-23 | false
2b73d1cd-8756-49f3-a977-d1a2de021445 | 2022-09-24 | false
2b73d1cd-8756-49f3-a977-d1a2de021445 | 2023-01-11 | false
2b73d1cd-8756-49f3-a977-d1a2de021445 | 2023-03-25 | false
2b73d1cd-8756-49f3-a977-d1a2de021445 | 2023-04-21 | false
2b73d1cd-8756-49f3-a977-d1a2de021445 | 2023-05-07 | false
2b73d1cd-8756-49f3-a977-d1a2de021445 | 2023-05-11 | false
2b73d1cd-8756-49f3-a977-d1a2de021445 | 2023-06-17 | false

The table has been sorted by customers full names and by stay date. The dates represented here is what their values would look like if the seed was run on 2023-08-12.

Based on this data we can see that only Jane Doe made use of 1 free stay, and that the only other customer with available free stays is Mary Smith, who paid for 8 stays in the period.

There are 2 different queries as solutions for this version of the table, one using a subquery and the other one using a CTE (Common Table Expression). Both return the same data, which is the following:

customer_id                          | paid_stays | free_stays | balance
------------------------------------ | ---------- | ---------- | -------
a3a97187-30eb-48f9-9dff-d1d670495e65 | 5          | 1          | 0
0a05782e-b5e7-47a9-b94e-62a0f6d2af05 | 3          | 0          | 0
2ed10ec4-bdcb-422c-9533-cd4944d661b8 | 0          | 0          | 0
2b73d1cd-8756-49f3-a977-d1a2de021445 | 8          | 0          | 1

As expected, Jane Doe is the only one who already used her 1 available free stay. Mary Smith has 1 free stay available and the other customers do not have any free stays yet.

Solution for v2
---

The solution for v2 comprises a different table structure, and the use of a view in addition to the select query. The table was structured to have the values of check-in and check-out dates in the same record, as well as a numeric value for the number of free nights used for each stay.

The table structure for *stays_v2* is the following:

Column Name | Type
----------- | ----
customer_id | uuid
check_in    | date
check_out   | date
free_stays  | numeric

The table is populated with the following seed:

customer_id                          | check_in   | check_out  | free_stays
------------------------------------ | --------   | ---------  | ----------
a3a97187-30eb-48f9-9dff-d1d670495e65 | 2022-08-08 | 2022-08-15 | 1
a3a97187-30eb-48f9-9dff-d1d670495e65 | 2022-09-20 | 2022-09-22 | 0
a3a97187-30eb-48f9-9dff-d1d670495e65 | 2022-12-21 | 2022-12-22 | 0
0a05782e-b5e7-47a9-b94e-62a0f6d2af05 | 2022-09-14 | 2022-09-19 | 0
0a05782e-b5e7-47a9-b94e-62a0f6d2af05 | 2022-12-05 | 2022-12-07 | 0
0a05782e-b5e7-47a9-b94e-62a0f6d2af05 | 2023-07-12 | 2023-07-16 | 0
2b73d1cd-8756-49f3-a977-d1a2de021445 | 2022-04-02 | 2022-04-04 | 0
2b73d1cd-8756-49f3-a977-d1a2de021445 | 2022-02-24 | 2022-02-27 | 0

The dates here also represent what their values would be if the seed was run on 2023-08-12. Since this table has more information per record, it's a little harder to see the actual number of days for each stay, hence, a new view was created in order to have that information ready for our query.

The view is called *stays_v2_summary* and it has the following structure:

Column Name  | Type
-----------  | ----
customer_id  | uuid
stay_days    | numeric
free_stays   | numeric
period_stays | numeric

Here we can see the number of nights for each stay in *stay_days* and the number of free stays used. The last column, *period_stays* count the number of stays which actually matter for awarding free stays, since one requirement in the challenge is that the 5 stays have to be taken within the last year. Having this view in place really helps simplify the query.

The view returns the following data, based on what is available in stays_v2:

customer_id                          | stay_days | free_stays | period_stays
------------------------------------ | --------- | ---------- | ------------
a3a97187-30eb-48f9-9dff-d1d670495e65 | 7         | 1          | 3
a3a97187-30eb-48f9-9dff-d1d670495e65 | 2         | 0          | 2
a3a97187-30eb-48f9-9dff-d1d670495e65 | 1         | 0          | 1
0a05782e-b5e7-47a9-b94e-62a0f6d2af05 | 5         | 0          | 5
0a05782e-b5e7-47a9-b94e-62a0f6d2af05 | 2         | 0          | 2
0a05782e-b5e7-47a9-b94e-62a0f6d2af05 | 4         | 0          | 4
2b73d1cd-8756-49f3-a977-d1a2de021445 | 2         | 0          | 0
2b73d1cd-8756-49f3-a977-d1a2de021445 | 3         | 0          | 0

Based on this we can see that Jane Doe was the only customer who used one free stay, and that John Doe has several stays valid for the period.

The solution to this version is a simple query found in this folder. By running it we get the following data:

customer_id                          | paid_stays | free_stays | balance
------------------------------------ | ---------- | ---------- | -------
a3a97187-30eb-48f9-9dff-d1d670495e65 | 6          | 1          | 0
0a05782e-b5e7-47a9-b94e-62a0f6d2af05 | 11         | 0          | 2
2ed10ec4-bdcb-422c-9533-cd4944d661b8 | 0          | 0          | 0
2b73d1cd-8756-49f3-a977-d1a2de021445 | 0          | 0          | 0

As expected, we can see that Jane Doe used her free stay, John Doe has the right to 2 free stays and the other customers don't have any free stays yet.

Running the solutions
---

As stated in the README file, in order to run this project you need to create the database, run all migrations and the seeds. After that the queries should return similar values, which can be checked against the values in this file. Notice that the results for the queries are not ordered by default, but they can be order manually for simpler comparison. Also notice that the dates will not be the same as the ones in this file, since they are relative to the date in which the script is executed; nevertheless the values for the number of stays, free stays and balance should match.
