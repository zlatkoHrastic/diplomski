using PrikupljanjePodataka.DTO;
using PrikupljanjePodataka.Repozitoriji;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.PoslovniSloj
{
    public class Posada
    {
        public bool StvoriPosadu(PosadaDTO posada)
        {
            var repozitorijPosada = new PosadaRepozitorij();
            var idPosade = repozitorijPosada.SpremiPosadu(posada);
            var uspjeh = true;
            for (var i = 0; i < posada.ListaIdVeslac.Count; i++)
            {
                uspjeh &= repozitorijPosada.DodajVeslacaUPosadu(idPosade, posada.ListaIdVeslac[i], i + 1);
            }
            return uspjeh;
        }

    }
}