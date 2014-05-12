-- calculates win expectancy by
--   inning
--   base state
--   home - away score differential
-- from the pov of the home team

select
    gen.inn_ct
    , gen.outs_ct
    , gen.start_bases_cd
    , gen.run_diff
    , gen.won
    , gen.ttl
    , (gen.won / gen.ttl) * 100 as we
from (
    select
        e.inn_ct
        , e.outs_ct
        , (e.home_score_ct - e.away_score_ct) as run_diff
        , count(*) as ttl
        , sum(case when g.home_score_ct > g.away_score_ct then 1 else 0 end) as won
        , e.start_bases_cd
    from
        events e
        , non_partial_non_home_half_ninth_plus_innings i
        , games g
    where
        e.year_id between 2010 and 2013 
        and e.game_id = i.game_id 
        and e.inn_ct = i.inn_ct 
        and e.bat_home_id = i.bat_home_id
        and e.game_id = g.game_id
        and e.inn_ct <= 9

        -- -- development constraints
        and e.start_bases_cd::numeric = 0
        and e.inn_ct = 1

        -- clamp score range to [-5, 10]
        and (e.home_score_ct - e.away_score_ct) between -5 and 10

        -- from home team's perspective
        and e.bat_team_id = e.home_team_id
    group by
        e.inn_ct
        , e.outs_ct
        , run_diff
        , e.start_bases_cd
) gen
order by
    gen.inn_ct
    , gen.outs_ct
    , gen.start_bases_cd
    , gen.run_diff
