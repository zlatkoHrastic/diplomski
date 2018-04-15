CREATE TABLE [dbo].[Lokacija]
(
	[IdLokacija] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Naziv] NVARCHAR(MAX) NOT NULL, 
    [Lokacija] [sys].[geography] NOT NULL
)
