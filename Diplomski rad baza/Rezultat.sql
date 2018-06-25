CREATE TABLE [dbo].[Rezultat]
(
	[IdRezultat] INT NOT NULL PRIMARY KEY IDENTITY,
	[IdUtrka] INT NOT NULL, 
    [IdPosada] INT NOT NULL,
	[Staza] TINYINT NOT NULL, 
    CONSTRAINT [FK_Rezultat_Utrka] FOREIGN KEY ([IdUtrka]) REFERENCES [Utrka]([IdUtrka]),
	CONSTRAINT [FK_Rezultat_Posada] FOREIGN KEY ([IdPosada]) REFERENCES [Posada]([IdPosada]),
	CONSTRAINT [UQ_Rezultat_Posada] UNIQUE (IdUtrka,IdPosada)
)

GO

CREATE INDEX [IX_Rezultat_IdRezultat] ON [dbo].[Rezultat] ([IdRezultat])

GO

CREATE INDEX [IX_Rezultat_IdUtrka] ON [dbo].[Rezultat] ([IdUtrka])

GO

CREATE INDEX [IX_Rezultat_IdPosada] ON [dbo].[Rezultat] ([IdPosada])
