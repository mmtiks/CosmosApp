using Microsoft.CodeAnalysis.Elfie.Model.Tree;

namespace Cosmos.ViewModels
{
    public class FlightViewModel
    {
        public string id { get; set; }

        public string from { get; set; }

        public string to { get; set; }

        public long? distance { get; set; }

        public double? price { get; set; }

        public DateTime flightStart { get; set; }

        public DateTime flightEnd { get; set; }

        public TimeSpan travelTime { get; set; }

        public string companyName { get; set; }

        public double? cheaperThanUsual { get; set; }
    }
}
