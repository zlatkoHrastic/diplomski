CREATE TABLE [dbo].[Regata]
(
	[IdRegata] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Ime] NVARCHAR(MAX) NOT NULL, 
    [DatumPocetak] DATE NOT NULL, 
    [DatumKraj] DATE NOT NULL, 
    [IdLokacija] INT NOT NULL, 
    CONSTRAINT [FK_Regata_Lokacija] FOREIGN KEY (IdLokacija) REFERENCES [Lokacija]([IdLokacija])
)
