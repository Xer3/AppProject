//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Projekt_programowanie_obiektowe
{
    using System;
    using System.Collections.Generic;
    
    public partial class Pacjenci
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Pacjenci()
        {
            this.Wizyty = new HashSet<Wizyty>();
        }
    
        public string pesel_pacjenta { get; set; }
        public string imie_pacjenta { get; set; }
        public string nazwisko_pacjenta { get; set; }
        public string ulica { get; set; }
        public string kod_pocztowy { get; set; }
        public string miejscowosc { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Wizyty> Wizyty { get; set; }
    }
}