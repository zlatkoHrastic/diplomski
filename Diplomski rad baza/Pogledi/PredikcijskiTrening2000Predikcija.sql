CREATE VIEW [dbo].[PredikcijskiTrening2000Predikcija]
	AS 	SELECT Trening.IdVeslac,Trening.VrijemeTreninga,[dbo].[ToTime](AVG([dbo].ToSeconds(DionicaTreninga.Vrijeme))+10) AS PredvidenoVrijeme
	FROM Trening
	JOIN DionicaTreninga ON DionicaTreninga.IdTrening=Trening.IdTrening
	WHERE IdTipTreninga=1
	Group by Trening.IdVeslac,Trening.VrijemeTreninga
