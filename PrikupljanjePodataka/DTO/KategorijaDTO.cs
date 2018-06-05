using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.DTO
{
    public class KategorijaDTO
    {
        public int IdRegata { get; set; }
        public int IdCamac { get; set; }
        public int IdStarosnaKategorija { get; set; }
        public int BrojKategorije { get; set; }
        public string Kratica { get; set; }
    }
}