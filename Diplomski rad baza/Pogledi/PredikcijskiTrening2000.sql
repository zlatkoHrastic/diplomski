CREATE VIEW [dbo].[PredikcijskiTrening2000] AS
	SELECT Trening.IdVeslac,Trening.VrijemeTreninga,DionicaTreninga.BrojDionice, DionicaTreninga.Vrijeme
	FROM Trening
	JOIN DionicaTreninga ON DionicaTreninga.IdTrening=Trening.IdTrening
	WHERE IdTipTreninga=1
