using System.ComponentModel.DataAnnotations.Schema;

namespace Cosmos.Data

{
    public class Place
    {
        [System.ComponentModel.DataAnnotations.Key]
        [Column("id")]
        public string id { get; set; }

        [Column("name")]
        public string name { get; set; }

        [Column("priceListId")]
        public string priceListId { get; set; }
    }
}