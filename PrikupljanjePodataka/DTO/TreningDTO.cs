using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.DTO
{
    public class TreningDTO
    {
        public int IdVeslac { get; set; }
        public int IdTipTreninga { get; set; }
        public TimeSpan VrijemeTreninga { get; set; }
        public TimeSpan Dionica1 { get; set; }
        public TimeSpan Dionica2 { get; set; }
        public TimeSpan Dionica3 { get; set; }

    }
}