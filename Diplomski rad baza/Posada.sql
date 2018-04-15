CREATE TABLE [dbo].[Posada]
(
	[IdPosada] INT NOT NULL , 
    [IdKategorija] INT NOT NULL, 
    CONSTRAINT [FK_Posada_Kategorija] FOREIGN KEY ([IdKategorija]) REFERENCES [Kategorija](IdKategorija)
	)
