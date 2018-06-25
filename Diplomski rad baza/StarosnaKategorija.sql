CREATE TABLE [dbo].[StarosnaKategorija]
(
	[IdStarosnaKategorija] INT NOT NULL  IDENTITY, 
    [Oznaka] NVARCHAR(10) NOT NULL, 
    [Ime] NVARCHAR(MAX) NOT NULL, 
    [StarostPocetak] TINYINT NULL, 
    [StarostKraj] TINYINT NULL,
	CONSTRAINT [PK_StarosnaKategorija] PRIMARY KEY(IdStarosnaKategorija)
)

GO

CREATE INDEX [IX_StarosnaKategorija_IdStarosnaKategorija] ON [dbo].[StarosnaKategorija] ([IdStarosnaKategorija])
