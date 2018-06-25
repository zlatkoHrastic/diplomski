CREATE TABLE [dbo].[RangUtrke]
(
	[IdRangUtrke] INT NOT NULL IDENTITY, 
    [Kratica] NVARCHAR(10) NOT NULL, 
    [Naziv] NVARCHAR(50) NOT NULL,
	CONSTRAINT [PK_RangUtrke] PRIMARY KEY(IdRangUtrke)
)

GO

CREATE INDEX [IX_RangUtrke_IdRangUtrke] ON [dbo].[RangUtrke] ([IdRangUtrke])
