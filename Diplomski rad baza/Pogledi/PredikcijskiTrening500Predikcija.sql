CREATE VIEW [dbo].[PredikcijskiTrening500Predikcija]
	AS SELECT Trening.IdVeslac,Trening.VrijemeTreninga,[dbo].[ToTime](4*(MIN([dbo].ToSeconds(DionicaTreninga.Vrijeme))+7)) AS PredvidenoVrijeme
	FROM Trening
	JOIN DionicaTreninga ON DionicaTreninga.IdTrening=Trening.IdTrening
	WHERE IdTipTreninga=2
	Group by Trening.IdVeslac,Trening.VrijemeTreninga
