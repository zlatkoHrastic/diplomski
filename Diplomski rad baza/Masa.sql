CREATE TABLE [dbo].[Masa]
(
	[IdMasa] INT NOT NULL PRIMARY KEY, 
    [Masa] DECIMAL(4) NOT NULL, 
    [VrijemeMjerenje] DATETIME NOT NULL, 
    [IdVeslac] INT NOT NULL, 
    CONSTRAINT [FK_Masa_Veslac] FOREIGN KEY (IdVeslac) REFERENCES [Veslac]([IdVeslac]),
	CONSTRAINT [UQ_Masa_Vrijeme] UNIQUE (VrijemeMjerenje,Masa)
)
