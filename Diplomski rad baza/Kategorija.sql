CREATE TABLE [dbo].[Kategorija]
(
	[IdKategorija] INT NOT NULL PRIMARY KEY IDENTITY, 
    [IdRegata] INT NOT NULL, 
    [IdStarosnaKategorija] INT NOT NULL, 
    [IdCamac] INT NOT NULL, 
    [Kratica] NVARCHAR(10) NOT NULL,
	CONSTRAINT [FK_Kategorija_Regata] FOREIGN KEY (IdRegata) REFERENCES [Regata](IdRegata),
	CONSTRAINT [FK_Kategorija_StarosnaKategorija] FOREIGN KEY (IdStarosnaKategorija) REFERENCES [StarosnaKategorija](IdStarosnaKategorija),
	CONSTRAINT [FK_Kategorija_Camac] FOREIGN KEY (IdCamac) REFERENCES [Camac](IdCamac)


)
