CREATE TABLE [dbo].[PripadnostKlubu]
(
	[IdPripadnostKlubu] INT NOT NULL PRIMARY KEY, 
    [IdVeslac] INT NOT NULL, 
    [IdKlub] INT NOT NULL, 
    [DatumPocetak] DATETIME NOT NULL, 
    [DatumKraj] DATETIME NULL, 
    CONSTRAINT [FK_PripadnostKlubu_Veslac] FOREIGN KEY (IdVeslac) REFERENCES [Veslac]([IdVeslac]), 
    CONSTRAINT [FK_PripadnostKlubu_Klub] FOREIGN KEY (IdKlub) REFERENCES [Klub]([IdKlub])
)
