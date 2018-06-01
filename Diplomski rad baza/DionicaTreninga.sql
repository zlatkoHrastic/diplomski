CREATE TABLE [dbo].[DionicaTreninga]
(
	[IdDionicaTreninga] INT NOT NULL PRIMARY KEY IDENTITY, 
	[IdTrening] INT NOT NULL,
    [BrojDionice] SMALLINT NOT NULL, 
    [Vrijeme] TIME(3) NOT NULL,
	CONSTRAINT [FK_DionicaTreninga_Trening] FOREIGN KEY ([IdTrening]) REFERENCES [Trening]([IdTrening])
  
)
