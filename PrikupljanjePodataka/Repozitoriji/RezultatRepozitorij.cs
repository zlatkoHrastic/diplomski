using Dapper;
using PrikupljanjePodataka.DTO;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

namespace PrikupljanjePodataka.Repozitoriji
{
    public class RezultatRepozitorij
    {
        public bool SpremiRezultat(RezultatDTO rezultat)
        {
            string query = "INSERT INTO [dbo].[ProlaznoVrijeme]([IdKontrolnaTocka],[IdRezultat],[Vrijeme])VALUES(4,@IdRezultat,@Vrijeme)";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                var brRedova = connection.Execute(query, rezultat);
                return brRedova > 0;
            }
        }
    }
}