using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Cosmos.Data.Migrations
{
    /// <inheritdoc />
    public partial class CosmosDatabase : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Pricelist",
                columns: table => new
                {
                    id = table.Column<string>(type: "text", nullable: false),
                    validUntil = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    dateAdded = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_priceLists", x => x.id);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Pricelist");
        }
    }
}
