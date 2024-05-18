


SELECT l.DataReserva, l.Hospede, l.Propriedade, l.Checkin, l.Checkout - l.Checkin as dias_locados, 
       u1.nome as Locatario, u2.nome as anfitriao, p.Diaria
    from Locacao l join propriedade p on l.propriedade = p.id
                   join Usuario u1 on l.hospede = u1.id
                   join Usuario u2 on p.dono = u2.id
    WHERE l.checkin > '20240401';
	
	

