﻿CREATE TABLE [dbo].[Camac]
(
	[IdCamac] INT NOT NULL PRIMARY KEY, 
    [Oznaka] NVARCHAR(10) NOT NULL, 
    [Ime] NVARCHAR(MAX) NOT NULL, 
    [BrojLjudi] TINYINT NOT NULL
)
