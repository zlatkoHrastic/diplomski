CREATE TABLE [dbo].[ProlaznoVrijeme]
(
	[IdProlaznoVrijeme] INT NOT NULL IDENTITY, 
    [IdKontrolnaTocka] INT NOT NULL, 
    [IdRezultat] INT NOT NULL, 
    [Vrijeme] TIME(3) NULL,
	CONSTRAINT [PK_ProlaznoVrijeme] PRIMARY KEY(IdProlaznoVrijeme),
	CONSTRAINT [FK_Vrijeme_KontrolnaTocka] FOREIGN KEY (IdKontrolnaTocka) REFERENCES [KontrolnaTocka](IdKontrolnaTocka),
	CONSTRAINT [FK_Vrijeme_Rezultat] FOREIGN KEY (IdRezultat) REFERENCES [Rezultat](IdRezultat),
	CONSTRAINT [UQ_KontrolnaTocka_Rezultat] UNIQUE (IdKontrolnaTocka,IdRezultat)
)

GO

CREATE INDEX [IX_ProlaznoVrijeme_IdProlaznoVrijeme] ON [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme])

GO

CREATE INDEX [IX_ProlaznoVrijeme_IdKontrolnaTocka] ON [dbo].[ProlaznoVrijeme] ([IdKontrolnaTocka])

GO

CREATE INDEX [IX_ProlaznoVrijeme_IdRezultat] ON [dbo].[ProlaznoVrijeme] ([IdRezultat])
