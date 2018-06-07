using Dapper;
using PrikupljanjePodataka.DTO;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

namespace PrikupljanjePodataka.Repozitoriji
{
    public class UtrkaRepozitorij
    {
        public bool SpremiUtrku(UtrkaDTO utrka)
        {
            string query = "INSERT INTO [dbo].[Utrka]([IdKategorija],[IdRangUtrke],[RedniBroj],[StartnoVrijeme]) VALUES(@IdKategorija,@IdRangUtrke,@RedniBroj,@StartnoVrijeme)";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                var brRedova = connection.Execute(query, utrka);
                return brRedova > 0;
            }
        }

        public bool DodajPosaduUUtrku(PosadaUUtrciDTO posada)
        {
            string query = "INSERT INTO [dbo].[Rezultat]([IdUtrka],[IdPosada],[Staza]) VALUES(@IdUtrka,@IdPosada,@Staza)";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                var brRedova = connection.Execute(query, posada);
                return brRedova > 0;
            }
        }

        public List<UtrkaNaRegatiDTO> DohvatiUtrkeIzKategorije(int idKategorija)
        {
            string query = "SELECT  [IdUtrka],[Kategorija].[Kratica] AS Kategorija,[RangUtrke].Kratica AS RangUtrke,[RedniBroj]FROM [InformacijskiSustav].[dbo].[Utrka]JOIN Kategorija on Utrka.IdKategorija=Kategorija.IdKategorija JOIN RangUtrke on RangUtrke.IdRangUtrke=Utrka.IdRangUtrke WHERE Utrka.IdKategorija=@idKategorija";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                return connection.Query<UtrkaNaRegatiDTO>(query, new { idKategorija }).ToList();
            }
        }

        public List<UtrkaNaRegatiDTO> DohvatiUtrkeIzRegate(int idRegata)
        {
            string query = "SELECT  [IdUtrka],[Kategorija].[Kratica] AS Kategorija,[RangUtrke].Kratica AS RangUtrke,[RedniBroj]FROM [InformacijskiSustav].[dbo].[Utrka]JOIN Kategorija on Utrka.IdKategorija=Kategorija.IdKategorija JOIN RangUtrke on RangUtrke.IdRangUtrke=Utrka.IdRangUtrke WHERE Kategorija.IdRegata=@idRegata";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                return connection.Query<UtrkaNaRegatiDTO>(query, new { idRegata }).ToList();
            }
        }
    }
}