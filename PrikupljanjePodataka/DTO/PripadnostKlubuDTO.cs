using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.DTO
{
    public class PripadnostKlubuDTO
    {
        public int IdVeslac { get; set; }
        public int IdKlub { get; set; }
        public DateTime DatumPocetak { get; set; }
        public DateTime? DatumKraj { get; set; }
    }
}