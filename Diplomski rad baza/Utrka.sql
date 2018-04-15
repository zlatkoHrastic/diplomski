CREATE TABLE [dbo].[Utrka]
(
	[IdUtrka] INT NOT NULL PRIMARY KEY IDENTITY, 
	[IdKategorija] INT NOT NULL,
    [IdRangUtrke] INT NOT NULL,
	[RedniBroj] SMALLINT NOT NULL, 
    [StartnoVrijeme] DATETIME2 NOT NULL, 
	CONSTRAINT [FK_Utrka_RangUtrke] FOREIGN KEY ([IdRangUtrke]) REFERENCES [RangUtrke]([IdRangUtrke]),
	CONSTRAINT [FK_Utrka_Kategorija] FOREIGN KEY (IdKategorija) REFERENCES [Kategorija]([IdKategorija])
)
