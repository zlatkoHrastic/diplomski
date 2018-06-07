using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.DTO
{
    public class PosadaUUtrkuViewModel
    {
        public List<SelectDTO> Posade { get; set; }
        public List<SelectDTO> Utrke { get; set; }
    }
}