using PrikupljanjePodataka.DTO;
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
    }
}