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
    public class UtrkeController : Controller
    {
        // GET: Utrke
        public ActionResult Index()
        {
            var regataRepozitorij = new RegataRepozitorij();
            var regate = regataRepozitorij.DohvatiRegate();
            return View(regate);
        }

        public ActionResult Regata(int id)
        {
            var kategorijeRepozitorij = new KategorijaRepozitorij();
            var regataRepozitorij = new RegataRepozitorij();
            var kategorije = kategorijeRepozitorij.DohvatiKategorijePremaRegati(id);
            var regata = regataRepozitorij.DohvatiRegatu(id);
            var model = new UtrkaViewModel()
            {
                Regata = regata,
                Kategorije = kategorije
            };
            return View(model);
        }

        [HttpPost]
        public ActionResult Regata(int id, UtrkaDTO utrka)
        {
            var kategorijeRepozitorij = new KategorijaRepozitorij();
            var regataRepozitorij = new RegataRepozitorij();
            var utrkaRepozitorij = new UtrkaRepozitorij();

            var rezultat = utrkaRepozitorij.SpremiUtrku(utrka);
            var kategorije = kategorijeRepozitorij.DohvatiKategorijePremaRegati(id);
            var regata = regataRepozitorij.DohvatiRegatu(id);
            var model = new UtrkaViewModel()
            {
                Regata = regata,
                Kategorije = kategorije
            };
            return View(model);
        }

        public ActionResult Posada()
        {
            //odaberi regatu
            var regataRepozitorij = new RegataRepozitorij();
            var regate = regataRepozitorij.DohvatiRegate();
            return View(regate);
        }

        //idRegata
        public ActionResult PosadaKategorija(int id)
        {
            //odaberi kategoriju
            var kategorijeRepozitorij = new KategorijaRepozitorij();
            var kategorije = kategorijeRepozitorij.DohvatiKategorijePremaRegati(id);
            return View(kategorije);
        }

        //idKategorija
        public ActionResult PosadaUtrka(int id)
        {
            //dodaj posadu u utrku
            var utrkaServisi = new Utrka();
            var utrke = utrkaServisi.DohvatiUtrkeIzKategorije(id);

            var posadaRepozitorij = new PosadaRepozitorij();
            var posade = posadaRepozitorij.DohvatiPosadeIzKategorije(id);
            var model = new PosadaUUtrkuViewModel()
            {
                Posade = posade,
                Utrke = utrke
            };
            return View(model);
        }
        [HttpPost]
        public ActionResult PosadaUtrka(int id, PosadaUUtrciDTO posada)
        {
            //pospremi posadu
            var utrkaRepozitorij = new UtrkaRepozitorij();
            utrkaRepozitorij.DodajPosaduUUtrku(posada);

            var posadaRepozitorij = new PosadaRepozitorij();
            var utrkaServisi = new Utrka();
            var utrke = utrkaServisi.DohvatiUtrkeIzKategorije(id);


            var posade = posadaRepozitorij.DohvatiPosadeIzKategorije(id);
            var model = new PosadaUUtrkuViewModel()
            {
                Posade = posade,
                Utrke = utrke
            };
            return View(model);
        }


    }
}