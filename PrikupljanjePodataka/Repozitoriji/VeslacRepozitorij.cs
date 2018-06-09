using Dapper;
using PrikupljanjePodataka.DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

namespace PrikupljanjePodataka.Repozitoriji
{
    public class VeslacRepozitorij
    {
        public bool SpremiVeslaca(VeslacDTO veslac)
        {
            if (veslac.Oib.Length >= 10)
            {
                veslac.Oib = veslac.Oib.Substring(0, 10);
            }
            
            string query = "INSERT INTO [dbo].[Veslac]([Ime],[Prezime],[DatumRodenja],[OIB])VALUES(@Ime,@Prezime,@DatumRodjenja,@Oib)";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                var brRedova = connection.Execute(query, veslac);
                return brRedova > 0;
            }
        }

        public List<SelectDTO> DohvatiVeslace()
        {
            string query = "SELECT [IdVeslac] AS Id,[Ime]+' '+[Prezime] AS Value FROM [dbo].[Veslac]";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                return connection.Query<SelectDTO>(query).ToList();
            }
        }


        public bool SpremiMasuVeslaca(MasaDTO masaVeslaca)
        {
            string query = "INSERT INTO [dbo].[Masa]([Masa],[VrijemeMjerenje] ,[IdVeslac]) VALUES(@Masa,@VrijemeMjerenje,@IdVeslac)";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                var brRedova = connection.Execute(query, masaVeslaca);
                return brRedova > 0;
            }
        }


        public bool SpremiVisinuVeslaca(VisinaDTO visinaVeslaca)
        {
            string query = "INSERT INTO [dbo].[Visina]([Visina],[VrijemeMjerenje] ,[IdVeslac]) VALUES(@Visina,@VrijemeMjerenje,@IdVeslac)";
            using (var connection = new SqlConnection(Repozitorij.Konekcija))
            {
                var brRedova = connection.Execute(query, visinaVeslaca);
                return brRedova > 0;
            }
        }
    }
}