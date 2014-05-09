-- generates runexp numbers by inning

select
    e.inn_ct
    , sum(fate_runs_ct + event_runs_ct) / count(*)::float as re
from
    events e
    , non_partial_non_home_half_ninth_plus_innings i
where
    e.year_id between 2010 and 2013 
    and e.bat_event_fl = 'T'
    and e.game_id = i.game_id 
    and e.inn_ct = i.inn_ct 
    and e.bat_home_id = i.bat_home_id
group by
    e.inn_ct
;
