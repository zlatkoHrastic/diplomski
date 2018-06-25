CREATE TABLE [dbo].[KontrolnaTocka]
(
	[IdKontrolnaTocka] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Udaljenost] SMALLINT NOT NULL
)

GO

CREATE INDEX [IX_KontrolnaTocka_IdKontrolnaTocka] ON [dbo].[KontrolnaTocka] ([IdKontrolnaTocka])
