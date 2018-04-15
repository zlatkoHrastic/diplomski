CREATE TABLE [dbo].[Lokacija]
(
	[IdLokacija] INT NOT NULL PRIMARY KEY, 
    [Naziv] NVARCHAR(MAX) NOT NULL, 
    [Lokacija] [sys].[geography] NOT NULL
)
