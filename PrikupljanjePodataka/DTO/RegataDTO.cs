using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.DTO
{
    public class RegataDTO
    {
        public string ImeRegate { get; set; }
        public DateTime VrijemeOd { get; set; }
        public DateTime VrijemeDo { get; set; }
        public int IdLokacija { get; set; }
    }
}