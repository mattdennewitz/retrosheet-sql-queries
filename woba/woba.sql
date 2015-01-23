-- fangraphs batting woba (using their 2014 constants)
--
-- woba formula via http://www.fangraphs.com/library/offense/woba/
-- weights via http://www.fangraphs.com/guts.aspx
-- 
-- note: fangraphs' "bb" column counts walks + intentional walks,
--       where retrosheet distinguishes.

select
    s.*
    , round((
        (
            (.689 * s.bb)
            + (.722 * s.hbp)
            + (.892 * s._1b)
            + (1.283 * s._2b)
            + (1.635 * s._3b)
            + (2.135 * s.hr)
        ) / (s.ab + s.bb + s.sf + s.hbp)
    ), 3) as woba
from (
    select
        bat_id
        , sum(case when (pa_new_fl = 'T' and pa_trunc_fl = 'F') then 1 else 0 end) as pa
        , sum(case when ab_fl = 'T' then 1 else 0 end) ab
        , sum(case when event_cd = '14' then 1 else 0 end) as bb
        , sum(case when event_cd = '15' then 1 else 0 end) as ibb
        , sum(case when event_cd = '16' then 1 else 0 end) as hbp
        , sum(case when event_cd = '20' then 1 else 0 end) as _1b
        , sum(case when event_cd = '21' then 1 else 0 end) as _2b
        , sum(case when event_cd = '22' then 1 else 0 end) as _3b
        , sum(case when event_cd = '23' then 1 else 0 end) as hr
        , sum(case when sf_fl = 'T' then 1 else 0 end) as sf
        , sum(case when bat_safe_err_fl = 'T' then 1 else 0 end) as rboe
    from
        events e
        , games g
    where
        e.game_id = g.game_id
        and extract(year from g.game_dt::text::date) = 2014
    group by
        bat_id
) s
where
    s.ab > 0
order by
    s.bat_id
;
