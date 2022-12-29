using Cosmos.Data;
using Cosmos.Models;
using Cosmos.ViewModels;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Text;

namespace Cosmos.Controllers
{
    public class HomeController : Controller
    {
        private readonly CosmosDataContext context;

        Dictionary<string, string[]> paths = new Dictionary<string, string[]>();
        List<List<string>> depthFirst = new List<List<string>> { };
        Dictionary<List<string>, List<List<FlightViewModel>>> foundFlights = new Dictionary<List<string>, List<List<FlightViewModel>>>();
        int foundFlightsCount = 0;

        public HomeController(CosmosDataContext context)
        {
            this.context = context;
        }

        public async Task<IActionResult> Index()
        {
            return View();
        }

        public IActionResult Search(string? to)
        {
            ViewData["to"] = to;
            return View();
        }

        public IActionResult SearchResults(string from, string to, string daterange, string? company, string? sort)
        {
            string[] start = daterange.Split(" - ")[0].Split("/");
            string[] end = daterange.Split(" - ")[1].Split("/");

            DateTime startTime = new DateTime(int.Parse(start[2]), int.Parse(start[1]), int.Parse(start[0]));
            DateTime endTime = new DateTime(int.Parse(end[2]), int.Parse(end[1]), int.Parse(end[0]));

            List<FlightViewModel> flights = SearchFlights(from, to, startTime, endTime, company);


            ViewData["from"] = from;
            ViewData["to"] = to;
            ViewData["company"] = company;
            ViewData["sort"] = sort;
            ViewData["startDate"] = daterange.Split(" - ")[0];
            ViewData["endDate"] = daterange.Split(" - ")[1];

            if (sort != null)
            {
                switch (sort)
                {
                    case "priceasc": flights = flights.OrderBy(f => f.price).ToList(); break;
                    case "pricedesc": flights = flights.OrderByDescending(f => f.price).ToList(); break;
                    case "distanceasc": flights = flights.OrderBy(f => f.distance).ToList(); break;
                    case "distancedesc": flights = flights.OrderByDescending(f => f.distance).ToList(); break;
                    case "departureasc": flights = flights.OrderBy(f => f.flightStart).ToList(); break;
                    case "departuredesc": flights = flights.OrderByDescending(f => f.flightStart).ToList(); break;
                    case "arrivalasc": flights = flights.OrderBy(f => f.flightEnd).ToList(); break;
                    case "arrivaldesc": flights = flights.OrderByDescending(f => f.flightEnd).ToList(); break;
                }
            }
            DirectAndInderectModel model = new DirectAndInderectModel();
            model.flights = flights;
            if (model.flights.Count == 0 && from!= null && to != null)
            {
                foundFlights = new Dictionary<List<string>, List<List<FlightViewModel>>>();
                initPaths();
                foundFlightsCount = 0;
                depthFirst = new List<List<string>>();
                depthFind(from, to, new List<string>() { from });
                reRoutedFlights(from, to, startTime, endTime, company);
                Console.WriteLine(depthFirst.Count);
                model.indirectflights = foundFlights;
            }
           
            return View(model);
        }

        public IActionResult ReserveFlight(string id)
        {
            FlightViewModel fl = findFlightById(id);
            return View(fl);
        }

        public IActionResult Reservations(string? id, string? providerId, string? firstName, string? lastName, string? passcode, string? delete)
        {
            if (id != null || providerId != null)
            {
                if (delete == "1")
                {
                    Reservation res = context.Reservation.Find(id);
                    firstName = res.firstName;
                    lastName = res.lastName;
                    context.Reservation.Remove(res);
                    Console.WriteLine("done");
                }
                else
                {
                    AddReservation(providerId, firstName, lastName, GetStringSha256Hash(passcode));
                }
                context.SaveChanges();

            }
            List<ReservationViewModel> list = new List<ReservationViewModel>();

            var dbQuery = from reservation in context.Reservation
                          join provider in context.Provider on reservation.providerId equals provider.id
                          join route in context.Route on provider.routeId equals route.id
                          join routeinfo in context.RouteInfo on route.id equals routeinfo.routeId
                          join fromPlace in context.Place on routeinfo.fromId equals fromPlace.id
                          join toPlace in context.Place on routeinfo.toId equals toPlace.id
                          join comp in context.Company on provider.companyId equals comp.id
                          where reservation.firstName == firstName && reservation.lastName == lastName && reservation.passcode == GetStringSha256Hash(passcode)
                          select new
                          {
                              id = reservation.id,
                              providerId = provider.id,
                              fromName = fromPlace.name,
                              toName = toPlace.name,
                              passCode = reservation.passcode,
                              firstName = reservation.firstName,
                              lastName = reservation.lastName,
                              distance = routeinfo.distance,
                              price = provider.price,
                              companyName = comp.name,
                              flightStart = provider.flightStart,
                              flightEnd = provider.flightEnd,
                          };

            var result = dbQuery.ToArray();


            foreach (var reservation in result)
            {
                ReservationViewModel rm = new ReservationViewModel()
                {
                    id = reservation.id,
                    from = reservation.fromName,
                    to = reservation.toName,
                    firstName = reservation.firstName,
                    lastName = reservation.lastName,
                    distance = reservation.distance,
                    price = reservation.price,
                    companyName = reservation.companyName,
                    flightStart = reservation.flightStart,
                    flightEnd = reservation.flightEnd,
                    travelTime = reservation.flightEnd - reservation.flightStart
                };
                list.Add(rm);
            }

            ViewData["passcode"] = passcode;
            return View(list);
        }

