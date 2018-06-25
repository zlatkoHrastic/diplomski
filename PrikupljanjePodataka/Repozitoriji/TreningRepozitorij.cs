using Dapper;
using PrikupljanjePodataka.DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

namespace PrikupljanjePodataka.Repozitoriji
{
    public class TreningRepozitorij
    {
        public int SpremiTrening(int idVeslac, TimeSpan vrijemeTreninga, int idTipTreninga)
        {
            string query = "INSERT INTO [dbo].[Trening]([IdVeslac],[VrijemeTreninga],[IdTipTreninga]) OUTPUT INSERTED.[IdTrening] VALUES(@idVeslac, @vrijemeTreninga, @idTipTreninga)";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                return connection.QuerySingle<int>(query, new { idVeslac, vrijemeTreninga, idTipTreninga });
            }
        }

        public bool DodajVrijemeUTrening(int idTrening, TimeSpan vrijeme, int brojDionice)
        {
            string query = "INSERT INTO [dbo].[DionicaTreninga]([IdTrening],[BrojDionice],[Vrijeme])VALUES(@idTrening,@brojDionice,@vrijeme)";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                var brRedova = connection.Execute(query, new { idTrening, brojDionice, vrijeme });
                return brRedova > 0;
            }
        }
    }
}