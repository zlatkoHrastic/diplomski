using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.DTO
{
    public class UtrkaDTO
    {
        public int IdKategorija { get; set; }
        public int IdRangUtrke { get; set; }
        public int RedniBroj { get; set; }
        public DateTime StartnoVrijeme { get; set; }
    }
}