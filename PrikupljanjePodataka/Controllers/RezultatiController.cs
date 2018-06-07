using PrikupljanjePodataka.DTO;
using PrikupljanjePodataka.PoslovniSloj;
using PrikupljanjePodataka.Repozitoriji;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PrikupljanjePodataka.Controllers
{
    public class RezultatiController : Controller
    {
        // GET: Rezultati
        public ActionResult Index()
        {
            var regataRepozitorij = new RegataRepozitorij();
            var regate = regataRepozitorij.DohvatiRegate();
            return View(regate);
        }

        //idRegata
        public ActionResult Regata(int id)
        {
            //odaberi utrku
            var utrkaServisi = new Utrka();
            var utrke = utrkaServisi.DohvatiUtrkeIzRegate(id);
            return View(utrke);
        }

        //idUtrka
        public ActionResult Spremi(int id)
        {
            var repozitorijPosade = new PosadaRepozitorij();
            var posade = repozitorijPosade.DohvatiPosadeIzUtrke(id);
            return View(posade);
        }

        [HttpPost]
        public ActionResult Spremi(int id,RezultatDTO ulaz)
        {
            var minute = Int32.Parse(Request.Params["Minute"]);
            var sekunde = Int32.Parse(Request.Params["Sekunde"]);
            var stotinke = Int32.Parse(Request.Params["Stotinke"]);
            var idRezultat = Int32.Parse(Request.Params["IdRezultat"]);
            var rezultat = new RezultatDTO()
            {
                IdRezultat = idRezultat,
                Vrijeme = new TimeSpan(0, 0, minute, sekunde, stotinke * 10)
            };

            var repozitorijRezultati = new RezultatRepozitorij();
            var uspjeh = repozitorijRezultati.SpremiRezultat(rezultat);

            var repozitorijPosade = new PosadaRepozitorij();
            var posade = repozitorijPosade.DohvatiPosadeIzUtrke(id);
            return View(posade);
        }

    }
}