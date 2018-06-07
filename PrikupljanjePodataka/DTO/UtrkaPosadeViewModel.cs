using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.DTO
{
    public class UtrkaPosadeViewModel
    {
        public SelectDTO Regata { get; set; }
        public List<SelectDTO> Utrke { get; set; }
        public List<SelectDTO> Posade { get; set; }
    } 
}