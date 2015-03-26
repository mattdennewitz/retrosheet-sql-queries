-- calculates run expectancy by inning, out, and base state,
-- over three years

select
    e.inn_ct           -- current inning
    , e.outs_ct        -- outs before this event
    , e.start_bases_cd -- base-state at beginning of event
    , round( sum(fate_runs_ct + event_runs_ct)::numeric / count(*)::numeric , 3) as rexp
from
    events e
    , games g
    , non_partial_non_home_half_ninth_plus_innings i
where
    extract('year' from g.game_dt::text::date) between 2011 and 2014
    and e.bat_event_fl = 'T'
    and e.game_id = i.game_id 
    and e.inn_ct = i.inn_ct 
    and e.bat_home_id = i.bat_home_id
    and e.inn_ct <= 9
    and g.game_id = e.game_id
group by
    e.inn_ct
    , e.outs_ct
    , e.start_bases_cd
order by
    e.inn_ct
    , e.outs_ct
    , e.start_bases_cd
;
