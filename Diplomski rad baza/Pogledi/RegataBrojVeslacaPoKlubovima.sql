CREATE VIEW [dbo].[RegataBrojVeslacaPoKlubovima]
	AS SELECT
Regata.IdRegata, PripadnostKlubu.IdKlub,Klub.Ime,COUNT(PosadaVeslac.IdVeslac) AS 'Broj veslaca'
FROM Regata
JOIN Kategorija on Kategorija.IdRegata=Regata.IdRegata
JOIN Posada on Posada.IdKategorija=Kategorija.IdKategorija
join PosadaVeslac on PosadaVeslac.IdPosada=Posada.IdPosada
join PripadnostKlubu on PripadnostKlubu.IdVeslac=PosadaVeslac.IdVeslac AND PripadnostKlubu.DatumPocetak<=Regata.DatumPocetak AND (PripadnostKlubu.DatumKraj >= Regata.DatumPocetak OR PripadnostKlubu.DatumKraj IS NULL)
join Klub on PripadnostKlubu.IdKlub=Klub.IdKlub
GROUP BY Regata.IdRegata, PripadnostKlubu.IdKlub,Klub.Ime
