# CosmosApp
Needed:
  * Visual Studio
  * PostgreSQL(I use pgAdmin for setup)

1.Clone repository\
2.Configure connection string according to your server properties\
![image](https://user-images.githubusercontent.com/83118752/210013004-3fc15002-f26b-4ba0-916f-4e7991ebc952.png)\
![image](https://user-images.githubusercontent.com/83118752/210013107-aac0eba6-ded1-4dea-8ab7-6201cd9a6d43.png)\
3.Create database on connected server and name it according to connection string(default 'postgres')\
4.Restore lastly created database from file in repository\
5.In a Terminal navigate to Cosmos folder where Program.cs, ViewModels and others are located\
6.Command 'dotnet run'\
7.Website should be running on http://localhost:5094/.
