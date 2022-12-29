using Cosmos.Data;
using Cosmos.ViewModels;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Newtonsoft.Json;
using Route = Cosmos.Data.Route;

namespace Cosmos
{
    public static class FlightServices
    {

        public static async Task Seed(this IHost host)
        {
            Console.WriteLine(host);
            AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);
            AppContext.SetSwitch("Npgsql.DisableDateTimeInfinityConversions", true);
            using var scope = host.Services.CreateScope();
            using var context = scope.ServiceProvider.GetRequiredService<CosmosDataContext>();
            context.Database.EnsureCreated();
            string response = await new HttpClient().GetStringAsync("https://cosmos-odyssey.azurewebsites.net/api/v1.0/TravelPrices");
            GetFlights(context, response);
        }



        private static void GetFlights(CosmosDataContext context, string response)
        {
            ScheduleGet? schedule = JsonConvert.DeserializeObject<ScheduleGet>(response);

            // Website is up
            if (schedule == null) return;

            PriceList? priceList = context.Pricelist.Find(schedule.id);

            // pricelist not already in db
            if (priceList != null) return;

            int count = context.Pricelist.Count();

            if (count == 15)
            {
                RemoveLastPriceList(context);
            }


            context.Pricelist.Add(new PriceList
            {
                id = schedule.id,
                validUntil = DateTime.Parse(schedule.validUntil),
                dateAdded = DateTime.UtcNow
            });
            context.SaveChanges();
            foreach (RouteGet route in schedule.legs)
            {
                RouteInfoGet routeinfoget = route.routeinfo;
                Place from = routeinfoget.from;
                Place to = routeinfoget.to;


                context.Route.Add(new Data.Route
                {
                    id = route.id,
                    pricelistId = schedule.id
                });

                if (context.Place.Find(from.id) == null)
                {

                    context.Place.Add(new Place
                    {
                        id = from.id,
                        name = from.name,
                        priceListId = schedule.id
                    });
                }

                if (context.Place.Find(to.id) == null)
                {
                    context.Place.Add(new Place
                    {
                        id = to.id,
                        name = to.name,
                        priceListId = schedule.id
                    });
                }


                context.RouteInfo.Add(new RouteInfo
                {
                    id = routeinfoget.id,
                    distance = routeinfoget.distance,
                    routeId = route.id,
                    fromId = from.id,
                    toId = to.id
                });
                context.SaveChanges();
                foreach (ProviderGet provider in route.providers)
                {
                    CompanyGet companyget = provider.company;


                    Company? company = context.Company.Find(companyget.id);

                    // company id is also unique
                    if (company == null)
                    {
                        context.Company.Add(new Company
                        {
                            id = companyget.id,
                            name = companyget.name,
                            priceListId = schedule.id
                        });
                    }
                    context.Provider.Add(new Provider
                    {
                        id = provider.id,
                        price = provider.price,
                        flightStart = DateTime.Parse(provider.flightStart),
                        flightEnd = DateTime.Parse(provider.flightEnd),
                        companyId = companyget.id,
                        routeId = route.id
                    });
                }
            }
            context.SaveChanges();
        }
        private static void RemoveLastPriceList(CosmosDataContext context)
        {
            IQueryable<PriceList> query =
                from priceList in context.Pricelist
                orderby priceList.validUntil ascending
                select priceList;

            PriceList last = query.First();

            context.Pricelist.Remove(last);

            context.SaveChanges();
        }

    }





    class ScheduleGet
    {
        public string? id { get; set; }
        public string? validUntil { get; set; }
        public RouteGet[]? legs { get; set; }
    }

    class RouteGet
    {
        public string? id { get; set; }
        public RouteInfoGet? routeinfo { get; set; }
        public ProviderGet[]? providers { get; set; }
    }

    class RouteInfoGet
    {
        public string? id { get; set; }
        public Place? from { get; set; }
        public Place? to { get; set; }
        public long? distance { get; set; }
    }

    class ProviderGet
    {
        public string? id { get; set; }
        public CompanyGet? company { get; set; }
        public double? price { get; set; }
        public string? flightStart { get; set; }
        public string? flightEnd { get; set; }


    }

    class CompanyGet
    {
        public string? id { get; set; }
        public string? name { get; set; }
    }
}