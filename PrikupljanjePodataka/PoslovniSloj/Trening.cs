using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PrikupljanjePodataka.DTO;
using PrikupljanjePodataka.Repozitoriji;

namespace PrikupljanjePodataka.PoslovniSloj
{
    public class Trening
    {
        public bool StvoriTrening(TreningDTO trening)
        {
            var repozitorijTreninga = new TreningRepozitorij();
            var idTrening = repozitorijTreninga.SpremiTrening(trening.IdVeslac, trening.VrijemeTreninga, trening.IdTipTreninga);
            var uspjeh = true;

            uspjeh &= repozitorijTreninga.DodajVrijemeUTrening(idTrening, trening.Dionica1, 1);
            uspjeh &= repozitorijTreninga.DodajVrijemeUTrening(idTrening, trening.Dionica2, 2);
            if (trening.IdTipTreninga > 2)
            {
                uspjeh &= repozitorijTreninga.DodajVrijemeUTrening(idTrening, trening.Dionica3, 3);
            }
            return uspjeh;
        }

    }
}