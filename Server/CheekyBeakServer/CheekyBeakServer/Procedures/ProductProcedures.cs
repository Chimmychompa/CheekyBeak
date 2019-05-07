using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CheekyBeakServer.Models;
using MySql.Data.MySqlClient;

namespace CheekyBeakServer.Procedures
{
    public class ProductProcedures
    {
        public readonly AppDb Db;

        public ProductProcedures(AppDb db)
        {
            Db = db;
        }

        public async Task<List<Product>> GetAllProducts()
        {
            var cmd = Db.Connection.CreateCommand();

            return await ReadAllAsync(await cmd.ExecuteReaderAsync());
        }

        private async Task<List<Product>> ReadAllAsync(DbDataReader reader)
        {
            var products = new List<Product>();
            using (reader)
            {
                while (await reader.ReadAsync())
                {
                    var product = new Product(Db)
                    {
                        Id = await reader.GetFieldValueAsync<int>(0),
                        Title = await reader.GetFieldValueAsync<string>(1),
                        Content = await reader.GetFieldValueAsync<string>(2)
                    };
                    products.Add(product);
                }
            }
            return products;
        }
    }
}
