CREATE TABLE [dbo].[PosadaVeslac]
(
	[IdPosada] INT NOT NULL, 
    [IdVeslac] INT NOT NULL, 
    [MjestoUCamcu] TINYINT NOT NULL,
	CONSTRAINT [PK_PosadaVeslac] PRIMARY KEY(IdPosada,IdVeslac),
	CONSTRAINT [FK_PosadaVeslac_Veslac] FOREIGN KEY ([IdVeslac]) REFERENCES [Veslac](IdVeslac),
	CONSTRAINT [FK_PosadaVeslac_Posada] FOREIGN KEY ([IdPosada]) REFERENCES [Posada](IdPosada),
	CONSTRAINT [UQ_Posada_MjestoUCamcu] UNIQUE (IdPosada,MjestoUCamcu)

)
