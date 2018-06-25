CREATE TABLE [dbo].[Camac]
(
	[IdCamac] INT NOT NULL IDENTITY, 
    [Oznaka] NVARCHAR(10) NOT NULL, 
    [Ime] NVARCHAR(MAX) NOT NULL, 
    [BrojLjudi] TINYINT NOT NULL,
	CONSTRAINT [PK_Camac] PRIMARY KEY(IdCamac)
)

GO

CREATE INDEX [IX_Camac_IdCamac] ON [dbo].[Camac] ([IdCamac])
