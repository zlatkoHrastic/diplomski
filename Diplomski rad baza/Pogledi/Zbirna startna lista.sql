CREATE VIEW [dbo].[Zbirna startna lista]
	AS SELECT RedniBroj as RedniBrojUtrke,Kategorija.IdKategorija,Kategorija.Kratica as Kategorija,Utrka.IdUtrka,Utrka.StartnoVrijeme,RangUtrke.Kratica as Rang, Kategorija.IdRegata
		FROM
		Utrka
		join Kategorija on Utrka.IdKategorija=Kategorija.IdKategorija
		join RangUtrke on Utrka.IdRangUtrke=RangUtrke.IdRangUtrke

