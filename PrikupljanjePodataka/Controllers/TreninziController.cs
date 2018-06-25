using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PrikupljanjePodataka.DTO;
using PrikupljanjePodataka.PoslovniSloj;
using PrikupljanjePodataka.Repozitoriji;

namespace PrikupljanjePodataka.Controllers
{
    public class TreninziController : Controller
    {
        // GET: Treninzi
        public ActionResult Index()
        {
            var veslacRepozitorij = new VeslacRepozitorij();
            var veslaci = veslacRepozitorij.DohvatiVeslace();
            return View(veslaci);
        }

        [HttpPost]
        public ActionResult Index(TreningDTO trening)
        {

            var minute = Int32.Parse(Request.Params["Minute1"]);
            var sekunde = Int32.Parse(Request.Params["Sekunde1"]);
            var stotinke = Int32.Parse(Request.Params["Stotinke1"]);
            trening.Dionica1 = new TimeSpan(0, 0, minute, sekunde, stotinke * 10);

            minute = Int32.Parse(Request.Params["Minute2"]);
            sekunde = Int32.Parse(Request.Params["Sekunde2"]);
            stotinke = Int32.Parse(Request.Params["Stotinke2"]);
            trening.Dionica2 = new TimeSpan(0, 0, minute, sekunde, stotinke * 10);

            if (trening.IdTipTreninga > 2)
            {
                minute = Int32.Parse(Request.Params["Minute3"]);
                sekunde = Int32.Parse(Request.Params["Sekunde3"]);
                stotinke = Int32.Parse(Request.Params["Stotinke3"]);
                trening.Dionica3 = new TimeSpan(0, 0, minute, sekunde, stotinke * 10);
            }

            var treningServis = new Trening();
            treningServis.StvoriTrening(trening);

            var veslacRepozitorij = new VeslacRepozitorij();
            var veslaci = veslacRepozitorij.DohvatiVeslace();
            return View(veslaci);
        }
    }
}