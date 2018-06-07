using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.DTO
{
    public class UtrkaNaRegatiDTO
    {        
        public int IdUtrka { get; set; }
        public int RedniBroj { get; set; }
        public string Kategorija { get; set; }
        public string RangUtrke { get; set; }
    }
}