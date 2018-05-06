CREATE VIEW [dbo].[RegataBrojPosadaPoKategorijama]
	AS SELECT
Regata.IdRegata, Kategorija.IdKategorija, Kategorija.Kratica, COUNT(Posada.IdPosada) AS 'Broj posada' 
FROM Regata
JOIN Kategorija on Kategorija.IdRegata=Regata.IdRegata
JOIN Posada on Posada.IdKategorija=Kategorija.IdKategorija

GROUP BY Regata.IdRegata, Kategorija.IdKategorija, Kategorija.Kratica
