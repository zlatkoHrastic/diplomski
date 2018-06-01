CREATE VIEW [dbo].[VeslaciUParu]
	AS SELECT Veslac.IdVeslac, VeslaoSa.IdVeslac AS VeslaoSaId, VeslaoSa.Ime+ ' '+ VeslaoSa.Prezime AS VeslaoSa,COUNT(*) AS VeslaliPuta
FROM Veslac 
JOIN PosadaVeslac ON PosadaVeslac.IdVeslac=Veslac.IdVeslac
JOIN PosadaVeslac AS IstaPosada ON IstaPosada.IdPosada=PosadaVeslac.IdPosada 
JOIN Veslac AS VeslaoSa ON VeslaoSa.IdVeslac=IstaPosada.IdVeslac
WHERE Veslac.IdVeslac <> VeslaoSa.IdVeslac
GROUP BY Veslac.IdVeslac,VeslaoSa.IdVeslac,VeslaoSa.Ime,VeslaoSa.Prezime
