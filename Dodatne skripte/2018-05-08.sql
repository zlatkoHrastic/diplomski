USE [InformacijskiSustav]
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
SET IDENTITY_INSERT [dbo].[Lokacija] ON 

INSERT [dbo].[Lokacija] ([IdLokacija], [Naziv], [GeografskaSirina], [GeografskaVisina]) VALUES (1, N'Jarun', 45.786586, 15.912412)
INSERT [dbo].[Lokacija] ([IdLokacija], [Naziv], [GeografskaSirina], [GeografskaVisina]) VALUES (2, N'Bakar', 45.30699, 14.535673)
SET IDENTITY_INSERT [dbo].[Lokacija] OFF
SET IDENTITY_INSERT [dbo].[Regata] ON 

INSERT [dbo].[Regata] ([IdRegata], [Ime], [DatumPocetak], [DatumKraj], [IdLokacija]) VALUES (1, N'1. Regata VKMF', CAST(N'2018-09-17' AS Date), CAST(N'2018-09-17' AS Date), 1)
INSERT [dbo].[Regata] ([IdRegata], [Ime], [DatumPocetak], [DatumKraj], [IdLokacija]) VALUES (2, N'Multiple test', CAST(N'2018-06-17' AS Date), CAST(N'2018-06-17' AS Date), 2)
SET IDENTITY_INSERT [dbo].[Regata] OFF
SET IDENTITY_INSERT [dbo].[StarosnaKategorija] ON 

INSERT [dbo].[StarosnaKategorija] ([IdStarosnaKategorija], [Oznaka], [Ime], [StarostPocetak], [StarostKraj]) VALUES (3, N'KM', N'Kadeti', NULL, 14)
INSERT [dbo].[StarosnaKategorija] ([IdStarosnaKategorija], [Oznaka], [Ime], [StarostPocetak], [StarostKraj]) VALUES (4, N'JMB', N'Mlađi Juniori', 15, 16)
INSERT [dbo].[StarosnaKategorija] ([IdStarosnaKategorija], [Oznaka], [Ime], [StarostPocetak], [StarostKraj]) VALUES (5, N'JMA', N'Juniori', 17, 18)
INSERT [dbo].[StarosnaKategorija] ([IdStarosnaKategorija], [Oznaka], [Ime], [StarostPocetak], [StarostKraj]) VALUES (6, N'SM', N'Seniori', 19, NULL)
SET IDENTITY_INSERT [dbo].[StarosnaKategorija] OFF
SET IDENTITY_INSERT [dbo].[Kategorija] ON 

INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica]) VALUES (1, 1, 4, 2, N'2-JMB')
INSERT [dbo].[Kategorija] ([IdKategorija], [IdRegata], [IdStarosnaKategorija], [IdCamac], [Kratica]) VALUES (2, 1, 4, 1, N'1XJMB')
SET IDENTITY_INSERT [dbo].[Kategorija] OFF
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
SET IDENTITY_INSERT [dbo].[Posada] OFF
SET IDENTITY_INSERT [dbo].[RangUtrke] ON 

INSERT [dbo].[RangUtrke] ([IdRangUtrke], [Kratica], [Naziv]) VALUES (1, N'FA', N'Finale A')
INSERT [dbo].[RangUtrke] ([IdRangUtrke], [Kratica], [Naziv]) VALUES (2, N'FB', N'Finale B')
INSERT [dbo].[RangUtrke] ([IdRangUtrke], [Kratica], [Naziv]) VALUES (3, N'KV', N'Kvalifikacije')
SET IDENTITY_INSERT [dbo].[RangUtrke] OFF
SET IDENTITY_INSERT [dbo].[Utrka] ON 

