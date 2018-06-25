CREATE TABLE [dbo].[KontrolnaTocka]
(
	[IdKontrolnaTocka] INT NOT NULL IDENTITY, 
    [Udaljenost] SMALLINT NOT NULL,
	CONSTRAINT [PK_KontrolnaTocka] PRIMARY KEY(IdKontrolnaTocka)
)

GO

CREATE INDEX [IX_KontrolnaTocka_IdKontrolnaTocka] ON [dbo].[KontrolnaTocka] ([IdKontrolnaTocka])
