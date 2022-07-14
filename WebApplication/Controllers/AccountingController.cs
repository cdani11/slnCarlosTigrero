using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;

namespace WebApplication.Controllers
{
    public class AccountingController : Controller
    {
        private SqlConnection conn;
        private SqlCommand cmd;
        private SqlDataReader rdr;

        // GET: Accounting
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult GetProducts()
        {
            string msg = string.Empty;
            IDictionary<int, string> dicProducts = new Dictionary<int, string>();

            try
            {
                conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbWebApp"].ConnectionString);

                conn.Open();

                cmd = new SqlCommand("dbo.SPConsultProduct", conn)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };

                rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    int id = (int)rdr["ID"];
                    string description = rdr["Description"].ToString();

                    dicProducts.Add(id, description);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return Json(new { data = dicProducts.ToList(), message = msg }, JsonRequestBehavior.AllowGet);
        }
    }
}