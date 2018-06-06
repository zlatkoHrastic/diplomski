using PrikupljanjePodataka.DTO;
using PrikupljanjePodataka.Repozitoriji;
using System.Web.Mvc;

namespace PrikupljanjePodataka.Controllers
{
    public class KluboviController : Controller
    {
        // GET: Klubovi
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(KlubDTO klub)
        {
            var klubRepozitorij = new KlubRepozitorij();
            var rezultat = klubRepozitorij.SpremiKlub(klub);
            return View();
        }


        public ActionResult Pripadnost()
        {
            var klubRepozitorij = new KlubRepozitorij();
            var veslacRepozitorij = new VeslacRepozitorij();

            var klubovi = klubRepozitorij.DohvatiKlubove();
            var veslaci = veslacRepozitorij.DohvatiVeslace();

            var model = new PripadnostKlubuViewModel()
            {
                Klubovi = klubovi,
                Veslaci = veslaci
            };
            return View(model);
        }

        [HttpPost]
        public ActionResult Pripadnost(PripadnostKlubuDTO pripadnost)
        {

            var klubRepozitorij = new KlubRepozitorij();
            var veslacRepozitorij = new VeslacRepozitorij();

            var rezultat = klubRepozitorij.SpremiPripadnostKlubu(pripadnost);

            var klubovi = klubRepozitorij.DohvatiKlubove();
            var veslaci = veslacRepozitorij.DohvatiVeslace();

            var model = new PripadnostKlubuViewModel()
            {
                Klubovi = klubovi,
                Veslaci = veslaci
            };


            return View(model);
        }

    }
}