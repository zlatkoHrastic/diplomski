using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.DTO
{
    public class PosadaDTO
    {
        public string KraticaPosade { get; set; }
        public int IdKategorija { get; set; }
        public List<int> ListaIdVeslac { get; set; }
    }
}