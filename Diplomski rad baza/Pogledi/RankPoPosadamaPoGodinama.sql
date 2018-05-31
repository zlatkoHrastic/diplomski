CREATE VIEW [dbo].[RankPoPosadamaPoGodinama]
	AS  SELECT Rezultat.IdPosada,Utrka.StartnoVrijeme AS DatumRezultata, RANK() OVER (PARTITION BY Utrka.IdUtrka ORDER BY ProlaznoVrijeme.Vrijeme )AS Rank
FROM Utrka
JOIN Rezultat ON Rezultat.IdUtrka=Utrka.IdUtrka
JOIN ProlaznoVrijeme ON ProlaznoVrijeme.IdRezultat=Rezultat.IdRezultat
WHERE Utrka.IdRangUtrke=1 AND ProlaznoVrijeme.IdKontrolnaTocka=4