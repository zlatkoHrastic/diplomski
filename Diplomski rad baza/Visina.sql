﻿CREATE TABLE [dbo].[Visina]
(
	[IdVisina] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Visina] DECIMAL(5, 2) NOT NULL, 
    [VrijemeMjerenje] DATETIME NOT NULL, 
    [IdVeslac] INT NOT NULL, 
    CONSTRAINT [FK_Visina_Veslac] FOREIGN KEY (IdVeslac) REFERENCES [Veslac]([IdVeslac]),
	CONSTRAINT [UQ_Visina_Vrijeme] UNIQUE (VrijemeMjerenje,Visina)
)
