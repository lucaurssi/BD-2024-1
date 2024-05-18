WITH locatarios as (Select u.id, u.nome, count(*) as viagens from Usuario u join Locacao l
                            on l.hospede = u.id
                            GROUP BY u.id, u.nome)

SELECT l.nome, l.viagens, count(*) as propriedades from locatarios l join propriedade p
        on l.id = p.dono
        GROUP BY l.nome, l.viagens
;