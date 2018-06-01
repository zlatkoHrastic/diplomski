CREATE VIEW [dbo].[MedaljePoGodinama]
	AS SELECT rangBroj.broj AS Mjesto,YEAR(CURRENT_TIMESTAMP)-brojGodina.broj AS Godina,Klub.IdKlub, ISNULL(Medalje.BrojMedalja,0) AS BrojMedalja
FROM Sekvenca(3) AS rangBroj
FULL OUTER JOIN Sekvenca(5) AS brojGodina ON 1=1
FULL OUTER JOIN Klub ON 1=1
LEFT JOIN Fun_MedaljePoGodinama(5)AS Medalje on Medalje.GodinaRezultata=YEAR(CURRENT_TIMESTAMP)-brojGodina.broj AND Klub.IdKlub=Medalje.IdKlub AND rangBroj.broj=Medalje.Mjesto
Where
       rangBroj.broj BETWEEN 1 AND 3
	  AND brojGodina.broj BETWEEN 0 AND 5
