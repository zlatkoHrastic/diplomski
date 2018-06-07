using Dapper;
using PrikupljanjePodataka.DTO;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
namespace PrikupljanjePodataka.Repozitoriji
{
    public class PosadaRepozitorij
    {
        public int SpremiPosadu(PosadaDTO posada)
        {
            string query = "INSERT INTO [dbo].[Posada]([IdKategorija],[Kratica]) OUTPUT INSERTED.[IdPosada] VALUES(@IdKategorija,@Kratica)";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                return connection.QuerySingle<int>(query, new { IdKategorija = posada.IdKategorija, Kratica = posada.KraticaPosade });
                //return connection.Query<int>("SELECT SCOPE_IDENTITY()").FirstOrDefault();
            }
        }

        public bool DodajVeslacaUPosadu(int idPosada, int idVeslac, int mjestoUCamcu)
        {
            string query = "INSERT INTO [dbo].[PosadaVeslac]([IdPosada],[IdVeslac],[MjestoUCamcu])VALUES(@IdPosada,@IdVeslac,@Mjesto)";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                var brRedova = connection.Execute(query, new { IdPosada = idPosada, idVeslac = idVeslac, Mjesto = mjestoUCamcu });
                return brRedova > 0;
            }
        }

        public List<SelectDTO> DohvatiPosadeIzKategorije(int idKategorija)
        {
            string query = "SELECT  [IdPosada] AS Id,[Kratica] AS Value FROM [dbo].[Posada] WHERE IdKategorija=@IdKategorija";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                return connection.Query<SelectDTO>(query, new { idKategorija }).ToList();
            }
        }
        //SELECT [Posada].[IdPosada],[Kratica] FROM [Posada] JOIN Rezultat ON Rezultat.IdPosada=Posada.IdPosada WHERE Rezultat.IdUtrka=1

        public List<SelectDTO> DohvatiPosadeIzUtrke(int idUtrka)
        {
            string query = "SELECT [Rezultat].[IdRezultat] AS Id,[Kratica] AS Value FROM [Posada] JOIN Rezultat ON Rezultat.IdPosada=Posada.IdPosada WHERE Rezultat.IdUtrka=@idUtrka";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                return connection.Query<SelectDTO>(query, new { idUtrka }).ToList();
            }
        }
    }
}