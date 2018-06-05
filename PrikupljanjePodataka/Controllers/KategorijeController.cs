using PrikupljanjePodataka.DTO;
using PrikupljanjePodataka.Repozitoriji;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PrikupljanjePodataka.Controllers
{
    public class KategorijeController : Controller
    {
        // GET: Utrke
        public ActionResult Index()
        {
            var kategorijeRepozitorij = new KategorijaRepozitorij();
            var regataRepozitorij= new RegataRepozitorij();
            var regate = regataRepozitorij.DohvatiRegate();
            var starosneKategorije = kategorijeRepozitorij.DohvatiStarosneKategorije();
            var camci = kategorijeRepozitorij.DohvatiCamce();

            var viewModel = new KateogrijaViewModel() {
                Regate=regate,
                Camci=camci,
                StarosneKategorije=starosneKategorije
            };
            return View(viewModel);
        }
        [HttpPost]
        public ActionResult Index(KategorijaDTO kategorija)
        {
            var kategorijeRepozitorij = new KategorijaRepozitorij();
            var uspjeh=kategorijeRepozitorij.SpremiKategoriju(kategorija);

            var regataRepozitorij = new RegataRepozitorij();
            var regate = regataRepozitorij.DohvatiRegate();
            var starosneKategorije = kategorijeRepozitorij.DohvatiStarosneKategorije();
            var camci = kategorijeRepozitorij.DohvatiCamce();

            var viewModel = new KateogrijaViewModel()
            {
                Regate = regate,
                Camci = camci,
                StarosneKategorije = starosneKategorije
            };
            return View(viewModel);
        }
    }
}