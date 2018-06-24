CREATE VIEW [dbo].[Trening864]
	AS 	SELECT Trening.IdVeslac,Trening.VrijemeTreninga,DionicaTreninga.BrojDionice, DionicaTreninga.Vrijeme
	FROM Trening
	JOIN DionicaTreninga ON DionicaTreninga.IdTrening=Trening.IdTrening
	WHERE IdTipTreninga=3
