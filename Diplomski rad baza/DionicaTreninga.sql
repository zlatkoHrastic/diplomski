﻿CREATE TABLE [dbo].[DionicaTreninga]
(
	[IdDionicaTreninga] INT NOT NULL  IDENTITY, 
	[IdTrening] INT NOT NULL,
    [BrojDionice] SMALLINT NOT NULL, 
    [Vrijeme] TIME(3) NOT NULL,
	CONSTRAINT [PK_DionicaTreninga] PRIMARY KEY(IdDionicaTreninga),
	CONSTRAINT [FK_DionicaTreninga_Trening] FOREIGN KEY ([IdTrening]) REFERENCES [Trening]([IdTrening]),
	CONSTRAINT [UQ_IdTrening_BrojDionice] UNIQUE (IdTrening,BrojDionice)
 
)
GO

CREATE INDEX [IX_DionicaTreninga_IdDionicaTreninga] ON [dbo].[DionicaTreninga] ([IdDionicaTreninga])

GO

CREATE INDEX [IX_DionicaTreninga_IdTrening] ON [dbo].[DionicaTreninga] ([IdTrening])
