CREATE TABLE [dbo].[Posada]
(
	[IdPosada] INT NOT NULL IDENTITY, 
    [IdKategorija] INT NOT NULL, 
    [Kratica] NCHAR(20) NOT NULL, 
	CONSTRAINT [PK_Posada] PRIMARY KEY(IdPosada),
    CONSTRAINT [FK_Posada_Kategorija] FOREIGN KEY ([IdKategorija]) REFERENCES [Kategorija](IdKategorija),
	CONSTRAINT [UQ_Kategorija_Kratica] UNIQUE (IdKategorija,Kratica)
	)

GO

CREATE INDEX [IX_Posada_IdPosada] ON [dbo].[Posada] ([IdPosada])

GO

CREATE INDEX [IX_Posada_IdKategorija_Kratica] ON [dbo].[Posada] ([IdKategorija],[Kratica])
