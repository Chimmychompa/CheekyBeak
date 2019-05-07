using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CheekyBeakServer.Models
{
    public class Product
    {        
        public int ProductId { get; set; }
        public int ProductCategoryId { get; set; }
        public string ImageURL { get; set; }
        public double Price { get; set; }
        public double WholesalePrice { get; set; }        
        public string ProductDescription { get; set; }
        
        public AppDb Db { get; set; }

        public Product(AppDb db = null)
        {
            Db = db;
        }
    }
}
