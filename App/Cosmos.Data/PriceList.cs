using System.ComponentModel.DataAnnotations.Schema;

namespace Cosmos.Data
{
    public class PriceList
    {
        [System.ComponentModel.DataAnnotations.Key]
        [Column("id")]
        public string id { get; set; }

        [Column("validUntil")]
        public DateTime validUntil { get; set; }

        [Column("dateAdded")]
        public DateTime dateAdded { get; set; }
    }
}