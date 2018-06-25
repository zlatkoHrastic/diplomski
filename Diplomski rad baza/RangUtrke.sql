CREATE TABLE [dbo].[RangUtrke]
(
	[IdRangUtrke] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Kratica] NVARCHAR(10) NOT NULL, 
    [Naziv] NVARCHAR(50) NOT NULL
)

GO

CREATE INDEX [IX_RangUtrke_IdRangUtrke] ON [dbo].[RangUtrke] ([IdRangUtrke])
