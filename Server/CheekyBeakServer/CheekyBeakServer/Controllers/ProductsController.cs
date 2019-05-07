using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;

namespace CheekyBeakServer.Controllers
{
    [Route("api/[controller]/[action]")]
    public class ProductsController : Controller
    {
        // GET api/cards/all
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            using(var db = new AppDb())
            {
                await db.Connection.OpenAsync();
                var query = new BlogPostQuery(db);
                var result = await query.LatestPostsAsync();
                return new OkObjectResult(result);
            }                        
        }

        // POST api/<controller>
        [HttpPost]
        public void Post([FromBody]string value)
        {
        }

        // PUT api/<controller>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
