WITH Anfitrioes as (SELECT u.id, u.nome, 'SP' as cidade
                        from Locacao l join propriedade p on l.propriedade = p.id
                                       join Usuario u on p.dono = u.id
                            WHERE u.endereço ~'^SP'
                            GROUP BY u.id
                                HAVING count(*) > 2
                            UNION
                    SELECT u.id, u.nome, 'RJ' as cidade
                        from Locacao l join propriedade p on l.propriedade = p.id
                                       join Usuario u on p.dono = u.id
                            WHERE u.endereço ~'^RJ'
                            GROUP BY u.id
                                HAVING count(*) > 2)

SELECT a.nome, a.cidade, count(*)
    from Anfitrioes a join Propriedade p on p.dono = a.id
        GROUP BY a.id, a.nome, a.cidade