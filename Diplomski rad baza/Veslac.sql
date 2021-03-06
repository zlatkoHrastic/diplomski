﻿CREATE TABLE [dbo].[Veslac]
(
	[IdVeslac] INT NOT NULL IDENTITY, 
    [Ime] NVARCHAR(50) NOT NULL, 
    [Prezime] NVARCHAR(50) NOT NULL, 
    [DatumRodenja] DATE NULL, 
    [OIB] NCHAR(11) NULL,
	CONSTRAINT [PK_Veslac] PRIMARY KEY(IdVeslac)
)

GO

CREATE INDEX [IX_Veslac_IdVeslac] ON [dbo].[Veslac] ([IdVeslac])
