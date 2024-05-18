
SELECT ROUND(AVG(p.Diaria), 2) as locacao_AVG
    from locacao l join propriedade p 
    on l.propriedade = p.id;
	
with loc as (SELECT  Propriedade as prop, 
                     EXTRACT(YEAR FROM checkin) as Year, 
                     EXTRACT(MONTH FROM checkin) as Month 
                     from locacao)

SELECT l.year, l.month, ROUND(AVG(p.Diaria), 2) as avg, count(*)
        from loc l join propriedade p
        on l.prop = p.id
        GROUP BY l.year, l.month
        ORDER BY l.year, l.month