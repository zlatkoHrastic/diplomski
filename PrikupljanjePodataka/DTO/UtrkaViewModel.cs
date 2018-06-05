using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.DTO
{
    public class UtrkaViewModel
    {
        public SelectDTO Regata { get; set; }
        public List<SelectDTO> Kategorije { get; set; }
    } 
}