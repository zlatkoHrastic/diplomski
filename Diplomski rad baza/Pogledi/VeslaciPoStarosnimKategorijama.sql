CREATE VIEW [dbo].[VeslaciPoStarosnimKategorijama]
	AS SELECT IdStarosnaKategorija,klub.IdKlub ,COUNT(PripadnostKlubu.IdPripadnostKlubu) AS BrojVeslaca
FROM StarosnaKategorija
FULL OUTER JOIN Klub on 1=1
LEFT OUTER JOIN Veslac on YEAR(CURRENT_TIMESTAMP)-YEAR(Veslac.DatumRodenja)>=StarosnaKategorija.StarostPocetak AND (YEAR(CURRENT_TIMESTAMP)-YEAR(Veslac.DatumRodenja))<=StarosnaKategorija.StarostKraj
LEFT OUTER JOIN PripadnostKlubu ON PripadnostKlubu.IdVeslac=Veslac.IdVeslac AND PripadnostKlubu.IdKlub=Klub.IdKlub
WHERE PripadnostKlubu.DatumKraj IS NULL
GROUP BY klub.IdKlub,StarosnaKategorija.IdStarosnaKategorija;
