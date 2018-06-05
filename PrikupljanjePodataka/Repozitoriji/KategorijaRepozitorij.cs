using Dapper;
using PrikupljanjePodataka.DTO;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;


namespace PrikupljanjePodataka.Repozitoriji
{
    public class KategorijaRepozitorij
    {
        public List<SelectDTO> DohvatiStarosneKategorije()
        {
            string query = "SELECT [IdStarosnaKategorija] AS Id,[Oznaka] AS Value FROM [dbo].[StarosnaKategorija]";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                return connection.Query<SelectDTO>(query).ToList();
            }
        }

        public List<SelectDTO> DohvatiCamce()
        {
            string query = "SELECT [IdCamac] AS Id,[Oznaka] AS Value FROM [dbo].[Camac]";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                return connection.Query<SelectDTO>(query).ToList();
            }
        }

        public bool SpremiKategoriju(KategorijaDTO kategorija)
        {
            string query = "INSERT INTO [dbo].[Kategorija] ([IdRegata],[IdStarosnaKategorija],[IdCamac],[Kratica],[BrojKategorije]) VALUES(@IdRegata,@IdStarosnaKategorija,@IdCamac,@Kratica,@BrojKategorije)";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                var brRedova = connection.Execute(query, kategorija);
                return brRedova > 0;
            }
        }
    }
}