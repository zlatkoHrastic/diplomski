CREATE TABLE [dbo].[Camac]
(
	[IdCamac] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Oznaka] NVARCHAR(10) NOT NULL, 
    [Ime] NVARCHAR(MAX) NOT NULL, 
    [BrojLjudi] TINYINT NOT NULL
)

GO

CREATE INDEX [IX_Camac_IdCamac] ON [dbo].[Camac] ([IdCamac])
