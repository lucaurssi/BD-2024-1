create view PropriedadesDisponíveis as
    select id from propriedade
    where (Disponibilidade_inicio >= '20240101' and Disponibilidade_inicio <= '20241231') 
        or (Disponibilidade_fim >= '20240101' and Disponibilidade_fim <= '20241231') 