using PrikupljanjePodataka.DTO;
using PrikupljanjePodataka.Repozitoriji;
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
            var rezultat=veslacRepozitorij.SpremiVeslaca(veslac);

            return View();
        }
    }
}