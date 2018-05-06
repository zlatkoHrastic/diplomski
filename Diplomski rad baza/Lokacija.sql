CREATE TABLE [dbo].[Lokacija]
(
	[IdLokacija] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Naziv] NVARCHAR(MAX) NOT NULL, 
	GeografskaSirina FLOAT NOT NULL, 
    [GeografskaVisina] FLOAT NOT NULL

)
