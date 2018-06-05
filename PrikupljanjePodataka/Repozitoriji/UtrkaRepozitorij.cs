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
    }
}