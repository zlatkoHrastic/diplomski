CREATE TABLE [dbo].[Utrka]
(
	[IdUtrka] INT NOT NULL IDENTITY, 
	[IdKategorija] INT NOT NULL,
    [IdRangUtrke] INT NOT NULL,
	[RedniBroj] SMALLINT NOT NULL, 
    [StartnoVrijeme] DATETIME2 NOT NULL, 
	CONSTRAINT [PK_Utrka] PRIMARY KEY(IdUtrka),
	CONSTRAINT [FK_Utrka_RangUtrke] FOREIGN KEY ([IdRangUtrke]) REFERENCES [RangUtrke]([IdRangUtrke]),
	CONSTRAINT [FK_Utrka_Kategorija] FOREIGN KEY (IdKategorija) REFERENCES [Kategorija]([IdKategorija])
)

GO

CREATE INDEX [IX_Utrka_IdUtrka] ON [dbo].[Utrka] ([IdUtrka])

GO

CREATE INDEX [IX_Utrka_IdKategorija] ON [dbo].[Utrka] ([IdKategorija])

GO

CREATE INDEX [IX_Utrka_IdRangUtrke] ON [dbo].[Utrka] ([IdRangUtrke])
