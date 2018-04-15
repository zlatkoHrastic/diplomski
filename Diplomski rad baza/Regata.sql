CREATE TABLE [dbo].[Regata]
(
	[IdRegata] INT NOT NULL PRIMARY KEY, 
    [Ime] NVARCHAR(MAX) NOT NULL, 
    [DatumPocetak] DATE NOT NULL, 
    [DatumKraj] DATE NOT NULL, 
    [IdLokacija] INT NOT NULL, 
    CONSTRAINT [FK_Regata_Staza] FOREIGN KEY (IdLokacija) REFERENCES [Lokacija]([IdLokacija])
)
