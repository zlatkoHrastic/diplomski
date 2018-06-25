CREATE TABLE [dbo].[TipTreninga]
(
	[IdTipTreninga] INT NOT NULL PRIMARY KEY IDENTITY, 
    [NazivTreninga] NVARCHAR(50) NOT NULL
)

GO

CREATE INDEX [IX_TipTreninga_IdTipTreninga] ON [dbo].[TipTreninga] ([IdTipTreninga])
