
 -- Mostre a relação inteira

SELECT * FROM Propriedade;



 -- Mostre quantas Propriedades existem de cada classe (casa inteira, etc.)
 
SELECT classificacao , COUNT(*)
	FROM Propriedade 
	GROUP BY Classificacao;
	
	

 -- Mostre quantas Propriedades existem de cada Cidade.
 
SELECT 'SP' as Cidade, COUNT(*)
	from Propriedade
	WHERE endereço ~'^SP'
	UNION
SELECT 'RJ' as Cidade, COUNT(*)
	from Propriedade
	WHERE endereço ~'^RJ';