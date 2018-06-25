CREATE TABLE [dbo].[Regata]
(
	[IdRegata] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Ime] NVARCHAR(MAX) NOT NULL, 
    [DatumPocetak] DATE NOT NULL, 
    [DatumKraj] DATE NOT NULL, 
    [IdLokacija] INT NOT NULL, 
    CONSTRAINT [FK_Regata_Lokacija] FOREIGN KEY (IdLokacija) REFERENCES [Lokacija]([IdLokacija])
)

GO

CREATE INDEX [IX_Regata_IdRegata] ON [dbo].[Regata] ([IdRegata])

GO

CREATE INDEX [IX_Regata_IdLokacija] ON [dbo].[Regata] ([IdLokacija])
