CREATE VIEW [dbo].[RegataVremenaPoUtrkama]
	AS SELECT
Regata.IdRegata, Kategorija.IdKategorija, Utrka.IdUtrka, Posada.IdPosada, Rezultat.Staza,Posada.Kratica,ProlaznoVrijeme.Vrijeme,KontrolnaTocka.Udaljenost
FROM Regata
JOIN Kategorija on Kategorija.IdRegata=Regata.IdRegata
JOIN Posada on Posada.IdKategorija=Kategorija.IdKategorija
JOIN Utrka on Kategorija.IdKategorija=Utrka.IdKategorija 
JOIN Rezultat on Rezultat.IdPosada=Posada.IdPosada
JOIN ProlaznoVrijeme on ProlaznoVrijeme.IdRezultat=Rezultat.IdRezultat
JOIN KontrolnaTocka on KontrolnaTocka.IdKontrolnaTocka=ProlaznoVrijeme.IdKontrolnaTocka
