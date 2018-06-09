USE [master]
GO
/****** Object:  Database [InformacijskiSustav]    Script Date: 9.6.2018. 12:42:21 ******/
CREATE DATABASE [InformacijskiSustav]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'InformacijskiSustav', FILENAME = N'C:\Users\Zlatko\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\ferInformacijskiSustav_Primary.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'InformacijskiSustav_log', FILENAME = N'C:\Users\Zlatko\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\ferInformacijskiSustav_Primary.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [InformacijskiSustav].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [InformacijskiSustav] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [InformacijskiSustav] SET ANSI_NULLS ON 
GO
ALTER DATABASE [InformacijskiSustav] SET ANSI_PADDING ON 
GO
ALTER DATABASE [InformacijskiSustav] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [InformacijskiSustav] SET ARITHABORT ON 
GO
ALTER DATABASE [InformacijskiSustav] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [InformacijskiSustav] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [InformacijskiSustav] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [InformacijskiSustav] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [InformacijskiSustav] SET CURSOR_DEFAULT  LOCAL 
GO
ALTER DATABASE [InformacijskiSustav] SET CONCAT_NULL_YIELDS_NULL ON 
GO
ALTER DATABASE [InformacijskiSustav] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [InformacijskiSustav] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [InformacijskiSustav] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [InformacijskiSustav] SET  DISABLE_BROKER 
GO
ALTER DATABASE [InformacijskiSustav] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [InformacijskiSustav] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [InformacijskiSustav] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [InformacijskiSustav] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [InformacijskiSustav] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [InformacijskiSustav] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [InformacijskiSustav] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [InformacijskiSustav] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [InformacijskiSustav] SET  MULTI_USER 
GO
ALTER DATABASE [InformacijskiSustav] SET PAGE_VERIFY NONE  
GO
ALTER DATABASE [InformacijskiSustav] SET DB_CHAINING OFF 
GO
ALTER DATABASE [InformacijskiSustav] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [InformacijskiSustav] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [InformacijskiSustav] SET DELAYED_DURABILITY = DISABLED 
GO
USE [InformacijskiSustav]
GO
/****** Object:  UserDefinedFunction [dbo].[Fun_BrojVeslacaPoKlubovimaPoGodinama]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Fun_BrojVeslacaPoKlubovimaPoGodinama]
(
	@duljinaPovijesti int
)
RETURNS @returntable TABLE
(
	pocetakSezone date,
	idKlub int,
	brojLjudi int
)
AS
BEGIN
	INSERT @returntable
	SELECT DATEFROMPARTS(YEAR(CURRENT_TIMESTAMP)-number,1,1) AS pocetakSezone,Klub.IdKlub,Count(PripadnostKlubu.IdKlub) brojLjudi
		FROM master..spt_values
		FULL OUTER JOIN Klub ON 1=1
		LEFT OUTER JOIN PripadnostKlubu ON PripadnostKlubu.DatumPocetak<=DATEFROMPARTS(YEAR(CURRENT_TIMESTAMP)-number,1,1) AND (DATEFROMPARTS(YEAR(CURRENT_TIMESTAMP)-number,1,1)<=PripadnostKlubu.DatumKraj OR PripadnostKlubu.DatumKraj IS NULL) AND PripadnostKlubu.IdKlub=klub.IdKlub
		WHERE type='P'
		AND number BETWEEN 0 AND @duljinaPovijesti
		GROUP BY DATEFROMPARTS(YEAR(CURRENT_TIMESTAMP)-number,1,1),Klub.IdKlub
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[Fun_MedaljePoGodinama]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Fun_MedaljePoGodinama]
(
	@duljinaPovijesti  int
)
RETURNS @returntable TABLE
(
	GodinaRezultata int,
	IdKlub int,
	Mjesto int,
	BrojMedalja int
)
AS
BEGIN
	INSERT @returntable
		SELECT YEAR(CURRENT_TIMESTAMP)-number AS GodinaRezultata,PripadnostKlubu.IdKlub, rankPosada.Rank,Count (DISTINCT PosadaVeslac.IdPosada) AS BrojMedalja
		FROM RankPoPosadamaPoGodinama AS rankPosada
		JOIN PosadaVeslac ON PosadaVeslac.IdPosada= rankPosada.idPosada
		JOIN PripadnostKlubu ON PripadnostKlubu.IdVeslac= PosadaVeslac.IdVeslac AND (PripadnostKlubu.DatumPocetak<= rankPosada.DatumRezultata AND (rankPosada.DatumRezultata<=PripadnostKlubu.DatumKraj OR PripadnostKlubu.DatumKraj IS NULL))
		JOIN master..spt_values ON YEAR(CURRENT_TIMESTAMP)-number=YEAR(rankPosada.DatumRezultata)
		FULL OUTER JOIN Klub ON Klub.idKlub=PripadnostKlubu.IdKlub
		WHERE type='P' AND number BETWEEN 0 AND @duljinaPovijesti
		Group by YEAR(CURRENT_TIMESTAMP)-number,PripadnostKlubu.IdKlub,rankPosada.Rank
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[Sekvenca]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Sekvenca]
(
	@maksimum int
)
RETURNS @returntable TABLE
(
	broj int
)
AS
BEGIN
	DECLARE @brojac int = 0;
	WHILE @brojac<=@maksimum
	BEGIN
		INSERT @returntable
		SELECT @brojac;
		SET @brojac=@brojac+1
	END	
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[SekvencaTest]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	  CREATE FUNCTION [dbo].[SekvencaTest]
(
	@broj int
)
RETURNS @returntable TABLE
(
	maksimum int
)
AS
BEGIN
	DECLARE @brojac int = 0;
	WHILE @brojac<=@broj
	BEGIN
		INSERT @returntable
		SELECT @brojac;
		SET @brojac=@brojac+1
	END	
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[ToSeconds]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ToSeconds]
(
	@time time
)
RETURNS INT
AS
BEGIN
	RETURN DATEPART(minute,@time)*60+DATEPART(second,@time)
END
GO
/****** Object:  UserDefinedFunction [dbo].[ToTime]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ToTime]
(
	@seconds int
)
RETURNS time
AS
BEGIN
	declare @minutes varchar(2) = CONVERT(varchar(2),@seconds / 60)
	declare @timeSeconds int =  CONVERT(varchar(2),@seconds % 60)

	RETURN CONVERT( TIME(3), CONCAT('00:',@minutes,':',@timeSeconds))
END
GO
/****** Object:  Table [dbo].[Camac]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Camac](
	[IdCamac] [int] IDENTITY(1,1) NOT NULL,
	[Oznaka] [nvarchar](10) NOT NULL,
	[Ime] [nvarchar](max) NOT NULL,
	[BrojLjudi] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCamac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DionicaTreninga]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DionicaTreninga](
	[IdDionicaTreninga] [int] IDENTITY(1,1) NOT NULL,
	[IdTrening] [int] NOT NULL,
	[BrojDionice] [smallint] NOT NULL,
	[Vrijeme] [time](3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDionicaTreninga] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Kategorija]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kategorija](
	[IdKategorija] [int] IDENTITY(1,1) NOT NULL,
	[IdRegata] [int] NOT NULL,
	[IdStarosnaKategorija] [int] NOT NULL,
	[IdCamac] [int] NOT NULL,
	[Kratica] [nvarchar](10) NOT NULL,
	[BrojKategorije] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdKategorija] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Klub]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Klub](
	[IdKlub] [int] IDENTITY(1,1) NOT NULL,
	[Ime] [nvarchar](max) NOT NULL,
	[Kratica] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdKlub] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KontrolnaTocka]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KontrolnaTocka](
	[IdKontrolnaTocka] [int] IDENTITY(1,1) NOT NULL,
	[Udaljenost] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdKontrolnaTocka] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Lokacija]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lokacija](
	[IdLokacija] [int] IDENTITY(1,1) NOT NULL,
	[Naziv] [nvarchar](max) NOT NULL,
	[GeografskaSirina] [float] NOT NULL,
	[GeografskaVisina] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdLokacija] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Masa]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Masa](
	[IdMasa] [int] IDENTITY(1,1) NOT NULL,
	[Masa] [decimal](5, 2) NOT NULL,
	[VrijemeMjerenje] [datetime] NOT NULL,
	[IdVeslac] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMasa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Posada]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posada](
	[IdPosada] [int] IDENTITY(1,1) NOT NULL,
	[IdKategorija] [int] NOT NULL,
	[Kratica] [nchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPosada] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PosadaVeslac]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PosadaVeslac](
	[IdPosada] [int] NOT NULL,
	[IdVeslac] [int] NOT NULL,
	[MjestoUCamcu] [tinyint] NOT NULL,
 CONSTRAINT [PK_PosadaVeslac] PRIMARY KEY CLUSTERED 
(
	[IdPosada] ASC,
	[IdVeslac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PripadnostKlubu]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PripadnostKlubu](
	[IdPripadnostKlubu] [int] IDENTITY(1,1) NOT NULL,
	[IdVeslac] [int] NOT NULL,
	[IdKlub] [int] NOT NULL,
	[DatumPocetak] [datetime] NOT NULL,
	[DatumKraj] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPripadnostKlubu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProlaznoVrijeme]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProlaznoVrijeme](
	[IdProlaznoVrijeme] [int] IDENTITY(1,1) NOT NULL,
	[IdKontrolnaTocka] [int] NOT NULL,
	[IdRezultat] [int] NOT NULL,
	[Vrijeme] [time](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProlaznoVrijeme] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RangUtrke]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RangUtrke](
	[IdRangUtrke] [int] IDENTITY(1,1) NOT NULL,
	[Kratica] [nvarchar](10) NOT NULL,
	[Naziv] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRangUtrke] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Regata]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Regata](
	[IdRegata] [int] IDENTITY(1,1) NOT NULL,
	[Ime] [nvarchar](max) NOT NULL,
	[DatumPocetak] [date] NOT NULL,
	[DatumKraj] [date] NOT NULL,
	[IdLokacija] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRegata] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rezultat]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rezultat](
	[IdRezultat] [int] IDENTITY(1,1) NOT NULL,
	[IdUtrka] [int] NOT NULL,
	[IdPosada] [int] NOT NULL,
	[Staza] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRezultat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StarosnaKategorija]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StarosnaKategorija](
	[IdStarosnaKategorija] [int] IDENTITY(1,1) NOT NULL,
	[Oznaka] [nvarchar](10) NOT NULL,
	[Ime] [nvarchar](max) NOT NULL,
	[StarostPocetak] [tinyint] NULL,
	[StarostKraj] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdStarosnaKategorija] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipTreninga]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipTreninga](
	[IdTipTreninga] [int] IDENTITY(1,1) NOT NULL,
	[NazivTreninga] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipTreninga] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Trening]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trening](
	[IdTrening] [int] IDENTITY(1,1) NOT NULL,
	[IdVeslac] [int] NOT NULL,
	[VrijemeTreninga] [datetime2](7) NOT NULL,
	[IdTipTreninga] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTrening] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Utrka]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Utrka](
	[IdUtrka] [int] IDENTITY(1,1) NOT NULL,
	[IdKategorija] [int] NOT NULL,
	[IdRangUtrke] [int] NOT NULL,
	[RedniBroj] [smallint] NOT NULL,
	[StartnoVrijeme] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUtrka] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Veslac]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Veslac](
	[IdVeslac] [int] IDENTITY(1,1) NOT NULL,
	[Ime] [nvarchar](50) NOT NULL,
	[Prezime] [nvarchar](50) NOT NULL,
	[DatumRodenja] [date] NULL,
	[OIB] [nchar](11) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdVeslac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Visina]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Visina](
	[IdVisina] [int] IDENTITY(1,1) NOT NULL,
	[Visina] [decimal](5, 2) NOT NULL,
	[VrijemeMjerenje] [datetime] NOT NULL,
	[IdVeslac] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdVisina] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[BrojVeslacaPoKlubovimaPoGodinama]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BrojVeslacaPoKlubovimaPoGodinama]
	AS SELECT * FROM Fun_BrojVeslacaPoKlubovimaPoGodinama(5)
GO
/****** Object:  View [dbo].[MedaljePoGodinama]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MedaljePoGodinama]
	AS SELECT rangBroj.broj AS Mjesto,YEAR(CURRENT_TIMESTAMP)-brojGodina.broj AS Godina,Klub.IdKlub, ISNULL(Medalje.BrojMedalja,0) AS BrojMedalja
FROM Sekvenca(3) AS rangBroj
FULL OUTER JOIN Sekvenca(5) AS brojGodina ON 1=1
FULL OUTER JOIN Klub ON 1=1
LEFT JOIN Fun_MedaljePoGodinama(5)AS Medalje on Medalje.GodinaRezultata=YEAR(CURRENT_TIMESTAMP)-brojGodina.broj AND Klub.IdKlub=Medalje.IdKlub AND rangBroj.broj=Medalje.mjesto
Where
       rangBroj.broj BETWEEN 1 AND 3
	  AND brojGodina.broj BETWEEN 0 AND 5
GO
/****** Object:  View [dbo].[PredikcijskiTrening2000]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PredikcijskiTrening2000] AS
	SELECT Trening.IdVeslac,Trening.VrijemeTreninga,DionicaTreninga.BrojDionice, DionicaTreninga.Vrijeme
	FROM Trening
	JOIN DionicaTreninga ON DionicaTreninga.IdTrening=Trening.IdTrening
	WHERE IdTipTreninga=1
GO
/****** Object:  View [dbo].[PredikcijskiTrening2000Predikcija]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PredikcijskiTrening2000Predikcija]
	AS 	SELECT Trening.IdVeslac,Trening.VrijemeTreninga,[dbo].[ToTime](AVG([dbo].ToSeconds(DionicaTreninga.Vrijeme))+10) AS PredvidenoVrijeme
	FROM Trening
	JOIN DionicaTreninga ON DionicaTreninga.IdTrening=Trening.IdTrening
	WHERE IdTipTreninga=1
	Group by Trening.IdVeslac,Trening.VrijemeTreninga
GO
/****** Object:  View [dbo].[PredikcijskiTrening500]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PredikcijskiTrening500]
	AS 	SELECT Trening.IdVeslac,Trening.VrijemeTreninga,DionicaTreninga.BrojDionice, DionicaTreninga.Vrijeme
	FROM Trening
	JOIN DionicaTreninga ON DionicaTreninga.IdTrening=Trening.IdTrening
	WHERE IdTipTreninga=2
GO
/****** Object:  View [dbo].[PredikcijskiTrening500Predikcija]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PredikcijskiTrening500Predikcija]
	AS SELECT Trening.IdVeslac,Trening.VrijemeTreninga,[dbo].[ToTime](4*(MIN([dbo].ToSeconds(DionicaTreninga.Vrijeme))+7)) AS PredvidenoVrijeme
	FROM Trening
	JOIN DionicaTreninga ON DionicaTreninga.IdTrening=Trening.IdTrening
	WHERE IdTipTreninga=2
	Group by Trening.IdVeslac,Trening.VrijemeTreninga
GO
/****** Object:  View [dbo].[RankPoPosadamaPoGodinama]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RankPoPosadamaPoGodinama]
	AS  SELECT Rezultat.IdPosada,Utrka.StartnoVrijeme AS DatumRezultata, RANK() OVER (PARTITION BY Utrka.IdUtrka ORDER BY ProlaznoVrijeme.Vrijeme )AS Rank
FROM Utrka
JOIN Rezultat ON Rezultat.IdUtrka=Utrka.IdUtrka
JOIN ProlaznoVrijeme ON ProlaznoVrijeme.IdRezultat=Rezultat.IdRezultat
WHERE Utrka.IdRangUtrke=1 AND ProlaznoVrijeme.IdKontrolnaTocka=4
GO
/****** Object:  View [dbo].[RankPoPosadaPoGodinama]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RankPoPosadaPoGodinama]
	AS SELECT Rezultat.IdPosada,YEAR(Utrka.StartnoVrijeme) AS GodinaRezultata, RANK() OVER (PARTITION BY Utrka.IdUtrka,YEAR(Utrka.StartnoVrijeme) ORDER BY ProlaznoVrijeme.Vrijeme )AS Rank
FROM Utrka
JOIN Rezultat ON Rezultat.IdUtrka=Utrka.IdUtrka
JOIN ProlaznoVrijeme ON ProlaznoVrijeme.IdRezultat=Rezultat.IdRezultat
WHERE Utrka.IdRangUtrke=1 AND ProlaznoVrijeme.IdKontrolnaTocka=4
GO
/****** Object:  View [dbo].[RegataBrojPosadaPoKategorijama]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RegataBrojPosadaPoKategorijama]
	AS SELECT
Regata.IdRegata, Kategorija.IdKategorija, Kategorija.Kratica, COUNT(Posada.IdPosada) AS 'Broj posada' 
FROM Regata
JOIN Kategorija on Kategorija.IdRegata=Regata.IdRegata
JOIN Posada on Posada.IdKategorija=Kategorija.IdKategorija

GROUP BY Regata.IdRegata, Kategorija.IdKategorija, Kategorija.Kratica
GO
/****** Object:  View [dbo].[RegataBrojVeslacaPoKlubovima]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RegataBrojVeslacaPoKlubovima]
	AS SELECT
Regata.IdRegata, PripadnostKlubu.IdKlub,Klub.Ime,COUNT(PosadaVeslac.IdVeslac) AS 'Broj veslaca'
FROM Regata
JOIN Kategorija on Kategorija.IdRegata=Regata.IdRegata
JOIN Posada on Posada.IdKategorija=Kategorija.IdKategorija
join PosadaVeslac on PosadaVeslac.IdPosada=Posada.IdPosada
join PripadnostKlubu on PripadnostKlubu.IdVeslac=PosadaVeslac.IdVeslac AND PripadnostKlubu.DatumPocetak<=Regata.DatumPocetak AND (PripadnostKlubu.DatumKraj >= Regata.DatumPocetak OR PripadnostKlubu.DatumKraj IS NULL)
join Klub on PripadnostKlubu.IdKlub=Klub.IdKlub
GROUP BY Regata.IdRegata, PripadnostKlubu.IdKlub,Klub.Ime
GO
/****** Object:  View [dbo].[RegataVremenaPoUtrkama]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RegataVremenaPoUtrkama]
	AS SELECT
Regata.IdRegata, Kategorija.IdKategorija, Utrka.IdUtrka, Posada.IdPosada, Rezultat.Staza,Posada.Kratica,ProlaznoVrijeme.Vrijeme,KontrolnaTocka.Udaljenost
FROM Regata
JOIN Kategorija on Kategorija.IdRegata=Regata.IdRegata
JOIN Posada on Posada.IdKategorija=Kategorija.IdKategorija
JOIN Utrka on Kategorija.IdKategorija=Utrka.IdKategorija 
JOIN Rezultat on Rezultat.IdPosada=Posada.IdPosada AND Rezultat.IdUtrka=Utrka.IdUtrka
JOIN ProlaznoVrijeme on ProlaznoVrijeme.IdRezultat=Rezultat.IdRezultat
JOIN KontrolnaTocka on KontrolnaTocka.IdKontrolnaTocka=ProlaznoVrijeme.IdKontrolnaTocka
GO
/****** Object:  View [dbo].[VeslaciPoStarosnimKategorijama]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VeslaciPoStarosnimKategorijama]
	AS SELECT IdStarosnaKategorija,klub.IdKlub ,COUNT(PripadnostKlubu.IdPripadnostKlubu) AS BrojVeslaca
FROM StarosnaKategorija
FULL OUTER JOIN Klub on 1=1
LEFT OUTER JOIN Veslac on YEAR(CURRENT_TIMESTAMP)-YEAR(Veslac.DatumRodenja)>=StarosnaKategorija.StarostPocetak AND (YEAR(CURRENT_TIMESTAMP)-YEAR(Veslac.DatumRodenja))<=StarosnaKategorija.StarostKraj
LEFT OUTER JOIN PripadnostKlubu ON PripadnostKlubu.IdVeslac=Veslac.IdVeslac AND PripadnostKlubu.IdKlub=Klub.IdKlub
WHERE PripadnostKlubu.DatumKraj IS NULL
GROUP BY klub.IdKlub,StarosnaKategorija.IdStarosnaKategorija;
GO
/****** Object:  View [dbo].[VeslaciUParu]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VeslaciUParu]
	AS SELECT Veslac.IdVeslac, VeslaoSa.IdVeslac AS VeslaoSaId, VeslaoSa.ime+ ' '+ VeslaoSa.Prezime AS VeslaoSa,COUNT(*) AS VeslaliPuta
FROM Veslac 
JOIN PosadaVeslac ON PosadaVeslac.IdVeslac=Veslac.IdVeslac
JOIN PosadaVeslac AS IstaPosada ON IstaPosada.IdPosada=PosadaVeslac.IdPosada 
JOIN Veslac AS VeslaoSa ON VeslaoSa.IdVeslac=IstaPosada.IdVeslac
WHERE Veslac.IdVeslac <> VeslaoSa.IdVeslac
GROUP BY Veslac.IdVeslac,VeslaoSa.IdVeslac,VeslaoSa.Ime,VeslaoSa.Prezime
GO
/****** Object:  View [dbo].[VeslacPoKategoriji]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VeslacPoKategoriji]
	AS SELECT PosadaVeslac.IdVeslac,COUNT(Kategorija.Kratica) AS PutaVeslao,Kategorija.Kratica
FROM PosadaVeslac
JOIN Posada ON Posada.IdPosada=PosadaVeslac.IdPosada
JOIN Kategorija ON Kategorija.IdKategorija=Posada.IdKategorija
GROUP BY PosadaVeslac.IdVeslac, Kategorija.Kratica
GO
/****** Object:  View [dbo].[VeslanjeNaLokaciji]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VeslanjeNaLokaciji]
	AS SELECT PosadaVeslac.IdVeslac,COUNT(Regata.IdLokacija) AS PutaNaLokaciji,Regata.IdLokacija
FROM PosadaVeslac
JOIN Posada ON Posada.IdPosada=PosadaVeslac.IdPosada
JOIN Kategorija ON Kategorija.IdKategorija=Posada.IdKategorija
JOIN Regata ON Regata.IdRegata=Kategorija.IdRegata
GROUP BY PosadaVeslac.IdVeslac,Regata.IdLokacija
GO
/****** Object:  View [dbo].[VremenaPoVeslacu]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VremenaPoVeslacu]
	AS SELECT Veslac.Ime, Veslac.Prezime,Veslac.IdVeslac, ProlaznoVrijeme.Vrijeme, Regata.DatumPocetak, Regata.Ime AS ImeRegate, Kategorija.Kratica,KontrolnaTocka.Udaljenost
FROM Veslac
JOIN PosadaVeslac on PosadaVeslac.IdVeslac=Veslac.IdVeslac
JOIN Rezultat on Rezultat.IdPosada=PosadaVeslac.IdPosada
JOIN ProlaznoVrijeme ON ProlaznoVrijeme.IdRezultat=Rezultat.IdRezultat
JOIN KontrolnaTocka ON KontrolnaTocka.IdKontrolnaTocka=ProlaznoVrijeme.IdKontrolnaTocka
JOIN Posada on Posada.IdPosada=PosadaVeslac.IdPosada
JOIN Kategorija on Kategorija.IdKategorija=Posada.IdKategorija
JOIN Regata on Regata.IdRegata=Kategorija.IdRegata
GO
/****** Object:  View [dbo].[Zbirna startna lista]    Script Date: 9.6.2018. 12:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Zbirna startna lista]
	AS SELECT RedniBroj as RedniBrojUtrke,Kategorija.IdKategorija,Kategorija.Kratica as Kategorija,Utrka.IdUtrka,Utrka.StartnoVrijeme,RangUtrke.Kratica as Rang, Kategorija.IdRegata
		FROM
		Utrka
		join Kategorija on Utrka.IdKategorija=Kategorija.IdKategorija
		join RangUtrke on Utrka.IdRangUtrke=RangUtrke.IdRangUtrke
GO
SET IDENTITY_INSERT [dbo].[Camac] ON 

INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (1, N'1X', N'Samac', 1)
INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (2, N'2-', N'Dvojac bez kormilara', 2)
INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (3, N'2+', N'Dvojac s kormilarom', 3)
INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (4, N'2X', N'Dvojac na pariče', 2)
INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (5, N'4-', N'Četverac bez kormilara', 4)
INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (6, N'4+', N'Četverac s kormilarom', 5)
INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (7, N'4x', N'Četverac na pariče', 4)
INSERT [dbo].[Camac] ([IdCamac], [Oznaka], [Ime], [BrojLjudi]) VALUES (8, N'8+', N'Osmerac', 9)
SET IDENTITY_INSERT [dbo].[Camac] OFF
SET IDENTITY_INSERT [dbo].[DionicaTreninga] ON 

INSERT [dbo].[DionicaTreninga] ([IdDionicaTreninga], [IdTrening], [BrojDionice], [Vrijeme]) VALUES (1, 1, 1, CAST(N'00:09:59.0700000' AS Time))
INSERT [dbo].[DionicaTreninga] ([IdDionicaTreninga], [IdTrening], [BrojDionice], [Vrijeme]) VALUES (2, 1, 2, CAST(N'00:10:05.0700000' AS Time))
INSERT [dbo].[DionicaTreninga] ([IdDionicaTreninga], [IdTrening], [BrojDionice], [Vrijeme]) VALUES (4, 2, 1, CAST(N'00:02:20.0600000' AS Time))
INSERT [dbo].[DionicaTreninga] ([IdDionicaTreninga], [IdTrening], [BrojDionice], [Vrijeme]) VALUES (5, 2, 2, CAST(N'00:02:15.1400000' AS Time))
INSERT [dbo].[DionicaTreninga] ([IdDionicaTreninga], [IdTrening], [BrojDionice], [Vrijeme]) VALUES (6, 3, 1, CAST(N'00:09:54.0700000' AS Time))
INSERT [dbo].[DionicaTreninga] ([IdDionicaTreninga], [IdTrening], [BrojDionice], [Vrijeme]) VALUES (7, 3, 2, CAST(N'00:10:04.0700000' AS Time))
SET IDENTITY_INSERT [dbo].[DionicaTreninga] OFF
SET IDENTITY_INSERT [dbo].[Kategorija] ON 

INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (1, 1, 4, 2, N'2-JMB', 12)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (2, 1, 4, 1, N'1XJMB', 10)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (1002, 1002, 3, 1, N'1XKM', 1)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (2002, 1002, 4, 4, N'2XKM', 2)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3003, 1, 3, 1, N'1XKMB', 1)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3004, 1, 3, 4, N'2XKMB', 2)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3007, 1, 3, 1, N'1XKŽB', 3)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3008, 1, 3, 4, N'2XKZB', 4)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3009, 1, 3, 1, N'1XKM', 5)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3010, 1, 3, 4, N'2XKM', 6)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3011, 1, 3, 7, N'4XKM', 7)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3012, 1, 3, 1, N'1XKŽ', 8)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3013, 1, 3, 4, N'2XKŽ', 9)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3014, 1, 4, 4, N'2XJMB', 11)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3015, 1, 4, 5, N'4-JMB', 13)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3016, 1, 4, 1, N'1XJŽB', 14)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3017, 1, 4, 4, N'2XJŽB', 15)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3018, 1, 5, 1, N'1XJMA', 16)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3019, 1, 5, 4, N'2XJMA', 17)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3020, 1, 5, 2, N'2-JMA', 18)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3021, 1, 5, 5, N'4-JMA', 19)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3022, 1, 5, 1, N'1xJŽA', 20)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3023, 1, 5, 4, N'2xJŽA', 21)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3024, 1, 6, 1, N'1xSM', 22)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3025, 1, 6, 4, N'2XSM', 23)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3026, 1, 6, 2, N'2-SM', 24)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3027, 1, 6, 1, N'1xSŽ', 25)
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica], [BrojKategorije]) VALUES (3028, 1, 6, 4, N'2xSŽ', 26)
SET IDENTITY_INSERT [dbo].[Kategorija] OFF
SET IDENTITY_INSERT [dbo].[Klub] ON 

INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (1, N'Croatia', N'CRO')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (2, N'Istra', N'IST')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (3, N'Jarun', N'JAR')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (4, N'Mladost', N'MLA')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (5, N'Zagreb', N'ZAG')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (6, N'Iktus', N'IKT')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (7, N'Korana', N'KOR')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (8, N'Trešnjevka', N'TRE')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (9, N'Nova', N'NOV')
SET IDENTITY_INSERT [dbo].[Klub] OFF
SET IDENTITY_INSERT [dbo].[KontrolnaTocka] ON 

INSERT [dbo].[KontrolnaTocka] ([IdKontrolnaTocka], [Udaljenost]) VALUES (1, 500)
INSERT [dbo].[KontrolnaTocka] ([IdKontrolnaTocka], [Udaljenost]) VALUES (2, 1000)
INSERT [dbo].[KontrolnaTocka] ([IdKontrolnaTocka], [Udaljenost]) VALUES (3, 1500)
INSERT [dbo].[KontrolnaTocka] ([IdKontrolnaTocka], [Udaljenost]) VALUES (4, 2000)
SET IDENTITY_INSERT [dbo].[KontrolnaTocka] OFF
SET IDENTITY_INSERT [dbo].[Lokacija] ON 

INSERT [dbo].[Lokacija] ([IdLokacija], [Naziv], [GeografskaSirina], [GeografskaVisina]) VALUES (1, N'Jarun', 45.786586, 15.912412)
INSERT [dbo].[Lokacija] ([IdLokacija], [Naziv], [GeografskaSirina], [GeografskaVisina]) VALUES (2, N'Bakar', 45.30699, 14.535673)
SET IDENTITY_INSERT [dbo].[Lokacija] OFF
SET IDENTITY_INSERT [dbo].[Masa] ON 

INSERT [dbo].[Masa] ([IdMasa], [Masa], [VrijemeMjerenje], [IdVeslac]) VALUES (1, CAST(67.75 AS Decimal(5, 2)), CAST(N'2018-09-17 12:30:00.000' AS DateTime), 20)
INSERT [dbo].[Masa] ([IdMasa], [Masa], [VrijemeMjerenje], [IdVeslac]) VALUES (2, CAST(67.75 AS Decimal(5, 2)), CAST(N'2018-09-20 12:30:00.000' AS DateTime), 20)
INSERT [dbo].[Masa] ([IdMasa], [Masa], [VrijemeMjerenje], [IdVeslac]) VALUES (3, CAST(65.00 AS Decimal(5, 2)), CAST(N'2018-09-28 12:30:00.000' AS DateTime), 20)
INSERT [dbo].[Masa] ([IdMasa], [Masa], [VrijemeMjerenje], [IdVeslac]) VALUES (5, CAST(62.00 AS Decimal(5, 2)), CAST(N'2018-09-30 12:30:00.000' AS DateTime), 20)
INSERT [dbo].[Masa] ([IdMasa], [Masa], [VrijemeMjerenje], [IdVeslac]) VALUES (1002, CAST(78.00 AS Decimal(5, 2)), CAST(N'2018-06-01 00:00:00.000' AS DateTime), 20)
SET IDENTITY_INSERT [dbo].[Masa] OFF
SET IDENTITY_INSERT [dbo].[Posada] ON 

INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (1, 1, N'JAR                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (2, 1, N'ZAG                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3, 2, N'CRO1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (4, 2, N'CRO2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (5, 2, N'IKT1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (6, 2, N'IKT2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (7, 2, N'IKT3                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (8, 2, N'IST1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (9, 2, N'IST2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (10, 2, N'IST3                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (11, 2, N'IST4                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (12, 2, N'IST5                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (13, 2, N'KOR                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (14, 2, N'MLA1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (15, 2, N'MLA2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (16, 2, N'TRE1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (17, 2, N'TRE2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (2003, 1002, N'CRO                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (1005, 2002, N'NOV3                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3003, 3003, N'ARU1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3004, 3003, N'ARU2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3005, 3003, N'ARU3                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3006, 3003, N'CRO                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3007, 3003, N'GLA                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3008, 3003, N'IST1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3009, 3003, N'IST2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3010, 3003, N'IST3                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3011, 3003, N'JAR                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3026, 3003, N'KOR                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3012, 3003, N'KRK                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3013, 3003, N'NOV1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3014, 3003, N'NOV2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3015, 3003, N'NOV3                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3016, 3003, N'NOV4                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3017, 3003, N'SAB                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3018, 3003, N'TRE                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3019, 3003, N'VUK                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3020, 3004, N'CRO                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3021, 3004, N'IST                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3023, 3004, N'JAR1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3024, 3004, N'JAR2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3025, 3004, N'JAR3                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3027, 3004, N'TRE                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3028, 3007, N'CRO                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3029, 3007, N'GLA1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3030, 3007, N'GLA2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3042, 3007, N'IST2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3043, 3007, N'IST3                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3031, 3007, N'JAR                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3032, 3007, N'MLA1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3033, 3007, N'MLA2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3034, 3007, N'MLA3                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3036, 3008, N'ARU                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3037, 3008, N'GLA                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3038, 3008, N'TRE                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3039, 3008, N'VUK                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3040, 3009, N'ARU                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3041, 3009, N'IST1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3044, 3009, N'JAR                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3045, 3009, N'JRI                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3046, 3009, N'KOR1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3047, 3009, N'KOR2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3048, 3009, N'MLA1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3049, 3009, N'MLA2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3050, 3009, N'TRE1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3051, 3009, N'TRE2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3052, 3009, N'ZAG1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3053, 3009, N'ZAG2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3054, 3010, N'IST1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3055, 3010, N'IST2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3056, 3010, N'IST3                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3057, 3010, N'JRI                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3058, 3010, N'MLA1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3059, 3010, N'MLA2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3060, 3010, N'MLA3                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3061, 3010, N'MLA4                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3062, 3010, N'SAB                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3063, 3010, N'TRE                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3064, 3011, N'CRO                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3065, 3011, N'IST                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3066, 3011, N'JAR1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3067, 3011, N'JAR2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3068, 3011, N'JRI                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3069, 3011, N'MLA1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3070, 3011, N'MLA2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3071, 3011, N'NOV1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3072, 3011, N'NOV2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3073, 3011, N'TRE                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3074, 3012, N'CRO                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3075, 3012, N'IST                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3076, 3012, N'JAR                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3077, 3012, N'TRE                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3078, 3012, N'VUK                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3079, 3012, N'ZAG                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3080, 3013, N'ARU                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3081, 3013, N'TRE                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3082, 3014, N'ARU                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3083, 3014, N'CRO1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3084, 3014, N'CRO2                ')
GO
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3085, 3014, N'IKT                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3086, 3014, N'IST                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3087, 3014, N'JAR                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3088, 3014, N'MLA                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3089, 3014, N'SAB                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3090, 3014, N'TRE1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3091, 3014, N'TRE2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3092, 3014, N'ZAG                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3093, 3015, N'IST1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3094, 3015, N'IST2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3095, 3015, N'KRK1                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3096, 3015, N'KRK2                ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3097, 3015, N'MLA                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3099, 3015, N'ZAG                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3098, 3021, N'TRE                 ')
INSERT [dbo].[Posada] ([IdPosada], [IdKategorija], [Kratica]) VALUES (3022, 3028, N'IST                 ')
SET IDENTITY_INSERT [dbo].[Posada] OFF
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (1, 5, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (1, 6, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (2, 9, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (2, 10, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3, 11, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (4, 12, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (5, 13, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (6, 14, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (7, 15, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (8, 16, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (9, 17, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (10, 18, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (11, 19, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (12, 20, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (13, 21, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (14, 22, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (15, 23, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (16, 24, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (17, 25, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (1005, 41, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (1005, 20, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (2003, 12, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3003, 1041, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3004, 1042, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3005, 1043, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3006, 1044, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3007, 1045, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3008, 1046, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3009, 1047, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3010, 1048, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3011, 1049, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3012, 1050, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3013, 1051, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3014, 1052, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3015, 1053, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3016, 1054, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3017, 1055, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3018, 1056, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3019, 1057, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3020, 1058, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3020, 1059, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3022, 1060, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3022, 1061, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3023, 1062, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3023, 1063, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3024, 1064, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3024, 1065, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3025, 1066, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3025, 1067, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3026, 1068, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3026, 1069, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3027, 1070, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3027, 1073, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3028, 1074, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3029, 1075, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3030, 1076, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3031, 1077, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3032, 1078, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3033, 1079, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3034, 1080, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3036, 1081, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3036, 1082, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3037, 1083, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3037, 1084, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3038, 1085, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3038, 1086, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3039, 1087, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3039, 1088, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3040, 1089, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3041, 1090, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3042, 1091, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3043, 1092, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3044, 1093, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3045, 1094, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3046, 1095, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3047, 1096, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3048, 1097, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3049, 1098, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3050, 1099, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3051, 1101, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3052, 1102, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3053, 1103, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3054, 1104, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3054, 1105, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3055, 1106, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3055, 1107, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3056, 1108, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3056, 1109, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3057, 1110, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3057, 1111, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3058, 1121, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3058, 1112, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3059, 1113, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3059, 1114, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3060, 1115, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3060, 1116, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3061, 1117, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3061, 1118, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3062, 1119, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3062, 1122, 2)
GO
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3063, 1123, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3063, 1120, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3064, 1124, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3064, 1125, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3064, 1126, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3064, 1127, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3065, 1128, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3065, 1129, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3065, 1130, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3065, 1131, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3066, 1132, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3066, 1133, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3066, 1134, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3066, 1135, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3067, 1136, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3067, 1137, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3067, 1138, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3067, 1139, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3068, 1140, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3068, 1141, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3068, 1142, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3068, 1143, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3069, 1144, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3069, 1145, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3069, 1146, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3069, 1147, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3070, 1148, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3070, 1149, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3070, 1150, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3070, 1151, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3071, 1152, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3071, 1153, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3071, 1154, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3071, 1155, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3072, 1156, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3072, 1157, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3072, 1158, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3072, 1159, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3073, 1160, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3073, 1161, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3073, 1162, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3073, 1163, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3074, 1164, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3075, 1165, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3076, 1166, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3077, 1167, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3078, 1168, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3079, 1169, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3080, 1170, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3080, 1171, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3081, 1172, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3081, 1173, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3082, 1189, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3082, 1190, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3083, 1191, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3083, 1192, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3084, 1193, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3084, 1194, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3085, 1195, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3085, 1196, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3086, 1197, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3086, 1198, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3087, 1199, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3087, 1200, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3088, 1201, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3088, 1202, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3089, 1203, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3089, 1204, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3090, 1205, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3090, 1206, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3091, 1207, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3091, 1208, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3092, 1209, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3092, 1210, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3093, 1211, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3093, 1212, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3093, 1213, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3093, 1214, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3094, 1215, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3094, 1216, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3094, 1217, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3094, 1218, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3095, 1219, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3095, 1220, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3095, 1221, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3095, 1222, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3096, 1223, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3096, 1224, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3096, 1225, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3096, 1226, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3097, 1227, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3097, 1228, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3097, 1229, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3097, 1230, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3098, 1231, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3098, 1232, 2)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3098, 1233, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3098, 1234, 4)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3099, 1235, 1)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3099, 1236, 2)
GO
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3099, 1237, 3)
INSERT [dbo].[PosadaVeslac] ([IdPosada], [IdVeslac], [MjestoUCamcu]) VALUES (3099, 1238, 4)
SET IDENTITY_INSERT [dbo].[PripadnostKlubu] ON 

INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (2, 1, 2, CAST(N'2018-01-02 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (3, 2, 1, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (4, 3, 2, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (5, 4, 2, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (6, 5, 3, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (7, 6, 3, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (8, 7, 4, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (9, 8, 4, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (10, 9, 5, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (11, 10, 5, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (12, 11, 1, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (13, 12, 1, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (14, 13, 6, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (15, 14, 6, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (16, 15, 6, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (17, 16, 2, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (18, 17, 2, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (19, 18, 2, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (20, 19, 2, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (21, 20, 2, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (22, 21, 7, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (23, 22, 4, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (24, 23, 4, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (25, 24, 8, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (26, 25, 8, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (1022, 1, 2, CAST(N'2010-01-01 00:00:00.000' AS DateTime), CAST(N'2010-12-01 00:00:00.000' AS DateTime))
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (1027, 1, 3, CAST(N'2009-01-02 00:00:00.000' AS DateTime), CAST(N'2009-11-01 00:00:00.000' AS DateTime))
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (1028, 1, 2, CAST(N'2011-01-02 00:00:00.000' AS DateTime), CAST(N'2011-11-01 00:00:00.000' AS DateTime))
INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (1032, 41, 9, CAST(N'2018-06-01 00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[PripadnostKlubu] OFF
SET IDENTITY_INSERT [dbo].[ProlaznoVrijeme] ON 

INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (1, 4, 1, CAST(N'00:08:21.5300000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (2, 4, 2, CAST(N'00:08:25.9000000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (3, 4, 3, CAST(N'00:08:05.2000000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (4, 4, 4, CAST(N'00:08:51.1600000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (5, 4, 5, CAST(N'00:08:58.1700000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (6, 4, 6, CAST(N'00:09:47.5050000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (7, 4, 7, CAST(N'00:09:51.0700000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (8, 4, 8, CAST(N'00:08:03.8800000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (9, 4, 9, CAST(N'00:08:04.9400000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (10, 4, 10, CAST(N'00:08:26.3200000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (11, 4, 11, CAST(N'00:08:12.2500000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (12, 4, 12, CAST(N'00:08:14.7000000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (13, 4, 13, CAST(N'00:08:16.4800000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (14, 4, 14, CAST(N'00:09:19.7800000' AS Time))
INSERT [dbo].[ProlaznoVrijeme] ([IdProlaznoVrijeme], [IdKontrolnaTocka], [IdRezultat], [Vrijeme]) VALUES (1003, 4, 1003, CAST(N'00:07:20.1400000' AS Time))
SET IDENTITY_INSERT [dbo].[ProlaznoVrijeme] OFF
SET IDENTITY_INSERT [dbo].[RangUtrke] ON 

INSERT [dbo].[RangUtrke] ([IdRangUtrke], [Kratica], [Naziv]) VALUES (1, N'FA', N'Finale A')
INSERT [dbo].[RangUtrke] ([IdRangUtrke], [Kratica], [Naziv]) VALUES (2, N'FB', N'Finale B')
INSERT [dbo].[RangUtrke] ([IdRangUtrke], [Kratica], [Naziv]) VALUES (3, N'KV', N'Kvalifikacije')
SET IDENTITY_INSERT [dbo].[RangUtrke] OFF
SET IDENTITY_INSERT [dbo].[Regata] ON 

INSERT [dbo].[Regata] ([IdRegata], [Ime], [DatumPocetak], [DatumKraj], [IdLokacija]) VALUES (1, N'1. Regata VKMF', CAST(N'2018-09-17' AS Date), CAST(N'2018-09-17' AS Date), 1)
INSERT [dbo].[Regata] ([IdRegata], [Ime], [DatumPocetak], [DatumKraj], [IdLokacija]) VALUES (2, N'Multiple test', CAST(N'2018-06-17' AS Date), CAST(N'2018-06-17' AS Date), 2)
INSERT [dbo].[Regata] ([IdRegata], [Ime], [DatumPocetak], [DatumKraj], [IdLokacija]) VALUES (1002, N'API regata', CAST(N'2018-06-01' AS Date), CAST(N'2018-06-01' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Regata] OFF
SET IDENTITY_INSERT [dbo].[Rezultat] ON 

INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (1, 1, 1, 1)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (2, 1, 2, 2)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (3, 2, 5, 1)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (4, 2, 8, 2)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (5, 2, 17, 3)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (6, 2, 4, 4)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (7, 2, 11, 5)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (8, 3, 16, 3)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (9, 3, 7, 4)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (10, 3, 13, 5)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (11, 4, 6, 2)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (12, 4, 14, 3)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (13, 4, 3, 4)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (14, 4, 12, 5)
INSERT [dbo].[Rezultat] ([IdRezultat], [IdUtrka], [IdPosada], [Staza]) VALUES (1003, 1002, 2003, 0)
SET IDENTITY_INSERT [dbo].[Rezultat] OFF
SET IDENTITY_INSERT [dbo].[StarosnaKategorija] ON 

INSERT [dbo].[StarosnaKategorija] ([IdStarosnaKategorija], [Oznaka], [Ime], [StarostPocetak], [StarostKraj]) VALUES (3, N'KM', N'Kadeti', 0, 14)
INSERT [dbo].[StarosnaKategorija] ([IdStarosnaKategorija], [Oznaka], [Ime], [StarostPocetak], [StarostKraj]) VALUES (4, N'JMB', N'Mlađi Juniori', 15, 16)
INSERT [dbo].[StarosnaKategorija] ([IdStarosnaKategorija], [Oznaka], [Ime], [StarostPocetak], [StarostKraj]) VALUES (5, N'JMA', N'Juniori', 17, 18)
INSERT [dbo].[StarosnaKategorija] ([IdStarosnaKategorija], [Oznaka], [Ime], [StarostPocetak], [StarostKraj]) VALUES (6, N'SM', N'Seniori', 19, 255)
SET IDENTITY_INSERT [dbo].[StarosnaKategorija] OFF
SET IDENTITY_INSERT [dbo].[TipTreninga] ON 

INSERT [dbo].[TipTreninga] ([IdTipTreninga], [NazivTreninga]) VALUES (1, N'Predikcijski trening na 2000 metara')
INSERT [dbo].[TipTreninga] ([IdTipTreninga], [NazivTreninga]) VALUES (2, N'Predikcijski trening na 500 metara')
SET IDENTITY_INSERT [dbo].[TipTreninga] OFF
SET IDENTITY_INSERT [dbo].[Trening] ON 

INSERT [dbo].[Trening] ([IdTrening], [IdVeslac], [VrijemeTreninga], [IdTipTreninga]) VALUES (1, 19, CAST(N'2018-09-16 11:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[Trening] ([IdTrening], [IdVeslac], [VrijemeTreninga], [IdTipTreninga]) VALUES (2, 19, CAST(N'2018-09-19 11:00:00.0000000' AS DateTime2), 2)
INSERT [dbo].[Trening] ([IdTrening], [IdVeslac], [VrijemeTreninga], [IdTipTreninga]) VALUES (3, 19, CAST(N'2018-09-23 11:00:00.0000000' AS DateTime2), 1)
SET IDENTITY_INSERT [dbo].[Trening] OFF
SET IDENTITY_INSERT [dbo].[Utrka] ON 

INSERT [dbo].[Utrka] ([IdUtrka], [IdKategorija], [IdRangUtrke], [RedniBroj], [StartnoVrijeme]) VALUES (1, 1, 1, 35, CAST(N'2018-04-15 15:38:00.0000000' AS DateTime2))
INSERT [dbo].[Utrka] ([IdUtrka], [IdKategorija], [IdRangUtrke], [RedniBroj], [StartnoVrijeme]) VALUES (2, 2, 3, 9, CAST(N'2018-09-17 11:56:00.0000000' AS DateTime2))
INSERT [dbo].[Utrka] ([IdUtrka], [IdKategorija], [IdRangUtrke], [RedniBroj], [StartnoVrijeme]) VALUES (3, 2, 3, 10, CAST(N'2018-09-17 12:03:00.0000000' AS DateTime2))
INSERT [dbo].[Utrka] ([IdUtrka], [IdKategorija], [IdRangUtrke], [RedniBroj], [StartnoVrijeme]) VALUES (4, 2, 3, 11, CAST(N'2018-09-17 12:10:00.0000000' AS DateTime2))
INSERT [dbo].[Utrka] ([IdUtrka], [IdKategorija], [IdRangUtrke], [RedniBroj], [StartnoVrijeme]) VALUES (1002, 1002, 3, 1, CAST(N'2018-06-01 08:00:00.0000000' AS DateTime2))
INSERT [dbo].[Utrka] ([IdUtrka], [IdKategorija], [IdRangUtrke], [RedniBroj], [StartnoVrijeme]) VALUES (1003, 1002, 3, 2, CAST(N'2018-06-01 08:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Utrka] OFF
SET IDENTITY_INSERT [dbo].[Veslac] ON 

INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1, N'Dominik', N'Vukmanić', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (2, N'Lukas', N'Jovakarić', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (3, N'Domagoj', N'Alber', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (4, N'Paulo', N'Possi', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (5, N'Drago', N'Tolić', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (6, N'Antoni', N'Dovođa', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (7, N'Zvonimir', N'Bandov', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (8, N'Lovro', N'Šurina', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (9, N'Benedikt Petar', N'Barun', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (10, N'Vinko', N'Brezić', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (11, N'Ante', N'Canic', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (12, N'Dario', N'Ladovic', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (13, N'Patrik', N'Loncaric', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (14, N'Anton', N'Loncaric', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (15, N'Marko', N'Iža', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (16, N'Teo', N'Poldrugovac', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (17, N'Andrea', N'Milovan', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (18, N'Frane', N'Puh', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (19, N'Alex', N'Mihailovic', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (20, N'Denis', N'Zdionica', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (21, N'Vedran', N'Stojakovic', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (22, N'Karlo', N'Romanic', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (23, N'Sven', N'Srkoc', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (24, N'Jakov', N'Bijelic', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (25, N'Marko', N'Švalj', CAST(N'2000-09-17' AS Date), NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (41, N'Denis', N'Tolić', CAST(N'1998-01-01' AS Date), N'1861861865 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1041, N'Elian', N'Djerdj', CAST(N'2005-01-01' AS Date), N'023695748  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1042, N'Valentino ', N'Savić', CAST(N'2005-01-22' AS Date), N'0369541258 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1043, N'Luka', N'Đaković', CAST(N'2006-02-13' AS Date), N'0085412569 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1044, N'Dominik', N'Piri', CAST(N'2005-06-09' AS Date), N'2365985614 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1045, N'Krešo', N'Leon', CAST(N'2018-02-14' AS Date), N'2659856324 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1046, N'Mihael', N'Balać', CAST(N'2006-06-18' AS Date), N'155698547  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1047, N'Haris', N'Omanović', CAST(N'1998-11-12' AS Date), N'5469521874 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1048, N'Matija', N'Peharec', CAST(N'1998-10-14' AS Date), N'256985647  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1049, N'Nino', N'Varat', CAST(N'1998-03-11' AS Date), N'456985215  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1050, N'Stipe', N'Mandušić', CAST(N'2005-05-20' AS Date), N'459265841  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1051, N'Sven', N'Maračić', CAST(N'2005-10-14' AS Date), N'256978415  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1052, N'Robert', N'Medak', CAST(N'2004-08-14' AS Date), N'454874125  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1053, N'Mateo', N'Maslač', CAST(N'2005-02-11' AS Date), N'56985114   ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1054, N'Vanja ', N'Mravunac', CAST(N'2005-08-28' AS Date), N'54687465   ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1055, N'Tin', N'Vujasin', CAST(N'2004-06-04' AS Date), N'2131684521 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1056, N'Jan', N'Vučanjk', CAST(N'2004-03-05' AS Date), N'548951221  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1057, N'Bruno', N'Krizmanić', CAST(N'2004-07-16' AS Date), N'4564521328 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1058, N'Vito', N'Škarica', CAST(N'2000-06-11' AS Date), N'54747441   ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1059, N'Vilim', N'Vukmanić', CAST(N'2000-04-09' AS Date), N'4588552114 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1060, N'Andrea', N'Bravar', CAST(N'2000-04-05' AS Date), N'585421584  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1061, N'Filip', N'Lukić', CAST(N'2000-11-20' AS Date), N'698514125  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1062, N'Jhetro', N'Čović', CAST(N'2000-12-19' AS Date), N'168742525  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1063, N'Denis', N'Capan', CAST(N'2000-04-16' AS Date), N'842158497  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1064, N'Ivor', N'Mihovilić', CAST(N'2000-07-10' AS Date), N'587515479  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1065, N'Lovre', N'Kolanović', CAST(N'2000-03-04' AS Date), N'4851256978 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1066, N'Sandro', N'Kulašić', CAST(N'2000-10-01' AS Date), N'845218547  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1067, N'Mihael', N'Vedak', CAST(N'2000-04-08' AS Date), N'5484128488 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1068, N'Maura', N'Bauer', CAST(N'2000-08-13' AS Date), N'5484451548 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1069, N'Juraj', N'Paranos', CAST(N'2000-08-12' AS Date), N'5484518845 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1070, N'Filip', N'Jović', CAST(N'2000-06-11' AS Date), N'54846215884')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1073, N'Jan', N'Gojić', CAST(N'2000-08-13' AS Date), N'5484515848 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1074, N'Nika', N'Stanić', CAST(N'2000-08-08' AS Date), N'554885158  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1075, N'Lara', N'Nenadić', CAST(N'2000-01-03' AS Date), N'574845154  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1076, N'Ivana', N'Galente', CAST(N'2000-04-11' AS Date), N'9585214878 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1077, N'Franka', N'Galić', CAST(N'2000-01-21' AS Date), N'5468465115 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1078, N'Reina', N'Rimbaldo', CAST(N'2000-10-14' AS Date), N'54862518425')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1079, N'Elena', N'Grnčarovski', CAST(N'2000-08-08' AS Date), N'45454642514')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1080, N'Una', N'Čumurija', CAST(N'2000-04-08' AS Date), N'6565858155 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1081, N'Nikka', N'Fabris', CAST(N'2000-05-07' AS Date), N'54842515481')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1082, N'Lara', N'Apollonio', CAST(N'2000-05-16' AS Date), N'58848515847')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1083, N'Laura', N'Zec', CAST(N'2000-04-09' AS Date), N'54845218544')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1084, N'Lana', N'Saletović', CAST(N'2000-06-17' AS Date), N'84518545644')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1085, N'Lucija', N'Matijević', CAST(N'2000-01-20' AS Date), N'84751541814')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1086, N'Lola', N'Margita', CAST(N'2000-01-28' AS Date), N'85425448894')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1087, N'Tena', N'Ostojić', CAST(N'1999-11-12' AS Date), N'8845122548 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1088, N'Marta', N'Jovanovac', CAST(N'1999-12-27' AS Date), N'8534542858 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1089, N'Leon', N'Ghira', CAST(N'1998-08-21' AS Date), N'5848451847 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1090, N'Massimo', N'Buršić', CAST(N'1998-06-10' AS Date), N'8451845215 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1091, N'Bartol', N'Toth', CAST(N'1998-08-25' AS Date), N'5875154564 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1092, N'Marco', N'Lajić', CAST(N'1998-01-01' AS Date), N'85451848451')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1093, N'Josip', N'Božić', CAST(N'1998-01-15' AS Date), N'55484154444')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1094, N'Andrej', N'Anđelić', CAST(N'1998-01-01' AS Date), N'69485156484')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1095, N'Patrik', N'Vrabac', CAST(N'1998-01-22' AS Date), N'89465189454')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1096, N'Mario', N'Konjovoda', CAST(N'1998-07-18' AS Date), N'9846216846 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1097, N'Nino', N'Jukić', CAST(N'1998-10-19' AS Date), N'9845186951 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1098, N'Roko', N'Bule', CAST(N'1998-06-17' AS Date), N'85845215845')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1099, N'Roko', N'Dubravica', CAST(N'1998-08-06' AS Date), N'89452185965')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1101, N'Luka', N'Kovać', CAST(N'1998-06-11' AS Date), N'8451484845 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1102, N'Niko', N'Morović', CAST(N'1998-01-01' AS Date), N'9451554    ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1103, N'Tristan', N'Orlić', CAST(N'1998-01-01' AS Date), N'549851214  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1104, N'David', N'Haliti', CAST(N'1998-01-01' AS Date), N'8451848447 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1105, N'Lovro', N'Škibola', CAST(N'1998-01-01' AS Date), N'8525248854 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1106, N'Matija', N'Marem', CAST(N'1998-01-01' AS Date), N'9856457741 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1107, N'Petar', N'Opačić', CAST(N'1998-01-01' AS Date), N'8854651244 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1108, N'Roko ', N'Cigić', CAST(N'1998-01-01' AS Date), N'5616216549 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1109, N'Fabian ', N'Jovanović', CAST(N'1998-01-01' AS Date), N'244848951  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1110, N'Vito', N'Labinjanin', CAST(N'1998-01-01' AS Date), N'9652528188 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1111, N'Matej', N'Stilin', CAST(N'1998-01-01' AS Date), N'8965428874 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1112, N'Fran', N'Škalamera', CAST(N'1998-01-01' AS Date), N'845616111  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1113, N'Timon', N'Milin', CAST(N'1998-01-01' AS Date), N'6516189498 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1114, N'Marko', N'Fortuna', CAST(N'1998-01-01' AS Date), N'9516216549 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1115, N'Marko ', N'Runtić', CAST(N'1998-01-01' AS Date), N'9816516546 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1116, N'Dominik', N'Puček', CAST(N'1998-01-01' AS Date), N'9616518475 ')
GO
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1117, N'Mateo', N'Štrok', CAST(N'1998-01-01' AS Date), N'5165168496 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1118, N'Roko', N'Krmpotić', CAST(N'1998-01-01' AS Date), N'6954198498 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1119, N'Davor', N'Poljančić', CAST(N'1998-01-01' AS Date), N'8651562154 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1120, N'Marko', N'Gutowski', CAST(N'1998-01-01' AS Date), N'5162186845 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1121, N'Vilko', N'Jukić', CAST(N'1998-01-01' AS Date), N'5862518954 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1122, N'Ivan', N'Radošević', CAST(N'1998-01-01' AS Date), N'8525375245 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1123, N'Antonio', N'Banćič', CAST(N'1998-01-01' AS Date), N'6551685498 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1124, N'Stipe', N'Čulina', CAST(N'1998-01-01' AS Date), N'5685416345 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1125, N'Dujam', N'Džaja', CAST(N'1998-01-01' AS Date), N'5654165476 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1126, N'Dorijan', N'Meštrić', CAST(N'1998-01-01' AS Date), N'645646875  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1127, N'Borna', N'Lušić', CAST(N'1998-01-01' AS Date), N'6546847842 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1128, N'Noel', N'Zumberi', CAST(N'1998-01-01' AS Date), N'5847645484 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1129, N'Alex', N'Cvek', CAST(N'1998-01-01' AS Date), N'5678614654 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1130, N'Lovor', N'Milinović', CAST(N'1998-01-01' AS Date), N'6884658768 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1131, N'Andrea', N'Biasiol', CAST(N'1998-01-01' AS Date), N'5846846554 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1132, N'Leo', N'Varat', CAST(N'1998-01-01' AS Date), N'5687654165 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1133, N'Matej', N'Galić', CAST(N'1998-01-01' AS Date), N'5865465876 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1134, N'Tom', N'Caranović', CAST(N'1998-01-01' AS Date), N'6584651684 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1135, N'Lovro', N'Švelja', CAST(N'1998-01-01' AS Date), N'6884654168 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1136, N'Domagoj ', N'Špoljar', CAST(N'1998-01-01' AS Date), N'8549651468 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1137, N'Ivan', N'Jazbec', CAST(N'1998-01-01' AS Date), N'5468846846 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1138, N'Fran', N'Peranović', CAST(N'1998-01-01' AS Date), N'6846516846 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1139, N'Jakov', N'Matej', CAST(N'1998-01-01' AS Date), N'5498465164 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1140, N'Dominik', N'Slankamenac', CAST(N'1998-01-01' AS Date), N'6846516846 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1141, N'Goran', N'Mirić', CAST(N'1998-01-01' AS Date), N'6586254865 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1142, N'Jakov', N'Piškar', CAST(N'1998-01-01' AS Date), N'6848457898 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1143, N'Lucijan', N'Sablić', CAST(N'1998-01-01' AS Date), N'8684651635 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1144, N'Niko', N'Grubišić', CAST(N'1998-01-01' AS Date), N'8694561684 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1145, N'Marko', N'Strikić', CAST(N'1998-01-01' AS Date), N'4786541321 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1146, N'Bruno', N'Markić', CAST(N'1998-01-01' AS Date), N'8765168786 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1147, N'Andrija', N'Knežević', CAST(N'1998-01-01' AS Date), N'8651867414 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1148, N'Nikola', N'Babić', CAST(N'1998-01-01' AS Date), N'5464521564 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1149, N'Gregor', N'Tuškan', CAST(N'1998-01-01' AS Date), N'8621684761 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1150, N'Ivor', N'Huzjak', CAST(N'1998-01-01' AS Date), N'4684521468 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1151, N'Jan', N'Pavlin', CAST(N'1998-01-01' AS Date), N'684652184  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1152, N'Leon', N'Kožić', CAST(N'1998-01-01' AS Date), N'6846168484 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1153, N'Niko', N'Škrobot', CAST(N'1998-01-01' AS Date), N'8468465184 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1154, N'Roko', N'Cvjetković', CAST(N'1998-01-01' AS Date), N'6846128642 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1155, N'Andrija', N'Mrvac', CAST(N'1998-01-01' AS Date), N'8684621546 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1156, N'Angelo', N'Knežević', CAST(N'1998-01-01' AS Date), N'9687651867 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1157, N'Roko', N'Šimić', CAST(N'1998-01-01' AS Date), N'8943516846 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1158, N'Fran', N'Zadro', CAST(N'1998-01-01' AS Date), N'5646541987 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1159, N'Kristijan', N'Vojković', CAST(N'1998-01-01' AS Date), N'8651687464 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1160, N'Ante ', N'Zečević', CAST(N'1998-01-01' AS Date), N'8651684621 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1161, N'Marcus', N'Leto', CAST(N'1998-01-01' AS Date), N'5846416854 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1162, N'Luka', N'Vrsalović', CAST(N'1998-01-01' AS Date), N'8645218436 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1163, N'Robert', N'Grgac', CAST(N'1998-01-01' AS Date), N'6468412869 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1164, N'Sara', N'Kolaković', CAST(N'1998-01-01' AS Date), N'5646846845 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1165, N'Petra', N'Povrzanović', CAST(N'1998-01-01' AS Date), N'9685468462 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1166, N'Tamara', N'Razvalić', CAST(N'1998-01-01' AS Date), N'8965418949 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1167, N'Victoria', N'Glogolja', CAST(N'1998-01-01' AS Date), N'6498465418 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1168, N'Katarina', N'Bataković', CAST(N'1998-01-01' AS Date), N'4684654865 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1169, N'Marta', N'Mihaljević', CAST(N'1998-01-01' AS Date), N'846848658  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1170, N'Femi', N'Matošević', CAST(N'1998-01-01' AS Date), N'6846548647 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1171, N'Lea', N'Maružin', CAST(N'1998-01-01' AS Date), N'486486154  ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1172, N'Valeria', N'Glogulja', CAST(N'1998-01-01' AS Date), N'4658484687 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1173, N'Iva', N'Jelić', CAST(N'1998-01-01' AS Date), N'4686454877 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1174, N'Ante', N'Čanić', CAST(N'1998-01-01' AS Date), N'6846516784 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1175, N'Dario', N'Ladović', CAST(N'1998-01-01' AS Date), N'5685468465 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1176, N'Patrik', N'Lončarić', CAST(N'1998-01-01' AS Date), N'6558468451 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1177, N'Anton', N'Lončarić', CAST(N'1998-01-01' AS Date), N'8646541678 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1178, N'Marko', N'Iža', CAST(N'1998-01-01' AS Date), N'4654665688 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1179, N'Teo', N'Poldrugovac', CAST(N'1998-01-01' AS Date), N'6846548674 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1180, N'Andrea', N'Milovan', CAST(N'1998-01-01' AS Date), N'1654658645 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1181, N'Frane', N'Puh', CAST(N'1998-01-01' AS Date), N'8456168452 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1182, N'Alex', N'Mihailović', CAST(N'1998-01-01' AS Date), N'5218458675 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1183, N'Denis', N'Zdionica', CAST(N'1998-01-01' AS Date), N'5698214565 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1184, N'Vedran', N'Stojaković', CAST(N'1998-01-01' AS Date), N'1536843218 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1185, N'Karlo ', N'Romanić', CAST(N'1998-01-01' AS Date), N'3854646876 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1186, N'Sven', N'Srkoć', CAST(N'1998-01-01' AS Date), N'4652186762 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1187, N'Jakov', N'Bijelić', CAST(N'1998-01-01' AS Date), N'6454686514 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1188, N'Marko', N'Švalj', CAST(N'1998-01-01' AS Date), N'6548651688 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1189, N'Moreno', N'Pajković', CAST(N'1998-01-01' AS Date), N'6485446876 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1190, N'Sven ', N'Peteh', CAST(N'1998-01-01' AS Date), N'4865168762 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1191, N'Matija', N'Turčić', CAST(N'1998-01-01' AS Date), N'1464251685 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1192, N'Teo', N'Čizić', CAST(N'1998-01-01' AS Date), N'1658534774 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1193, N'Anton', N'Vučinić', CAST(N'1998-01-01' AS Date), N'4865218675 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1194, N'Lovro', N'Stanić', CAST(N'1998-01-01' AS Date), N'4545412252 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1195, N'Leon', N'Jug', CAST(N'1998-01-01' AS Date), N'4862163877 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1196, N'Leon', N'Steiner', CAST(N'1998-01-01' AS Date), N'5432138763 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1197, N'Jan', N'Obić', CAST(N'1998-01-01' AS Date), N'1323528874 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1198, N'Paolo', N'Božac', CAST(N'1998-01-01' AS Date), N'1384652357 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1199, N'Fran', N'Belac', CAST(N'1998-01-01' AS Date), N'4658435213 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1200, N'Mislav', N'Đomlija', CAST(N'1998-01-01' AS Date), N'4163853521 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1201, N'Mateo', N'Iviček', CAST(N'1998-01-01' AS Date), N'4583653687 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1202, N'Brun', N'Zufikarpašić', CAST(N'1998-01-01' AS Date), N'1384635213 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1203, N'Tin', N'Medved', CAST(N'1998-01-01' AS Date), N'4865216387 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1204, N'Dino', N'Salopek', CAST(N'1998-01-01' AS Date), N'4486139863 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1205, N'Tin', N'Jednobrković', CAST(N'1998-01-01' AS Date), N'1684323487 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1206, N'Filip', N'Varaždinec', CAST(N'1998-01-01' AS Date), N'4186213687 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1207, N'Robert', N'Rukavina', CAST(N'1998-01-01' AS Date), N'1864658768 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1208, N'Noah', N'Kordić', CAST(N'1998-01-01' AS Date), N'4163513877 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1209, N'Marko', N'Cepetić', CAST(N'1998-01-01' AS Date), N'4186113874 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1210, N'Filip', N'Mikulić', CAST(N'1998-01-01' AS Date), N'4862134832 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1211, N'Fabio', N'Ipsa', CAST(N'1998-01-01' AS Date), N'6374287645 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1212, N'Antonio', N'Perinić', CAST(N'1998-01-01' AS Date), N'8634727867 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1213, N'Arian', N'Tade', CAST(N'1998-01-01' AS Date), N'3458634578 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1214, N'Luka', N'Ivanušec', CAST(N'1998-01-01' AS Date), N'5675674965 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1215, N'Petar', N'Starčević', CAST(N'1998-01-01' AS Date), N'5678697806 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1216, N'Luka', N'Markulinčić', CAST(N'1998-01-01' AS Date), N'3465475686 ')
GO
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1217, N'Luka', N'Jelić', CAST(N'1998-01-01' AS Date), N'3467656785 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1218, N'Teo', N'Ušić', CAST(N'1998-01-01' AS Date), N'3455756867 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1219, N'Kristijan', N'Papak', CAST(N'1998-01-01' AS Date), N'3454756856 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1220, N'Stipe', N'Koloper', CAST(N'1998-01-01' AS Date), N'4565686544 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1221, N'Nikola', N'Dugopoljac', CAST(N'1998-01-01' AS Date), N'6579789756 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1222, N'Nino', N'Perišić', CAST(N'1998-01-01' AS Date), N'5665869678 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1223, N'Paško', N'Stipandžija', CAST(N'1998-01-01' AS Date), N'4566587807 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1224, N'Valentin', N'Mihalić', CAST(N'1998-01-01' AS Date), N'3456547869 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1225, N'Denis', N'Borna', CAST(N'1998-01-01' AS Date), N'3468697845 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1226, N'Jerko', N'Radovčić', CAST(N'1998-01-01' AS Date), N'3454758945 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1227, N'Mislav', N'Kovačić', CAST(N'1998-01-01' AS Date), N'6808834356 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1228, N'Josip', N'Ćorak', CAST(N'1998-01-01' AS Date), N'2354565870 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1229, N'Fran', N'Čumpek', CAST(N'1998-01-01' AS Date), N'4565869095 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1230, N'Marko', N'Tutić', CAST(N'1998-01-01' AS Date), N'9867554655 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1231, N'Filip', N'Mihalinec', CAST(N'1998-01-01' AS Date), N'4557870876 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1232, N'Viktor', N'Pujas', CAST(N'1998-01-01' AS Date), N'5465676787 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1233, N'Vinko', N'Zoričić', CAST(N'1998-01-01' AS Date), N'6586796756 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1234, N'Leon', N'Puljević', CAST(N'1998-01-01' AS Date), N'5467689780 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1235, N'Vid', N'Ferenčina', CAST(N'1998-01-01' AS Date), N'4567679789 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1236, N'Luka', N'Keran', CAST(N'1998-01-01' AS Date), N'4367678784 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1237, N'Eugen', N'Vrdoljak', CAST(N'1998-01-01' AS Date), N'4576787800 ')
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1238, N'Ivan', N'Picher', CAST(N'1998-01-01' AS Date), N'5678679789 ')
SET IDENTITY_INSERT [dbo].[Veslac] OFF
SET IDENTITY_INSERT [dbo].[Visina] ON 

INSERT [dbo].[Visina] ([IdVisina], [Visina], [VrijemeMjerenje], [IdVeslac]) VALUES (1, CAST(187.00 AS Decimal(5, 2)), CAST(N'2018-09-17 12:30:00.000' AS DateTime), 20)
INSERT [dbo].[Visina] ([IdVisina], [Visina], [VrijemeMjerenje], [IdVeslac]) VALUES (2, CAST(187.75 AS Decimal(5, 2)), CAST(N'2018-10-17 12:30:00.000' AS DateTime), 20)
INSERT [dbo].[Visina] ([IdVisina], [Visina], [VrijemeMjerenje], [IdVeslac]) VALUES (3, CAST(187.75 AS Decimal(5, 2)), CAST(N'2018-11-17 12:30:00.000' AS DateTime), 20)
INSERT [dbo].[Visina] ([IdVisina], [Visina], [VrijemeMjerenje], [IdVeslac]) VALUES (1002, CAST(178.00 AS Decimal(5, 2)), CAST(N'2018-06-01 00:00:00.000' AS DateTime), 20)
SET IDENTITY_INSERT [dbo].[Visina] OFF
/****** Object:  Index [UQ_IdTrening_BrojDionice]    Script Date: 9.6.2018. 12:42:21 ******/
ALTER TABLE [dbo].[DionicaTreninga] ADD  CONSTRAINT [UQ_IdTrening_BrojDionice] UNIQUE NONCLUSTERED 
(
	[IdTrening] ASC,
	[BrojDionice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Regata_BrojKategorije]    Script Date: 9.6.2018. 12:42:21 ******/
ALTER TABLE [dbo].[Kategorija] ADD  CONSTRAINT [UQ_Regata_BrojKategorije] UNIQUE NONCLUSTERED 
(
	[IdRegata] ASC,
	[BrojKategorije] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Masa_Vrijeme]    Script Date: 9.6.2018. 12:42:21 ******/
ALTER TABLE [dbo].[Masa] ADD  CONSTRAINT [UQ_Masa_Vrijeme] UNIQUE NONCLUSTERED 
(
	[IdVeslac] ASC,
	[VrijemeMjerenje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_Kategorija_Kratica]    Script Date: 9.6.2018. 12:42:21 ******/
ALTER TABLE [dbo].[Posada] ADD  CONSTRAINT [UQ_Kategorija_Kratica] UNIQUE NONCLUSTERED 
(
	[IdKategorija] ASC,
	[Kratica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Posada_MjestoUCamcu]    Script Date: 9.6.2018. 12:42:21 ******/
ALTER TABLE [dbo].[PosadaVeslac] ADD  CONSTRAINT [UQ_Posada_MjestoUCamcu] UNIQUE NONCLUSTERED 
(
	[IdPosada] ASC,
	[MjestoUCamcu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Veslac_Klub_DatumPocetak]    Script Date: 9.6.2018. 12:42:21 ******/
ALTER TABLE [dbo].[PripadnostKlubu] ADD  CONSTRAINT [UQ_Veslac_Klub_DatumPocetak] UNIQUE NONCLUSTERED 
(
	[IdVeslac] ASC,
	[IdKlub] ASC,
	[DatumPocetak] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_KontrolnaTocka_Rezultat]    Script Date: 9.6.2018. 12:42:21 ******/
ALTER TABLE [dbo].[ProlaznoVrijeme] ADD  CONSTRAINT [UQ_KontrolnaTocka_Rezultat] UNIQUE NONCLUSTERED 
(
	[IdKontrolnaTocka] ASC,
	[IdRezultat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Rezultat_Posada]    Script Date: 9.6.2018. 12:42:21 ******/
ALTER TABLE [dbo].[Rezultat] ADD  CONSTRAINT [UQ_Rezultat_Posada] UNIQUE NONCLUSTERED 
(
	[IdUtrka] ASC,
	[IdPosada] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Visina_Vrijeme]    Script Date: 9.6.2018. 12:42:21 ******/
ALTER TABLE [dbo].[Visina] ADD  CONSTRAINT [UQ_Visina_Vrijeme] UNIQUE NONCLUSTERED 
(
	[VrijemeMjerenje] ASC,
	[Visina] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DionicaTreninga]  WITH CHECK ADD  CONSTRAINT [FK_DionicaTreninga_Trening] FOREIGN KEY([IdTrening])
REFERENCES [dbo].[Trening] ([IdTrening])
GO
ALTER TABLE [dbo].[DionicaTreninga] CHECK CONSTRAINT [FK_DionicaTreninga_Trening]
GO
ALTER TABLE [dbo].[Kategorija]  WITH CHECK ADD  CONSTRAINT [FK_Kategorija_Camac] FOREIGN KEY([IdCamac])
REFERENCES [dbo].[Camac] ([IdCamac])
GO
ALTER TABLE [dbo].[Kategorija] CHECK CONSTRAINT [FK_Kategorija_Camac]
GO
ALTER TABLE [dbo].[Kategorija]  WITH CHECK ADD  CONSTRAINT [FK_Kategorija_Regata] FOREIGN KEY([IdRegata])
REFERENCES [dbo].[Regata] ([IdRegata])
GO
ALTER TABLE [dbo].[Kategorija] CHECK CONSTRAINT [FK_Kategorija_Regata]
GO
ALTER TABLE [dbo].[Kategorija]  WITH CHECK ADD  CONSTRAINT [FK_Kategorija_StarosnaKategorija] FOREIGN KEY([IdStarosnaKategorija])
REFERENCES [dbo].[StarosnaKategorija] ([IdStarosnaKategorija])
GO
ALTER TABLE [dbo].[Kategorija] CHECK CONSTRAINT [FK_Kategorija_StarosnaKategorija]
GO
ALTER TABLE [dbo].[Masa]  WITH CHECK ADD  CONSTRAINT [FK_Masa_Veslac] FOREIGN KEY([IdVeslac])
REFERENCES [dbo].[Veslac] ([IdVeslac])
GO
ALTER TABLE [dbo].[Masa] CHECK CONSTRAINT [FK_Masa_Veslac]
GO
ALTER TABLE [dbo].[Posada]  WITH CHECK ADD  CONSTRAINT [FK_Posada_Kategorija] FOREIGN KEY([IdKategorija])
REFERENCES [dbo].[Kategorija] ([IdKategorija])
GO
ALTER TABLE [dbo].[Posada] CHECK CONSTRAINT [FK_Posada_Kategorija]
GO
ALTER TABLE [dbo].[PosadaVeslac]  WITH CHECK ADD  CONSTRAINT [FK_PosadaVeslac_Posada] FOREIGN KEY([IdPosada])
REFERENCES [dbo].[Posada] ([IdPosada])
GO
ALTER TABLE [dbo].[PosadaVeslac] CHECK CONSTRAINT [FK_PosadaVeslac_Posada]
GO
ALTER TABLE [dbo].[PosadaVeslac]  WITH CHECK ADD  CONSTRAINT [FK_PosadaVeslac_Veslac] FOREIGN KEY([IdVeslac])
REFERENCES [dbo].[Veslac] ([IdVeslac])
GO
ALTER TABLE [dbo].[PosadaVeslac] CHECK CONSTRAINT [FK_PosadaVeslac_Veslac]
GO
ALTER TABLE [dbo].[PripadnostKlubu]  WITH CHECK ADD  CONSTRAINT [FK_PripadnostKlubu_Klub] FOREIGN KEY([IdKlub])
REFERENCES [dbo].[Klub] ([IdKlub])
GO
ALTER TABLE [dbo].[PripadnostKlubu] CHECK CONSTRAINT [FK_PripadnostKlubu_Klub]
GO
ALTER TABLE [dbo].[PripadnostKlubu]  WITH CHECK ADD  CONSTRAINT [FK_PripadnostKlubu_Veslac] FOREIGN KEY([IdVeslac])
REFERENCES [dbo].[Veslac] ([IdVeslac])
GO
ALTER TABLE [dbo].[PripadnostKlubu] CHECK CONSTRAINT [FK_PripadnostKlubu_Veslac]
GO
ALTER TABLE [dbo].[ProlaznoVrijeme]  WITH CHECK ADD  CONSTRAINT [FK_Vrijeme_KontrolnaTocka] FOREIGN KEY([IdKontrolnaTocka])
REFERENCES [dbo].[KontrolnaTocka] ([IdKontrolnaTocka])
GO
ALTER TABLE [dbo].[ProlaznoVrijeme] CHECK CONSTRAINT [FK_Vrijeme_KontrolnaTocka]
GO
ALTER TABLE [dbo].[ProlaznoVrijeme]  WITH CHECK ADD  CONSTRAINT [FK_Vrijeme_Rezultat] FOREIGN KEY([IdRezultat])
REFERENCES [dbo].[Rezultat] ([IdRezultat])
GO
ALTER TABLE [dbo].[ProlaznoVrijeme] CHECK CONSTRAINT [FK_Vrijeme_Rezultat]
GO
ALTER TABLE [dbo].[Regata]  WITH CHECK ADD  CONSTRAINT [FK_Regata_Staza] FOREIGN KEY([IdLokacija])
REFERENCES [dbo].[Lokacija] ([IdLokacija])
GO
ALTER TABLE [dbo].[Regata] CHECK CONSTRAINT [FK_Regata_Staza]
GO
ALTER TABLE [dbo].[Rezultat]  WITH CHECK ADD  CONSTRAINT [FK_Rezultat_Posada] FOREIGN KEY([IdPosada])
REFERENCES [dbo].[Posada] ([IdPosada])
GO
ALTER TABLE [dbo].[Rezultat] CHECK CONSTRAINT [FK_Rezultat_Posada]
GO
ALTER TABLE [dbo].[Rezultat]  WITH CHECK ADD  CONSTRAINT [FK_Rezultat_Utrka] FOREIGN KEY([IdUtrka])
REFERENCES [dbo].[Utrka] ([IdUtrka])
GO
ALTER TABLE [dbo].[Rezultat] CHECK CONSTRAINT [FK_Rezultat_Utrka]
GO
ALTER TABLE [dbo].[Trening]  WITH CHECK ADD  CONSTRAINT [FK_Trening_TipTreninga] FOREIGN KEY([IdTipTreninga])
REFERENCES [dbo].[TipTreninga] ([IdTipTreninga])
GO
ALTER TABLE [dbo].[Trening] CHECK CONSTRAINT [FK_Trening_TipTreninga]
GO
ALTER TABLE [dbo].[Trening]  WITH CHECK ADD  CONSTRAINT [FK_Trening_Veslac] FOREIGN KEY([IdVeslac])
REFERENCES [dbo].[Veslac] ([IdVeslac])
GO
ALTER TABLE [dbo].[Trening] CHECK CONSTRAINT [FK_Trening_Veslac]
GO
ALTER TABLE [dbo].[Utrka]  WITH CHECK ADD  CONSTRAINT [FK_Utrka_Kategorija] FOREIGN KEY([IdKategorija])
REFERENCES [dbo].[Kategorija] ([IdKategorija])
GO
ALTER TABLE [dbo].[Utrka] CHECK CONSTRAINT [FK_Utrka_Kategorija]
GO
ALTER TABLE [dbo].[Utrka]  WITH CHECK ADD  CONSTRAINT [FK_Utrka_RangUtrke] FOREIGN KEY([IdRangUtrke])
REFERENCES [dbo].[RangUtrke] ([IdRangUtrke])
GO
ALTER TABLE [dbo].[Utrka] CHECK CONSTRAINT [FK_Utrka_RangUtrke]
GO
ALTER TABLE [dbo].[Visina]  WITH CHECK ADD  CONSTRAINT [FK_Visina_Veslac] FOREIGN KEY([IdVeslac])
REFERENCES [dbo].[Veslac] ([IdVeslac])
GO
ALTER TABLE [dbo].[Visina] CHECK CONSTRAINT [FK_Visina_Veslac]
GO
ALTER TABLE [dbo].[PripadnostKlubu]  WITH CHECK ADD  CONSTRAINT [CH_DatumPocetak_DatumKraj] CHECK  (([DatumPocetak]<[DatumKraj] OR [DatumKraj] IS NULL))
GO
ALTER TABLE [dbo].[PripadnostKlubu] CHECK CONSTRAINT [CH_DatumPocetak_DatumKraj]
GO
USE [master]
GO
ALTER DATABASE [InformacijskiSustav] SET  READ_WRITE 
GO
