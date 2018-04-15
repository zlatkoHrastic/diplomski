﻿CREATE TABLE [dbo].[Posada]
(
	[IdPosada] INT NOT NULL PRIMARY KEY, 
    [IdKategorija] INT NOT NULL, 
    CONSTRAINT [FK_Posada_Kategorija] FOREIGN KEY ([IdKategorija]) REFERENCES [Kategorija](IdKategorija)
	)
