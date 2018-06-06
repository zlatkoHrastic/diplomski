using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.DTO
{
    public class MasaDTO
    {
        public int IdVeslac { get; set; }
        public DateTime VrijemeMjerenje { get; set; }
        public float Masa { get; set; }
         
    }
}