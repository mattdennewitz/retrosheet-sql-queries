# Retrosheet Run Expectancy Queries

Queries used to illustrate generating run expectancy from a Retrosheet database.

This assumes that you've got:

- a Retrosheet database, which is more likely to be a database
  of Chadwick-parsed Retrosheet events and games
- a table of pitch sequences expanded into individual counts seen in the at-bat.
  To generate this, please see
  [retrosheet-pitch-sequences](https://github.com/mattdennewitz/retrosheet-pitch-sequences)

These queries were written for and run in PostgreSQL 9.3.

## Notes

### Innings

I've capped the latest inning in the queries to the 11th. If you'd like
to expand to bear witness to the marginal differences, please do.
Be ready to handle div-by-0 errors, though, as not all
inning-base-state-pitch-count combos have data.

### Want per year?

Alter the queries to select and group by `e.year_id`.
You won't be disappointed.

## Thanks

Thanks to @harrypav for sanity checks.
