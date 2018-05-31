CREATE FUNCTION [dbo].[Fun_BrojVeslacaPoKlubovimaPoGodinama]
(
	@duljinaPovijesti int
)
RETURNS @returntable TABLE
(
	pocetakSezone date,
	idKlub int,
	brojLjudi int
)
AS
BEGIN
	INSERT @returntable
	SELECT DATEFROMPARTS(YEAR(CURRENT_TIMESTAMP)-number,1,1) AS pocetakSezone,Klub.IdKlub,Count(PripadnostKlubu.IdKlub) brojLjudi
		FROM master..spt_values
		FULL OUTER JOIN Klub ON 1=1
		LEFT OUTER JOIN PripadnostKlubu ON PripadnostKlubu.DatumPocetak<=DATEFROMPARTS(YEAR(CURRENT_TIMESTAMP)-number,1,1) AND (DATEFROMPARTS(YEAR(CURRENT_TIMESTAMP)-number,1,1)<=PripadnostKlubu.DatumKraj OR PripadnostKlubu.DatumKraj IS NULL) AND PripadnostKlubu.IdKlub=klub.IdKlub
		WHERE type='P'
		AND number BETWEEN 0 AND @duljinaPovijesti
		GROUP BY DATEFROMPARTS(YEAR(CURRENT_TIMESTAMP)-number,1,1),Klub.IdKlub
	RETURN
END
