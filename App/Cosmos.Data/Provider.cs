using System.ComponentModel.DataAnnotations.Schema;

namespace Cosmos.Data

{
    public class Provider
    {
        [System.ComponentModel.DataAnnotations.Key]
        [Column("id")]
        public string id { get; set; }

        [Column("price")]
        public double? price { get; set; }

        [Column("flightStart")]
        public DateTime flightStart { get; set; }

        [Column("flightEnd")]
        public DateTime flightEnd { get; set; }

        [Column("routeId")]
        public string routeId { get; set; }

        [Column("companyId")]
        public string companyId { get; set; }
    }
}