using PrikupljanjePodataka.DTO;
using PrikupljanjePodataka.Repozitoriji;
using System;
using System.Web.Mvc;

namespace PrikupljanjePodataka.Controllers
{
    public class VeslaciController : Controller
    {
        // GET: Veslaci
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(VeslacDTO veslac)
        {
            var veslacRepozitorij = new VeslacRepozitorij();
            var rezultat = veslacRepozitorij.SpremiVeslaca(veslac);

            return View();
        }

        public ActionResult Masa()
        {
            var veslacRepozitorij = new VeslacRepozitorij();
            var veslaci = veslacRepozitorij.DohvatiVeslace();
            return View(veslaci);
        }

        [HttpPost]
        public ActionResult Masa(MasaDTO masa)
        {
            var tezina = Request.Params["Masa"];
            var idVeslac = Request.Params["IdVeslac"];
            var VrijemeMjerenje = Request.Params["VrijemeMjerenje"];
            masa = new MasaDTO()
            {
                IdVeslac = int.Parse(idVeslac),
                Masa = float.Parse(tezina),
                VrijemeMjerenje = DateTime.Parse(VrijemeMjerenje)
            };

            var veslacRepozitorij = new VeslacRepozitorij();
            veslacRepozitorij.SpremiMasuVeslaca(masa);
            var veslaci = veslacRepozitorij.DohvatiVeslace();
            return View(veslaci);
        }

        public ActionResult Visina()
        {
            var veslacRepozitorij = new VeslacRepozitorij();
            var veslaci = veslacRepozitorij.DohvatiVeslace();
            return View(veslaci);
        }

        [HttpPost]
        public ActionResult Visina(VisinaDTO visina)
        {
            var visinaInput = Request.Params["Masa"];
            var idVeslac = Request.Params["IdVeslac"];
            var VrijemeMjerenje = Request.Params["VrijemeMjerenje"];
            visina = new VisinaDTO()
            {
                IdVeslac = int.Parse(idVeslac),
                Visina = float.Parse(visinaInput),
                VrijemeMjerenje = DateTime.Parse(VrijemeMjerenje)
            };

            var veslacRepozitorij = new VeslacRepozitorij();
            veslacRepozitorij.SpremiVisinuVeslaca(visina);
            var veslaci = veslacRepozitorij.DohvatiVeslace();
            return View(veslaci);
        }
    }
}