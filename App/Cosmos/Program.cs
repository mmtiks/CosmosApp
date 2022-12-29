using Microsoft.EntityFrameworkCore;
using Cosmos.Data;
using Cosmos;
using System.Drawing.Text;
using System.Timers;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

builder.Services.AddDbContextPool<CosmosDataContext>(
    o => o.UseNpgsql(builder.Configuration.GetConnectionString("postgres")))   ;

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

Thread printer = new Thread(new ThreadStart(InvokeMethod));
printer.Start();

void InvokeMethod()
{
    while (true)
    {
        app.Seed();
        Thread.Sleep(1000 * 60 * 15);
    }
}

app.Seed();
app.Run();
