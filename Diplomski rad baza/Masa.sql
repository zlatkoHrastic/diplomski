CREATE TABLE [dbo].[Masa]
(
	[IdMasa] INT NOT NULL IDENTITY, 
    [Masa] DECIMAL(5, 2) NOT NULL, 
    [VrijemeMjerenje] DATETIME NOT NULL, 
    [IdVeslac] INT NOT NULL, 
	CONSTRAINT [PK_Masa] PRIMARY KEY(IdMasa),
    CONSTRAINT [FK_Masa_Veslac] FOREIGN KEY (IdVeslac) REFERENCES [Veslac]([IdVeslac]),
	CONSTRAINT [UQ_Masa_Vrijeme] UNIQUE (IdVeslac,VrijemeMjerenje)
)

GO

CREATE INDEX [IX_Masa_IdMasa] ON [dbo].[Masa] ([IdMasa])

GO

CREATE INDEX [IX_Masa_IdVeslac] ON [dbo].[Masa] ([IdVeslac])
