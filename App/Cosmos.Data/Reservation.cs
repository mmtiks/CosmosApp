using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cosmos.Data
{
    public class Reservation
    {
        [System.ComponentModel.DataAnnotations.Key]
        [Column("id")]
        public string id { get; set; }

        [Column("providerId")]
        public string providerId { get; set; }

        [Column("firstName")]
        public string firstName { get; set; }

        [Column("lastName")]
        public string lastName { get; set; }

        [Column("dateAdded")]
        public DateTime dateAdded { get; set; }

        [Column("passcode")]
        public string passcode { get; set; }
    }
}
