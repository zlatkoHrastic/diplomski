CREATE TABLE [dbo].[Regata]
(
	[IdRegata] INT NOT NULL PRIMARY KEY, 
    [Ime] NVARCHAR(MAX) NOT NULL, 
    [DatumPocetak] DATE NOT NULL, 
    [DatumKraj] DATE NOT NULL, 
    [IdStaza] INT NOT NULL, 
    CONSTRAINT [FK_Regata_Staza] FOREIGN KEY (IdStaza) REFERENCES [Staza]([IdStaza])
)
