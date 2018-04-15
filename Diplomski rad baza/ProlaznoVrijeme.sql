CREATE TABLE [dbo].[ProlaznoVrijeme]
(
	[IdProlaznoVrijeme] INT NOT NULL PRIMARY KEY, 
    [IdKontrolnaTocka] INT NOT NULL, 
    [IdRezultat] INT NOT NULL, 
    [Vrijeme] TIME NULL,
	CONSTRAINT [FK_Vrijeme_KontrolnaTocka] FOREIGN KEY (IdKontrolnaTocka) REFERENCES [KontrolnaTocka](IdKontrolnaTocka),
	CONSTRAINT [FK_Vrijeme_Rezultat] FOREIGN KEY (IdRezultat) REFERENCES [Rezultat](IdRezultat),
	CONSTRAINT [UQ_KontrolnaTocka_Rezultat] UNIQUE (IdKontrolnaTocka,IdRezultat)
)
