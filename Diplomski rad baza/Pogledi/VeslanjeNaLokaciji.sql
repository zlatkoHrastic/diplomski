CREATE VIEW [dbo].[VeslanjeNaLokaciji]
	AS SELECT PosadaVeslac.IdVeslac,COUNT(Regata.IdLokacija) AS PutaNaLokaciji,Regata.IdLokacija
FROM PosadaVeslac
JOIN Posada ON Posada.IdPosada=PosadaVeslac.IdPosada
JOIN Kategorija ON Kategorija.IdKategorija=Posada.IdKategorija
JOIN Regata ON Regata.IdRegata=Kategorija.IdRegata
GROUP BY PosadaVeslac.IdVeslac,Regata.IdLokacija
