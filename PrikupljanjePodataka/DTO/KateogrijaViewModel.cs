using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.DTO
{
    public class KateogrijaViewModel
    {
        public List<SelectDTO> Regate { get; set; }
        public List<SelectDTO> StarosneKategorije { get; set; }
        public List<SelectDTO> Camci { get; set; }
    }
}