CREATE TABLE [dbo].[PripadnostKlubu]
(
	[IdPripadnostKlubu] INT NOT NULL PRIMARY KEY IDENTITY, 
    [IdVeslac] INT NOT NULL, 
    [IdKlub] INT NOT NULL, 
    [DatumPocetak] DATETIME NOT NULL, 
    [DatumKraj] DATETIME NULL, 
    CONSTRAINT [FK_PripadnostKlubu_Veslac] FOREIGN KEY (IdVeslac) REFERENCES [Veslac]([IdVeslac]), 
    CONSTRAINT [FK_PripadnostKlubu_Klub] FOREIGN KEY (IdKlub) REFERENCES [Klub]([IdKlub]),
	CONSTRAINT [UQ_Veslac_Klub_DatumPocetak] UNIQUE (IdVeslac,IdKlub,DatumPocetak),
	CONSTRAINT [CH_DatumPocetak_DatumKraj] CHECK (DatumPocetak<DatumKraj OR DatumKraj IS NULL)
)

GO

CREATE INDEX [IX_PripadnostKlubu_IdPripadnostKlubu] ON [dbo].[PripadnostKlubu] ([IdPripadnostKlubu])

GO

CREATE INDEX [IX_PripadnostKlubu_IdVeslac] ON [dbo].[PripadnostKlubu] ([IdVeslac])

GO

CREATE INDEX [IX_PripadnostKlubu_IdKlub] ON [dbo].[PripadnostKlubu] ([IdKlub])
