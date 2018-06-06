using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.DTO
{
    public class PripadnostKlubuViewModel
    {
        public List<SelectDTO> Klubovi { get; set; }
        public List<SelectDTO> Veslaci { get; set; }
    }
}