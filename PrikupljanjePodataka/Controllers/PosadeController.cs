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
    public class PosadeController : Controller
    {
        // GET: Posade
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
            var veslacRepozitorij = new VeslacRepozitorij();

            var kategorije = kategorijeRepozitorij.DohvatiKategorijePremaRegati(id);
            var regata = regataRepozitorij.DohvatiRegatu(id);
            var veslaci = veslacRepozitorij.DohvatiVeslace();
            var model = new PosadaViewModel()
            {
                Regata = regata,
                Kategorije = kategorije,
                Veslaci = veslaci
            };
            return View(model);
        }

        [HttpPost]
        public ActionResult Regata(int id, PosadaDTO posada)
        {
            posada.ListaIdVeslac = new List<int>();
            for (var i = 0; i < 9; i++)
            {
                var imeParametra = $"Veslac{i}";
                var parametar = Request.Params[imeParametra];
                if (string.IsNullOrWhiteSpace(parametar))
                {
                    break;
                }

                if (Int32.TryParse(parametar, out var intParametar))
                {
                    posada.ListaIdVeslac.Add(intParametar);
                }
                else
                {
                    break;
                }
            }
            var posadaServis = new Posada();
            var rezultat = posadaServis.StvoriPosadu(posada);


            var kategorijeRepozitorij = new KategorijaRepozitorij();
            var regataRepozitorij = new RegataRepozitorij();
            var veslacRepozitorij = new VeslacRepozitorij();

            var kategorije = kategorijeRepozitorij.DohvatiKategorijePremaRegati(id);
            var regata = regataRepozitorij.DohvatiRegatu(id);
            var veslaci = veslacRepozitorij.DohvatiVeslace();
            var model = new PosadaViewModel()
            {
                Regata = regata,
                Kategorije = kategorije,
                Veslaci = veslaci
            };
            return View(model);
        }
    }
}