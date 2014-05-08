-- generates runexp numbers by
--   ball/strike count
--   innings

select
    e.inn_ct
    , sum((fate_runs_ct + event_runs_ct) * p.c00) / sum(p.c00)::float as re_00
    , sum((fate_runs_ct + event_runs_ct) * p.c01) / sum(p.c01)::float as re_01
    , sum((fate_runs_ct + event_runs_ct) * p.c02) / sum(p.c02)::float as re_02
    , sum((fate_runs_ct + event_runs_ct) * p.c10) / sum(p.c10)::float as re_10
    , sum((fate_runs_ct + event_runs_ct) * p.c11) / sum(p.c11)::float as re_11
    , sum((fate_runs_ct + event_runs_ct) * p.c12) / sum(p.c12)::float as re_12
    , sum((fate_runs_ct + event_runs_ct) * p.c20) / sum(p.c20)::float as re_20
    , sum((fate_runs_ct + event_runs_ct) * p.c21) / sum(p.c21)::float as re_21
    , sum((fate_runs_ct + event_runs_ct) * p.c22) / sum(p.c22)::float as re_22
    , sum((fate_runs_ct + event_runs_ct) * p.c30) / sum(p.c30)::float as re_30
    , sum((fate_runs_ct + event_runs_ct) * p.c31) / sum(p.c31)::float as re_31
    , sum((fate_runs_ct + event_runs_ct) * p.c32) / sum(p.c32)::float as re_32
from
    events e
    , non_partial_non_home_half_ninth_plus_innings i
    , pitchseq p
where
    e.year_id between 2010 and 2013 
    and e.bat_event_fl = 'T'
    and e.game_id = i.game_id 
    and e.inn_ct = i.inn_ct 
    and e.bat_home_id = i.bat_home_id
    and e.pitch_seq_tx = p.pitch_seq_tx
    and e.inn_ct::numeric <= 11
group by
    e.inn_ct
;
