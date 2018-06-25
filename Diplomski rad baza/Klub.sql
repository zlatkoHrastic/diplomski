CREATE TABLE [dbo].[Klub]
(
	[IdKlub] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Ime] NVARCHAR(MAX) NOT NULL, 
    [Kratica] NVARCHAR(10) NOT NULL
)

GO

CREATE INDEX [IX_Klub_IdKlub] ON [dbo].[Klub] ([IdKlub])
