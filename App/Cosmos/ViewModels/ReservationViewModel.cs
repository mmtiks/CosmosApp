namespace Cosmos.ViewModels
{
    public class ReservationViewModel
    {
        public string? id { get; set; }

        public string? providerId { get; set; }

        public string? from { get; set; }

        public string? to { get; set; }

        public string? firstName { get; set; }

        public string? lastName { get; set; }

        public long? distance { get; set; }

        public double? price { get; set; }

        public string? companyName { get; set; }

        public DateTime? flightStart { get; set; }

        public DateTime? flightEnd { get; set; }

        public TimeSpan travelTime { get; set; }
    }
}
