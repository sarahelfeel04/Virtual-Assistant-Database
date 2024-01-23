using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection.Emit;

namespace HomeSyncM3
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginClick(object sender, EventArgs e)
        {
            
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
       
            SqlConnection conn = new SqlConnection(connStr);

            if (string.IsNullOrEmpty(emailID.Text))
            {
                errorLabel.Text = "Please enter the email";
                return;
            }
            if (string.IsNullOrEmpty(passID.Text))
            {
                errorLabel.Text = "Please enter the password";
                return;
            }
            string email = emailID.Text;
            string pass = passID.Text;

            SqlCommand loginProc2 = new SqlCommand("deleteProc", conn);
            loginProc2.CommandType = CommandType.StoredProcedure;

            loginProc2.Parameters.Add(new SqlParameter("@email", email));
            SqlParameter success2 = loginProc2.Parameters.Add("@success", SqlDbType.Int);
            success2.Direction = ParameterDirection.Output;
            conn.Open();
            loginProc2.ExecuteNonQuery();
            conn.Close();

            if (success2.Value.ToString() == "1") {
                errorLabel.Text = "Guest has been deleted";
                return;
            }




            SqlCommand loginProc = new SqlCommand("UserLogin", conn);
            loginProc.CommandType = CommandType.StoredProcedure;

            loginProc.Parameters.Add(new SqlParameter("@email", email));
            loginProc.Parameters.Add(new SqlParameter("@password", pass));
  

            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            SqlParameter userID = loginProc.Parameters.Add("@user_id", SqlDbType.Int);
            userID.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();



            if (success.Value.ToString() == "1")
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
                errorLabel.Text = "password or email incorrect";


        }

        protected void signupClick(object sender, EventArgs e)
        {
            Response.Redirect("signup.aspx");
        }

    }
}