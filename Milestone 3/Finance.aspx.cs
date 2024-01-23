using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncM3
{
    public partial class Finance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            if (string.IsNullOrEmpty(amountRT.Text) || !int.TryParse(amountRT.Text, out _))
            {
                succcessRT.Text = "Please enter an amount";
                return;
            }
           
            if (string.IsNullOrEmpty(dateRT.Text))
            {
                succcessRT.Text = "Please enter the date";
                return;
            }

            if (!DateTime.TryParseExact(dateRT.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
            {
                succcessRT.Text = "Invalid date format. Please enter the date in MM/dd/yyyy format.";
                return;
            }
            int amount = Int32.Parse(amountRT.Text);
            SqlCommand loginProc = new SqlCommand("ReceiveMoney", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            string userIDString = Session["user"].ToString();
            int id = int.Parse(userIDString);
            DateTime dateRec = DateTime.ParseExact(dateRT.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);

            loginProc.Parameters.Add(new SqlParameter("@receiver_id", id));
            loginProc.Parameters.Add(new SqlParameter("@type", "ingoing"));
            loginProc.Parameters.Add(new SqlParameter("@amount", amount));
            loginProc.Parameters.Add(new SqlParameter("@status", "pending"));
            loginProc.Parameters.Add(new SqlParameter("@date", dateRec));

            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;


            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                succcessRT.Text = "Transaction Received!";
            }
            else
                succcessRT.Text = "Please enter a valid user id";



        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            if (string.IsNullOrEmpty(recID.Text) || !int.TryParse(recID.Text, out _))
            {
                successMP.Text = "Please enter receiver ID";
                return;
            }
            if (string.IsNullOrEmpty(amountMP.Text)|| !int.TryParse(amountMP.Text, out _))
            {
                successMP.Text = "Please enter an amount";
                return;
            }
          

            if (string.IsNullOrEmpty(dateMP.Text))
            {
                successMP.Text = "Please enter the date";
                return;
            }

            if (!DateTime.TryParseExact(dateMP.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
            {
                successMP.Text = "Invalid date format. Please enter the date in MM/dd/yyyy format.";
                return;
            }
            int receiver = Int16.Parse(recID.Text);

            int amount = Int32.Parse(amountMP.Text);
            DateTime dateRec = DateTime.ParseExact(dateMP.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);

            SqlCommand loginProc = new SqlCommand("PlanPayment", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            string userIDString = Session["user"].ToString();
            int id = int.Parse(userIDString);

            loginProc.Parameters.Add(new SqlParameter("@sender_id", id));
            loginProc.Parameters.Add(new SqlParameter("@reciever_id", receiver));
            loginProc.Parameters.Add(new SqlParameter("@amount", amount));
            loginProc.Parameters.Add(new SqlParameter("@status", "pending"));
            loginProc.Parameters.Add(new SqlParameter("@deadline", dateRec));

            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;


            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                successMP.Text = "Payment made!";
            }
            else
                successMP.Text = "Please enter a valid receiver id!";


        }
    }
}