CREATE FUNCTION [dbo].[Fun_MedaljePoGodinama]
(
	@duljinaPovijesti  int
)
RETURNS @returntable TABLE
(
	GodinaRezultata int,
	IdKlub int,
	Mjesto int,
	BrojMedalja int
)
AS
BEGIN
	INSERT @returntable
		SELECT YEAR(CURRENT_TIMESTAMP)-number AS GodinaRezultata,PripadnostKlubu.IdKlub, rankPosada.Rank,Count (DISTINCT PosadaVeslac.IdPosada) AS BrojMedalja
		FROM RankPoPosadamaPoGodinama AS rankPosada
		JOIN PosadaVeslac ON PosadaVeslac.IdPosada= rankPosada.IdPosada
		JOIN PripadnostKlubu ON PripadnostKlubu.IdVeslac= PosadaVeslac.IdVeslac AND (PripadnostKlubu.DatumPocetak<= rankPosada.DatumRezultata AND (rankPosada.DatumRezultata<=PripadnostKlubu.DatumKraj OR PripadnostKlubu.DatumKraj IS NULL))
		JOIN master..spt_values ON YEAR(CURRENT_TIMESTAMP)-number=YEAR(rankPosada.DatumRezultata)
		FULL OUTER JOIN Klub ON Klub.IdKlub=PripadnostKlubu.IdKlub
		WHERE type='P' AND number BETWEEN 0 AND @duljinaPovijesti
		Group by YEAR(CURRENT_TIMESTAMP)-number,PripadnostKlubu.IdKlub,rankPosada.Rank
	RETURN
END
