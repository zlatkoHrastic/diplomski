CREATE TABLE [dbo].[Klub]
(
	[IdKlub] INT NOT NULL IDENTITY, 
    [Ime] NVARCHAR(MAX) NOT NULL, 
    [Kratica] NVARCHAR(10) NOT NULL,
	CONSTRAINT [PK_Klub] PRIMARY KEY(IdKlub)
)

GO

CREATE INDEX [IX_Klub_IdKlub] ON [dbo].[Klub] ([IdKlub])
