WITH anfitrioes as (SELECT min(u.Data_Nascimento) as min, max(u.Data_Nascimento) as max
                        from Usuario u join propriedade p on u.id = p.dono)

SELECT u.nome,  (u.Data_Nascimento < a.max) as jovem, 
                (u.Data_Nascimento < a.min) as super_jovem
    from Usuario u join Locacao l on u.id = l.hospede, anfitrioes a
    GROUP BY u.nome, u.Data_Nascimento, a.max, a.min