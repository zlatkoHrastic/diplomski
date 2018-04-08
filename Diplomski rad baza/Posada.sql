CREATE TABLE [dbo].[Posada]
(
	[IdRezultat] INT NOT NULL , 
    [IdVeslac] INT NOT NULL, 
    CONSTRAINT [FK_Posada_Rezultat] FOREIGN KEY (IdRezultat) REFERENCES [Rezultat](IdRezultat),
	CONSTRAINT [FK_Posada_Veslac] FOREIGN KEY (IdVeslac) REFERENCES [Veslac](IdVeslac), 
    PRIMARY KEY ([IdVeslac],[IdRezultat])
)
