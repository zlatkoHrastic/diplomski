CREATE TABLE [dbo].[Posada]
(
	[IdPosada] INT NOT NULL PRIMARY KEY IDENTITY, 
    [IdKategorija] INT NOT NULL, 
    [Kratica] NCHAR(20) NOT NULL, 
    CONSTRAINT [FK_Posada_Kategorija] FOREIGN KEY ([IdKategorija]) REFERENCES [Kategorija](IdKategorija)
	)
