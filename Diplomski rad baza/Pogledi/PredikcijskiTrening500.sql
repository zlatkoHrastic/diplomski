CREATE VIEW [dbo].[PredikcijskiTrening500]
	AS 	SELECT Trening.IdVeslac,Trening.VrijemeTreninga,DionicaTreninga.BrojDionice, DionicaTreninga.Vrijeme
	FROM Trening
	JOIN DionicaTreninga ON DionicaTreninga.IdTrening=Trening.IdTrening
	WHERE IdTipTreninga=2