        public IActionResult Deals()
        {
            return View(bestDeals());
        }

        public IActionResult Destinations()
        {
            return View();
        }




        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public static string GetUniqueKey(int size)
        {
            char[] chars =
                "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".ToCharArray();
            byte[] data = new byte[size];
            using (RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider())
            {
                crypto.GetBytes(data);
            }
            StringBuilder result = new StringBuilder(size);
            foreach (byte b in data)
            {
                result.Append(chars[b % (chars.Length)]);
            }
            return result.ToString();
        }

        internal static string GetStringSha256Hash(string text)
        {
            if (String.IsNullOrEmpty(text))
                return String.Empty;

            using (var sha = new System.Security.Cryptography.SHA256Managed())
            {
                byte[] textData = System.Text.Encoding.UTF8.GetBytes(text);
                byte[] hash = sha.ComputeHash(textData);
                return BitConverter.ToString(hash).Replace("-", String.Empty);
            }
        }




        public void AddReservation(string providerId, string firstName, string lastName, string? passcode)
        {
            string idkey = GetUniqueKey(28);
            while (true)
            {
                Reservation reservation = context.Reservation.Find(idkey);
                if (reservation == null) break;
                idkey = GetUniqueKey(28);
            }


            context.Reservation.Add(new Reservation()
            {
                id = idkey,
                providerId = providerId,
                firstName = firstName,
                lastName = lastName,
                dateAdded = DateTime.UtcNow,
                passcode = passcode

            });
            context.SaveChanges();
        }



        public List<FlightViewModel> SearchFlights(string? from, string? to, DateTime? start, DateTime? end, string? company)
        {
            var dbQuery = from pricelist in context.Pricelist
                          join route in context.Route on pricelist.id equals route.pricelistId
                          join routeinfo in context.RouteInfo on route.id equals routeinfo.routeId
                          join provider in context.Provider on route.id equals provider.routeId
                          join fromPlace in context.Place on routeinfo.fromId equals fromPlace.id
                          join toPlace in context.Place on routeinfo.toId equals toPlace.id
                          join comp in context.Company on provider.companyId equals comp.id
                          where pricelist.validUntil > DateTime.UtcNow && provider.flightStart.Date >= start && provider.flightStart.Date <= end
                          select new
                          {
                              id = provider.id,
                              fromName = fromPlace.name,
                              toName = toPlace.name,
                              companyName = comp.name,
                              distance = routeinfo.distance,
                              price = provider.price,
                              flightStart = provider.flightStart,
                              flightEnd = provider.flightEnd,
                          };

            if (company != null) dbQuery = dbQuery.Where(c => c.companyName == company);
            if (from != null) dbQuery = dbQuery.Where(c => c.fromName == from);
            if (to != null) dbQuery = dbQuery.Where(c => c.toName == to);
            var result = dbQuery.ToArray();

            List<FlightViewModel> list = new List<FlightViewModel>();

            foreach (var fl in result)
            {
                FlightViewModel flight = new FlightViewModel()
                {
                    id = fl.id,
                    from = fl.fromName,
                    to = fl.toName,
                    distance = fl.distance,
                    price = fl.price,
                    flightStart = fl.flightStart,
                    flightEnd = fl.flightEnd,
                    travelTime = fl.flightEnd - fl.flightStart,
                    companyName = fl.companyName,
                };
                list.Add(flight);
            }
            return list;
        }

        public FlightViewModel findFlightById(string id)
        {
            var dbQuery = from provider in context.Provider
                          join route in context.Route on provider.routeId equals route.id
                          join routeinfo in context.RouteInfo on route.id equals routeinfo.routeId
                          join fromPlace in context.Place on routeinfo.fromId equals fromPlace.id
                          join toPlace in context.Place on routeinfo.toId equals toPlace.id
                          join comp in context.Company on provider.companyId equals comp.id
                          where provider.id == id
                          select new
                          {
                              id = provider.id,
                              fromName = fromPlace.name,
                              toName = toPlace.name,
                              companyName = comp.name,
                              distance = routeinfo.distance,
                              price = provider.price,
                              flightStart = provider.flightStart,
                              flightEnd = provider.flightEnd,
                          };

            var fl = dbQuery.First();

            FlightViewModel flight = new FlightViewModel()
            {
                id = fl.id,
                from = fl.fromName,
                to = fl.toName,
                distance = fl.distance,
                price = fl.price,
                flightStart = fl.flightStart,
                flightEnd = fl.flightEnd,
                travelTime = fl.flightEnd - fl.flightStart,
                companyName = fl.companyName
            };
            return flight;
        }


