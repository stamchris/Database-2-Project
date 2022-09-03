-- Question 1
Select  emission.categorie as categorie, count(Visionnage.vid) as "Nombre de Visionnages"
FROM Visionnage
LEFT JOIN  video  ON  Visionnage.vid = video.vid
LEFT JOIN  emission ON video.eid = emission.eid
group by  emission.eid
having Visionnage.vdate < date('now','-14 day');


-- Question 2
Select u.nomu, coalesce(sb.counts,0) as Subs, coalesce(fa.countf,0) as Favorites, coalesce(vi.countv,0) Views
FROM user u
LEFT JOIN (
  select s.uid, count(*) counts
  from Subs_emission s
  group by s.uid
)sb  ON sb.uid = u.uid
LEFT JOIN (
    select f.uid, count(*) countf
    from Fav_Emission f
    group by f.uid
  )fa ON fa.uid = u.uid
  LEFT JOIN (
      select v.uid, count(*) countv
      from Visionnage v
      group by v.uid
    )vi ON vi.uid = u.uid
group by u.uid;


-- Question 3

Select v.nomv ,coalesce(vf.countf,0) FrenchViews, coalesce(vg.countg,0) GermanViews, ABS(coalesce(vf.countf,0) - coalesce(vg.countg,0)) Difference
from video v
left join(
      select vid,count(*) countf
      from Visionnage
      where uid in ( select uid from user where pays='France')
      group by vid
) vf on vf.vid = v.vid
left join(
      select vid,count(*) countg
      from Visionnage
      where uid in ( select uid from user where pays='Allemagne')
      group by vid
) vg on vg.vid = v.vid
order by Difference DESC;
