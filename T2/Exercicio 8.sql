select u.nome, u.cidade, count(*)
    from usuario u join propriedade p
    on u.id = p.dono
    group by u.nome, u.cidade
        having count(*) > 3;