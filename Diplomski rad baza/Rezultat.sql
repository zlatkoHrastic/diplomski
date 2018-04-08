CREATE TABLE [dbo].[Rezultat]
(
	[IdRezultat] INT NOT NULL PRIMARY KEY, 
    [IdRegata] INT NOT NULL, 
    [IdKategorijaUtrke] INT NOT NULL, 
    [IdStarosnaKategorija] INT NOT NULL, 
    [IdCamac] INT NOT NULL, 
    [Vrijeme500] TIME NULL,
	[Vrijeme1000] TIME NULL,
	[Vrijeme1500] TIME NULL,
	[Vrijeme2000] TIME NULL, 
    CONSTRAINT [FK_Rezultat_Regata] FOREIGN KEY (IdRegata) REFERENCES [Regata](IdRegata),
	CONSTRAINT [FK_Rezultat_KategorijaUtrke] FOREIGN KEY (IdKategorijaUtrke) REFERENCES [KategorijaUtrke](IdKategorijaUtrke),
	CONSTRAINT [FK_Rezultat_StarosnaKategorija] FOREIGN KEY (IdStarosnaKategorija) REFERENCES [StarosnaKategorija](IdStarosnaKategorija),
	CONSTRAINT [FK_Rezultat_Camac] FOREIGN KEY (IdCamac) REFERENCES [Camac](IdCamac)

)
