using Microsoft.AspNetCore.Mvc;

namespace Cosmos.ViewModels
{
    public class DirectAndInderectModel 
    {
        public List<FlightViewModel> flights;

        public Dictionary<List<string>, List<List<FlightViewModel>>> indirectflights;
    }
}
