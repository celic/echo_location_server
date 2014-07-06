Echo Location Server
====================

Set Up
------

The server uses Postgres for its database. It expects a database 'points' to exist, with a table 'points' to store the points... I'll fix the name if I find a reason to store anything else in the database... yeah...

If you want to use Rspec you will have to set up the testing database, 'points_test' again with a table 'points'.

The databases are simple, run the following commands to create one and a table inside:

```
psql postgres
CREATE DATABASE points;
\q
psql points
CREATE TABLE points(id BIGSERIAL, lat DECIMAL, lon DECIMAL);
```

Run
---

To run, first make sure you run:

```
bundle install
rake
ruby run_server.rb
```

From another window run:

```
telnet localhost 8000 < test.json
```

Shoutouts
---------

Andrew: For being the sassiest prick you've ever met when helping me set up the databases.