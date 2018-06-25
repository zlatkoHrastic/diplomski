CREATE TABLE [dbo].[TipTreninga]
(
	[IdTipTreninga] INT NOT NULL IDENTITY, 
    [NazivTreninga] NVARCHAR(50) NOT NULL,
	CONSTRAINT [PK_TipTreninga] PRIMARY KEY(IdTipTreninga)
)

GO

CREATE INDEX [IX_TipTreninga_IdTipTreninga] ON [dbo].[TipTreninga] ([IdTipTreninga])