INSERT [dbo].[Utrka] ([IdUtrka], [IdKategorija], [IdRangUtrke], [RedniBroj], [StartnoVrijeme]) VALUES (1, 1, 1, 35, CAST(N'2018-04-15 15:38:00.0000000' AS DateTime2))
INSERT [dbo].[Utrka] ([IdUtrka], [IdKategorija], [IdRangUtrke], [RedniBroj], [StartnoVrijeme]) VALUES (2, 2, 3, 9, CAST(N'2018-09-17 11:56:00.0000000' AS DateTime2))
INSERT [dbo].[Utrka] ([IdUtrka], [IdKategorija], [IdRangUtrke], [RedniBroj], [StartnoVrijeme]) VALUES (3, 2, 3, 10, CAST(N'2018-09-17 12:03:00.0000000' AS DateTime2))
INSERT [dbo].[Utrka] ([IdUtrka], [IdKategorija], [IdRangUtrke], [RedniBroj], [StartnoVrijeme]) VALUES (4, 2, 3, 11, CAST(N'2018-09-17 12:10:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Utrka] OFF
SET IDENTITY_INSERT [dbo].[Klub] ON 

INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (1, N'Croatia', N'CRO')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (2, N'Istra', N'IST')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (3, N'Jarun', N'JAR')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (4, N'Mladost', N'MLA')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (5, N'Zagreb', N'ZAG')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (6, N'Iktus', N'IKT')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (7, N'Korana', N'KOR')
INSERT [dbo].[Klub] ([IdKlub], [Ime], [Kratica]) VALUES (8, N'Trešnjevka', N'TRE')
SET IDENTITY_INSERT [dbo].[Klub] OFF
SET IDENTITY_INSERT [dbo].[Veslac] ON 

INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (1, N'Dominik', N'Vukmanić', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (2, N'Lukas', N'Jovakarić', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (3, N'Domagoj', N'Alber', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (4, N'Paulo', N'Possi', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (5, N'Drago', N'Tolić', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (6, N'Antoni', N'Dovođa', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (7, N'Zvonimir', N'Bandov', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (8, N'Lovro', N'Šurina', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (9, N'Benedikt Petar', N'Barun', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (10, N'Vinko', N'Brezić', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (11, N'Ante', N'Canic', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (12, N'Dario', N'Ladovic', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (13, N'Patrik', N'Loncaric', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (14, N'Anton', N'Loncaric', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (15, N'Marko', N'Iža', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (16, N'Teo', N'Poldrugovac', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (17, N'Andrea', N'Milovan', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (18, N'Frane', N'Puh', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (19, N'Alex', N'Mihailovic', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (20, N'Denis', N'Zdionica', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (21, N'Vedran', N'Stojakovic', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (22, N'Karlo', N'Romanic', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (23, N'Sven', N'Srkoc', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (24, N'Jakov', N'Bijelic', NULL, NULL)
INSERT [dbo].[Veslac] ([IdVeslac], [Ime], [Prezime], [DatumRodenja], [OIB]) VALUES (25, N'Marko', N'Švalj', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Veslac] OFF
SET IDENTITY_INSERT [dbo].[PripadnostKlubu] ON 

INSERT [dbo].[PripadnostKlubu] ([IdPripadnostKlubu], [IdVeslac], [IdKlub], [DatumPocetak], [DatumKraj]) VALUES (2, 1, 1, CAST(N'2018-01-01 00:00:00.000' AS DateTime), NULL)
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
SET IDENTITY_INSERT [dbo].[PripadnostKlubu] OFF
SET IDENTITY_INSERT [dbo].[KontrolnaTocka] ON 

INSERT [dbo].[KontrolnaTocka] ([IdKontrolnaTocka], [Udaljenost]) VALUES (1, 500)
INSERT [dbo].[KontrolnaTocka] ([IdKontrolnaTocka], [Udaljenost]) VALUES (2, 1000)
INSERT [dbo].[KontrolnaTocka] ([IdKontrolnaTocka], [Udaljenost]) VALUES (3, 1500)
INSERT [dbo].[KontrolnaTocka] ([IdKontrolnaTocka], [Udaljenost]) VALUES (4, 2000)
SET IDENTITY_INSERT [dbo].[KontrolnaTocka] OFF
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
SET IDENTITY_INSERT [dbo].[Rezultat] OFF
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
SET IDENTITY_INSERT [dbo].[ProlaznoVrijeme] OFF
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
