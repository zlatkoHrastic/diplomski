CREATE TABLE [dbo].[Rezultat]
(
	[IdRezultat] INT NOT NULL PRIMARY KEY,
	[IdUtrka] INT NOT NULL, 
    [IdPosada] INT NOT NULL,
	CONSTRAINT [FK_Rezultat_Utrka] FOREIGN KEY ([IdUtrka]) REFERENCES [Utrka]([IdUtrka]),
	CONSTRAINT [FK_Rezultat_Posada] FOREIGN KEY ([IdPosada]) REFERENCES [Posada]([IdPosada]),
	CONSTRAINT [UQ_Rezultat_Posada] UNIQUE (IdUtrka,IdPosada)
)
