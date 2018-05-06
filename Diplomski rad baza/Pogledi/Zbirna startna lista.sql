CREATE VIEW [dbo].[Zbirna startna lista]
	AS SELECT RedniBroj as RedniBrojUtrke,Kategorija.Kratica as Kategorija,Utrka.StartnoVrijeme,RangUtrke.Kratica as Rang, Kategorija.IdRegata
		FROM
		Utrka
		join Kategorija on Utrka.IdKategorija=Kategorija.IdKategorija
		join RangUtrke on Utrka.IdRangUtrke=RangUtrke.IdRangUtrke

