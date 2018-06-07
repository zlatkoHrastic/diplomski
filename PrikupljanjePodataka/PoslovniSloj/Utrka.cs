using PrikupljanjePodataka.DTO;
using PrikupljanjePodataka.Repozitoriji;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrikupljanjePodataka.PoslovniSloj
{
    public class Utrka
    {
        public List<SelectDTO> DohvatiUtrkeIzKategorije(int idKategorija)
        {
            var utrkaRepozitorij = new UtrkaRepozitorij();
            var utrke = utrkaRepozitorij.DohvatiUtrkeIzKategorije(idKategorija);

            return utrke.Select(u => new SelectDTO() { Id = u.IdUtrka, Value = $"({u.RedniBroj}) {u.Kategorija} {u.RangUtrke}" }).ToList();
        }

        public List<SelectDTO> DohvatiUtrkeIzRegate(int idRegata)
        {
            var utrkaRepozitorij = new UtrkaRepozitorij();
            var utrke = utrkaRepozitorij.DohvatiUtrkeIzRegate(idRegata);

            return utrke.Select(u => new SelectDTO() { Id = u.IdUtrka, Value = $"({u.RedniBroj}) {u.Kategorija} {u.RangUtrke}" }).ToList();
        }
    }
}