        public void reRoutedFlights(string from, string to, DateTime start, DateTime end, string? company)
        {

            //buffer = SearchFlights(from, null, start, end, company);
            //foreach (var flight in buffer)
            //{
            //    List<FlightViewModel> buffer2 = SearchFlights(flight.to, to, flight.flightEnd, flight.flightEnd.AddDays(1), company);
            //    foreach (var flight2 in buffer2)
            //    {
            //        if (result.Count() > 1000) break;
            //        result.Add((flight, flight2));
            //    }

            //}
            foreach (var path in depthFirst)
            {
                recursiveFlights(start, end, company, path, 0, new List<FlightViewModel>());
                foundFlightsCount = 0;
            }
        }

        public void recursiveFlights(DateTime start, DateTime end, string? company, List<string> path, int count, List<FlightViewModel> temp)
        {
            if (foundFlightsCount > 50) return;
            if (count == path.Count - 1)
            {
                foundFlightsCount++;
                if (!foundFlights.ContainsKey(path))
                {
                    foundFlights[path] = new List<List<FlightViewModel>>();
                }
                foundFlights[path].Add(new List<FlightViewModel> (temp));
                return;
            }

            var flights = SearchFlights(path[count], path[count + 1], start, end, company);
            foreach (var flight in flights)
            {
                temp.Add(flight);
                recursiveFlights(flight.flightEnd, flight.flightEnd.AddDays(1), company, path, count + 1, temp);
                temp.Remove(flight);
            }
        }


        public List<FlightViewModel> bestDeals()
        {
            var dbQuery = from pricelist in context.Pricelist
                          join route in context.Route on pricelist.id equals route.pricelistId
                          join routeinfo in context.RouteInfo on route.id equals routeinfo.routeId
                          join provider in context.Provider on route.id equals provider.routeId
                          join fromPlace in context.Place on routeinfo.fromId equals fromPlace.id
                          join toPlace in context.Place on routeinfo.toId equals toPlace.id
                          join comp in context.Company on provider.companyId equals comp.id
                          select new
                          {
                              id = provider.id,
                              fromName = fromPlace.name,
                              toName = toPlace.name,
                              companyName = comp.name,
                              distance = routeinfo.distance,
                              price = provider.price,
                              flightStart = provider.flightStart,
                              flightEnd = provider.flightEnd,
                          };

            var buffer = dbQuery.ToList();
            if (buffer.Count == 0) new List<FlightViewModel>();
            buffer = buffer.OrderBy(fl => fl.fromName).ToList();
            buffer = buffer.OrderBy(fl => fl.toName).ToList();

            List<string> byRouteInfo = new List<string>();
            List<double?> averages = new List<double?>();
            double? prices = 0;
            int count = 0;
            byRouteInfo.Add(buffer[0].fromName + "|" + buffer[0].toName);

            foreach (var flight in buffer)
            {
                if(!byRouteInfo.Contains(flight.fromName + "|" + flight.toName))
                {
                    averages.Add( prices / count);
                    prices = 0;
                    count = 0;
                    byRouteInfo.Add(flight.fromName + "|" + flight.toName);
                }
                prices = prices + flight.price;
                count++;
            }
            averages.Add(prices / count);


            List<FlightViewModel> flights = SearchFlights(null, null, DateTime.UtcNow, DateTime.UtcNow.AddYears(10), null);
            Console.WriteLine(byRouteInfo.Count);
            Console.WriteLine(averages.Count);

            foreach(var flight in flights)
            {
                flight.cheaperThanUsual = (1 - (flight.price / averages[byRouteInfo.IndexOf(flight.from + "|" + flight.to)]))*100 ;
            }

            flights = flights.OrderByDescending(f => f.cheaperThanUsual).Take(20).ToList();
            return flights;
        }


        public void initPaths()
        {
            if (paths.Count() != 0) return;
            paths["Mercury"] = new string[] { "Venus" };
            paths["Venus"] = new string[] { "Earth" };
            paths["Earth"] = new string[] { "Jupiter", "Uranus" };
            paths["Mars"] = new string[] { "Venus" };
            paths["Jupiter"] = new string[] { "Venus" };
            paths["Saturn"] = new string[] { "Earth", "Neptune" };
            paths["Uranus"] = new string[] { "Saturn", "Neptune" };
            paths["Neptune"] = new string[] { "Uranus", "Mercury" };
            return;
        }

        public void depthFind(string from, string to, List<string> temp)
        {

            if (temp[temp.Count-1] == to)
            {
                depthFirst.Add(new List<string>(temp));
                return;
            }

            foreach (var destination in paths[temp[temp.Count - 1]])
            {
                Console.WriteLine(destination);
                if (!temp.Contains(destination))
                {
                    Console.WriteLine(destination);
                    temp.Add(destination);
                    depthFind(from, to, temp);
                    temp.RemoveAt(temp.Count - 1);
                }
            }

        }
    }
}