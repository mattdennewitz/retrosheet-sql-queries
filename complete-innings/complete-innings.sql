create table
    non_partial_non_home_half_ninth_plus_innings
as
select
    game_id
    , inn_ct
    , bat_home_id
from
    events e
where
    inn_end_fl = 'T'
    and event_outs_ct + outs_ct = 3
    and (case when inn_ct = 9 and bat_home_id::numeric = 1 then 1 else 0 end) = 0
;
