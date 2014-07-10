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
telnet localhost 8000 < test-template.json
```

You can modify the template as needed, but telnet likes it to fit in one line. It is JSON and shouldn't really be that long for this particular server...

Shoutouts
---------

Andrew: For being the sassiest prick you've ever met when helping me set up the databases. Also, when you ninja-edit this, tell me to at least pull before I get worried when I see a merge appear on a one person project.


Contributions
-------------

If for some unknown reason you feel compelled to contribute to this project, please do so in the form of a pull request.