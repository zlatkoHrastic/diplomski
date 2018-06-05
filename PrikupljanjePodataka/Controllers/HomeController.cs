using PrikupljanjePodataka.DTO;
using PrikupljanjePodataka.Repozitoriji;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PrikupljanjePodataka.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.Title = "Home Page";

            return View();
        }

        [HttpPost]
        public ActionResult Index(RegataDTO regata)
        {
            ViewBag.Title = "Home Page";
            var repozitorij = new RegataRepozitorij();
            var rez = repozitorij.SpremiRegatu(regata);
            return View();
        }
    }
}
