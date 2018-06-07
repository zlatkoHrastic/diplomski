using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.DTO
{
    public class RezultatParcijalniDTO
    {
        public int IdRezultat { get; set; }
        public int Minute { get; set; }
        public int Sekunde { get; set; }
        public int Stotinke { get; set; }
    }
}