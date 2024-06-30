
INSERT INTO Usuario (id, nome, sobrenome, telefone)
    select host_id, host_name, host_id, '0800'
    from listings
    group by host_id, host_name, host_id;

insert into tipo_usuario (usuario, hospede, dono)
    select id, false, true from usuario;

insert into propriedade (id, nome, cidade, classificacao, nrobanheiros, nroquartos, diaria, min_noite, max_noite, nrocamas, comodidades, dono)
    select id, name, neighbourhood_cleansed, property_type, bathrooms, bedrooms, price, minimum_nights, maximum_nights, beds, amenities, host_id
    from listings;

insert into avalia (id, timestamp, hospede, propriedade, mensagem)
    select id, to_date(date, '%y-%m-%d'), reviewer_id, listing_id, comments
    from reviews;