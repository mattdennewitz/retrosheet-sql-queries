-- calculates win expectancy by
--   inning
--   base state
--   home - away score differential
-- from the pov of the home team

select
    e.inn_ct
    , e.outs_ct
    , (e.home_score_ct::numeric - e.away_score_ct::numeric) as score
    , count(*) as ttl
    , avg(case when g.home_score_ct::numeric > g.away_score_ct::numeric then 1 else 0 end) as won
    , e.start_bases_cd
from
    events e
    , non_partial_non_home_half_ninth_plus_innings i
    , games g
where
    e.year_id between 2010 and 2013 
    and e.bat_event_fl = 'T'
    and e.game_id = i.game_id 
    and e.inn_ct = i.inn_ct 
    and e.bat_home_id = i.bat_home_id
    and e.game_id = g.game_id
    and e.inn_ct::numeric <= 9

    -- clamp score range to [-5, 10]
    and (e.home_score_ct::numeric - e.away_score_ct::numeric) between -5 and 10

    -- from home team's perspective
    and e.bat_team_id = e.home_team_id
group by
    e.inn_ct
    , e.outs_ct
    , score
    , e.start_bases_cd
having
    -- let's not care about 18-0 games, yknow?
    count(*) > 1
order by
    e.inn_ct
    , e.outs_ct
    , score
    , e.start_bases_cd
;
