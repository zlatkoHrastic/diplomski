using Dapper;
using PrikupljanjePodataka.DTO;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

namespace PrikupljanjePodataka.Repozitoriji
{
    public class RegataRepozitorij
    {
        public bool SpremiRegatu(RegataDTO regata)
        {
            string query = "INSERT INTO [dbo].[Regata]([Ime],[DatumPocetak],[DatumKraj],[IdLokacija])VALUES(@ImeRegate,@VrijemeOd,@VrijemeDo,@IdLokacija)";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                var brRedova = connection.Execute(query, regata);
                return brRedova > 0;
            }
        }
        public List<SelectDTO> DohvatiRegate()
        {
            string query = "SELECT [IdRegata] AS Id,[Ime] AS Value FROM [dbo].[Regata]";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                return connection.Query<SelectDTO>(query).ToList();
            }
        }
        public SelectDTO DohvatiRegatu(int idRegata)
        {
            string query = "SELECT [IdRegata] AS Id,[Ime] AS Value FROM [dbo].[Regata] WHERE IdRegata=@idRegata";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                return connection.Query<SelectDTO>(query, new { idRegata }).FirstOrDefault();
            }
        }
    }
}