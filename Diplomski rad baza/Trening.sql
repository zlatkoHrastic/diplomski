CREATE TABLE [dbo].[Trening]
(
	[IdTrening] INT NOT NULL PRIMARY KEY IDENTITY, 
	[IdVeslac] INT NOT NULL,
    [VrijemeTreninga] DATETIME2 NOT NULL, 
    [IdTipTreninga] INT NOT NULL ,
	CONSTRAINT [FK_Trening_Veslac] FOREIGN KEY ([IdVeslac]) REFERENCES [Veslac]([IdVeslac]),
	CONSTRAINT [FK_Trening_TipTreninga] FOREIGN KEY ([IdTipTreninga]) REFERENCES [TipTreninga]([IdTipTreninga])
    
)

GO

CREATE INDEX [IX_Trening_IdTrening] ON [dbo].[Trening] ([IdTrening])

GO

CREATE INDEX [IX_Trening_IdVeslac] ON [dbo].[Trening] ([IdVeslac])

GO

CREATE INDEX [IX_Trening_IdTipTreninga] ON [dbo].[Trening] ([IdTipTreninga])
