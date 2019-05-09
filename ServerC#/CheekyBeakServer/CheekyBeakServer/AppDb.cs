using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace CheekyBeakServer
{
    public class AppDb : IDisposable
    {
        public MySqlConnection Connection;

        public AppDb()
        {
            Connection = new MySqlConnection(AppConfig.Config["ConnectionString:DefualtConnection"]);
        }

        public void Dispose()
        {
            Connection.Close();
        }
    }
}
