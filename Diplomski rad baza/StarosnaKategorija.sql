﻿CREATE TABLE [dbo].[StarosnaKategorija]
(
	[IdStarosnaKategorija] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Oznaka] NVARCHAR(10) NOT NULL, 
    [Ime] NVARCHAR(MAX) NOT NULL, 
    [StarostPocetak] TINYINT NULL, 
    [StarostKraj] TINYINT NULL
)
