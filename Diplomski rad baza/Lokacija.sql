CREATE TABLE [dbo].[Lokacija]
(
	[IdLokacija] INT NOT NULL  IDENTITY, 
    [Naziv] NVARCHAR(MAX) NOT NULL, 
	[GeografskaSirina] FLOAT NOT NULL, 
    [GeografskaVisina] FLOAT NOT NULL,
	CONSTRAINT [PK_Lokacija] PRIMARY KEY(IdLokacija)

)

GO

CREATE INDEX [IX_Lokacija_IdLokacija] ON [dbo].[Lokacija] ([IdLokacija])
