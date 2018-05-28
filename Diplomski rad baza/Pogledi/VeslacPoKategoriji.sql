CREATE VIEW [dbo].[VeslacPoKategoriji]
	AS SELECT PosadaVeslac.IdVeslac,COUNT(Kategorija.Kratica) AS PutaVeslao,Kategorija.Kratica
FROM PosadaVeslac
JOIN Posada ON Posada.IdPosada=PosadaVeslac.IdPosada
JOIN Kategorija ON Kategorija.IdKategorija=Posada.IdKategorija
GROUP BY PosadaVeslac.IdVeslac, Kategorija.Kratica
