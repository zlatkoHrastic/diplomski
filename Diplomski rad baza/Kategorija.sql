CREATE TABLE [dbo].[Kategorija]
(
	[IdKategorija] INT NOT NULL IDENTITY, 
    [IdRegata] INT NOT NULL, 
    [IdStarosnaKategorija] INT NOT NULL, 
    [IdCamac] INT NOT NULL, 
    [Kratica] NVARCHAR(10) NOT NULL,
	[BrojKategorije] SMALLINT NULL, 
	CONSTRAINT [PK_Kategorija] PRIMARY KEY(IdKategorija),
    CONSTRAINT [FK_Kategorija_Regata] FOREIGN KEY (IdRegata) REFERENCES [Regata](IdRegata),
	CONSTRAINT [FK_Kategorija_StarosnaKategorija] FOREIGN KEY (IdStarosnaKategorija) REFERENCES [StarosnaKategorija](IdStarosnaKategorija),
	CONSTRAINT [FK_Kategorija_Camac] FOREIGN KEY (IdCamac) REFERENCES [Camac](IdCamac),
	CONSTRAINT [UQ_Regata_BrojKategorije] UNIQUE (IdRegata,BrojKategorije)


)

GO

CREATE INDEX [IX_Kategorija_IdKategorija] ON [dbo].[Kategorija] ([IdKategorija])

GO

CREATE INDEX [IX_Kategorija_IdRegata] ON [dbo].[Kategorija] ([IdRegata])

GO

CREATE INDEX [IX_Kategorija_IdCamac] ON [dbo].[Kategorija] ([IdCamac])

GO

CREATE INDEX [IX_Kategorija_IdStarosnaKategorija] ON [dbo].[Kategorija] ([IdStarosnaKategorija])
