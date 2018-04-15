CREATE TABLE [dbo].[Veslac]
(
	[IdVeslac] INT NOT NULL PRIMARY KEY, 
    [Ime] NVARCHAR(50) NOT NULL, 
    [Prezime] NVARCHAR(50) NOT NULL, 
    [DatumRodenja] DATE NULL, 
    [OIB] NCHAR(11) NULL
)
