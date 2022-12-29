using System.ComponentModel.DataAnnotations.Schema;

namespace Cosmos.Data
{
    public class Route
    {
        [System.ComponentModel.DataAnnotations.Key]
        [Column("id")]
        public string id { get; set; }

        [Column("pricelistId")]
        public string pricelistId { get; set; }
    }
}