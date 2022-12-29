using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace Cosmos.Data
{
    public class CosmosDataContext : DbContext
    {
        public CosmosDataContext(DbContextOptions<CosmosDataContext> options) :
              base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.UseSerialColumns();
        }


        public DbSet<PriceList> Pricelist { get; set; }
       
        public DbSet<Company> Company { get; set; }

        public DbSet<Place> Place { get; set; }

        public DbSet<Route> Route { get; set; }

        public DbSet<RouteInfo> RouteInfo { get; set; }
        
        public DbSet<Provider> Provider { get; set; }
        
        public DbSet<Reservation> Reservation { get; set; }
        
    }
}
