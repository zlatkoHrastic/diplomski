CREATE TABLE [dbo].[StarosnaKategorija]
(
	[IdStarosnaKategorija] INT NOT NULL PRIMARY KEY, 
    [Oznaka] NVARCHAR(10) NOT NULL, 
    [Ime] NVARCHAR(MAX) NOT NULL, 
    [StarostPocetak] TINYINT NOT NULL, 
    [StarostKraj] TINYINT NOT NULL
)
