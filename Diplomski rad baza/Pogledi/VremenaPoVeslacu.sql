CREATE VIEW [dbo].[VremenaPoVeslacu]
	AS SELECT Veslac.Ime, Veslac.Prezime,Veslac.IdVeslac, ProlaznoVrijeme.Vrijeme, Regata.DatumPocetak, Regata.Ime AS ImeRegate, Kategorija.Kratica,KontrolnaTocka.Udaljenost
FROM Veslac
JOIN PosadaVeslac on PosadaVeslac.IdVeslac=Veslac.IdVeslac
JOIN Rezultat on Rezultat.IdPosada=PosadaVeslac.IdPosada
JOIN ProlaznoVrijeme ON ProlaznoVrijeme.IdRezultat=Rezultat.IdRezultat
JOIN KontrolnaTocka ON KontrolnaTocka.IdKontrolnaTocka=ProlaznoVrijeme.IdKontrolnaTocka
JOIN Posada on Posada.IdPosada=PosadaVeslac.IdPosada
JOIN Kategorija on Kategorija.IdKategorija=Posada.IdKategorija
JOIN Regata on Regata.IdRegata=Kategorija.IdRegata
