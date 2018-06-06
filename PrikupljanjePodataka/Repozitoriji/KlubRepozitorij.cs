using Dapper;
using PrikupljanjePodataka.DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
namespace PrikupljanjePodataka.Repozitoriji
{
    public class KlubRepozitorij
    {

        public List<SelectDTO> DohvatiKlubove()
        {
            string query = "SELECT [IdKlub] AS Id,[Ime] AS Value FROM [dbo].[Klub]";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                return connection.Query<SelectDTO>(query).ToList();
            }
        }

        public bool SpremiKlub(KlubDTO klub)
        {
            string query = "INSERT INTO [dbo].[Klub]([Ime],[Kratica])VALUES(@ImeKlub,@KraticaKlub)";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                var brRedova = connection.Execute(query, klub);
                return brRedova > 0;
            }
        }

        public bool SpremiPripadnostKlubu(PripadnostKlubuDTO pripadnost)
        {
            string query = "INSERT INTO [dbo].[PripadnostKlubu]([IdVeslac],[IdKlub],[DatumPocetak],[DatumKraj])VALUES(@IdVeslac,@IdKlub,@DatumPocetak,@DatumKraj)";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                var brRedova = connection.Execute(query, pripadnost);
                return brRedova > 0;
            }
        }
    }
}