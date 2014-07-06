Echo Location Server
====================

Set Up
------

The server uses Postgres for its database. It expects a database 'points' to exist, with a table 'points' to store the points... I'll fix the name if I find a reason to store anything else in the database... yeah...

If you want to use Rspec you will have to set up the testing database, 'points_test' again with a table 'points'.

Run
---

To run, first make sure you run:

<code>
bundle install
</code>

<code>
rake
</code>

<code>
ruby run_server.rb
</code>

Shoutouts
---------

Andrew: For being the sassiest prick you've ever met when helping me set up the databases.