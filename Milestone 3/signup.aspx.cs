using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Reflection.Emit;

namespace HomeSyncM3
{
    public partial class signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void signupClick(object sender, EventArgs e)
        {
            
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            
            SqlConnection conn = new SqlConnection(connStr);

            
            if (string.IsNullOrEmpty(emailID.Text))
            {
                Label7.Text = "Please enter your email";
                return;
            }
            if (string.IsNullOrEmpty(passID.Text))
            {
                Label7.Text = "Please enter your password";
                return;
            }
            if (string.IsNullOrEmpty(firstID.Text))
            {
                Label7.Text = "Please enter first name";
                return;
            }
            if (string.IsNullOrEmpty(lastID.Text))
            {
                Label7.Text = "Please enter last name";
                return;
            }
            if (string.IsNullOrEmpty(birthID.Text))
            {
                Label7.Text = "Please enter your birthdate";
                return;
            }

            if (!DateTime.TryParseExact(birthID.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
            {
                Label7.Text = "Invalid date format. Please enter the date in MM/dd/yyyy format.";
                return;
            }
           

            string email = emailID.Text;
            string pass = passID.Text;
            string first = firstID.Text;
            string last = lastID.Text;
            DateTime birth = DateTime.ParseExact(birthID.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);

            SqlCommand loginProc = new SqlCommand("UserRegister", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@email", email));
            loginProc.Parameters.Add(new SqlParameter("@password", pass));
            loginProc.Parameters.Add(new SqlParameter("@first_name", first));
            loginProc.Parameters.Add(new SqlParameter("@last_name", last));
            loginProc.Parameters.Add(new SqlParameter("@birth_date", birth));
            loginProc.Parameters.Add(new SqlParameter("@usertype", "Admin"));


            SqlParameter userID = loginProc.Parameters.Add("@user_id", SqlDbType.Int);
            userID.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (userID.Value.ToString() != "-1")
            {
                int userIdValue = Convert.ToInt32(userID.Value);

                SqlCommand proc2 = new SqlCommand("getType", conn);
                proc2.CommandType = CommandType.StoredProcedure;

                proc2.Parameters.Add(new SqlParameter("@user_id", userIdValue));

                SqlParameter type = proc2.Parameters.Add("@type", SqlDbType.VarChar, 10);
                type.Direction = ParameterDirection.Output;

                conn.Open();
                proc2.ExecuteNonQuery();
                conn.Close();

                string typee = Convert.ToString(type.Value);

                Session["user"] = userIdValue;
                Session["type"] = typee;
                Response.Redirect("homePage.aspx");

            }
            else
                Label7.Text="User already exists";


        }

       

        protected void login_Click(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }
    }
}