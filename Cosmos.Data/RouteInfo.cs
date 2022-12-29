using System.ComponentModel.DataAnnotations.Schema;

namespace Cosmos.Data
{

    public class RouteInfo
    {
        [System.ComponentModel.DataAnnotations.Key]
        [Column("id")]
        public string id { get; set; }

        [Column("distance")]
        public long? distance { get; set; }

        [Column("routeId")]
        public string routeId { get; set; }


        [Column("fromId")]
        public string fromId { get; set; }


        [Column("toId")]
        public string toId { get; set; }

    }
}