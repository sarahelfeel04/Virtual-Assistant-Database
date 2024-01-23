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
using System.Xml.Linq;

namespace HomeSyncM3
{
    public partial class ProfilePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string type = Session["type"].ToString();
            if (!Page.IsPostBack && type == "Guest")
            {
                this.Label1.Visible = false;
                this.Label20.Visible = false;
                this.Label22.Visible = false;
                this.Label23.Visible = false;
                this.Label25.Visible = false;
                this.Label26.Visible = false;
                this.Label27.Visible = false;
                this.Label28.Visible = false;
                this.guest.Visible = false;
                this.delete.Visible = false;
                this.ViewNumber.Visible = false;
                this.num.Visible = false;
                this.setNumber.Visible = false;
                this.Label29.Visible = false;
                this.Label36.Visible = false;
                this.Label37.Visible = false;
                this.Label30.Visible = false;
                this.Label32.Visible = false;
                this.Label33.Visible = false;
                this.Label34.Visible = false;
                this.Label35.Visible = false;
                this.Label31.Visible = false;
                this.email.Visible = false;
                this.pass.Visible = false;
                this.first.Visible = false;
                this.last.Visible = false;
                this.address.Visible = false;
                this.room.Visible = false;
                this.date.Visible = false;
                this.addGuest.Visible = false;

            }



            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            string userIDString = Session["user"].ToString();

            int id2 = int.Parse(userIDString);

            SqlCommand loginProc = new SqlCommand("UserDetails", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@user_id", id2));
            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(loginProc);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            
                // Bind the DataTable to the GridView
                GridView2.DataSource = dt;
                GridView2.DataBind();
                GridView2.Visible = true;
            
        }


        protected void delete_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (string.IsNullOrEmpty(guest.Text) || !int.TryParse(guest.Text, out _))
            {
                Label22.Text = "Please enter the guest ID";
                return;
            }
            int g = int.Parse(guest.Text);


            string userIDString = Session["user"].ToString();

            int id = int.Parse(userIDString);


            SqlCommand loginProc = new SqlCommand("GuestRemove", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@guest_id", g));
            loginProc.Parameters.Add(new SqlParameter("@admin_id", id));

            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;
            SqlParameter number = loginProc.Parameters.Add("@number_of_allowed_guests", SqlDbType.Int);
            number.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Label22.Text = "guest deleted successfully     Number of guests left: "+ number.Value.ToString();

            }
            else
            {
                Label22.Text = "guest does not exist";
            }
        }

        protected void ViewNumber_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);




            string userIDString = Session["user"].ToString();

            int id = int.Parse(userIDString);


            SqlCommand loginProc = new SqlCommand("GuestNumber", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            
            loginProc.Parameters.Add(new SqlParameter("@admin_id", id));

            SqlParameter number = loginProc.Parameters.Add("@number", SqlDbType.Int);
            number.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            Label25.Text = "Number of guests of the admin: " + number.Value.ToString();
        }

        protected void setNumber_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            if (string.IsNullOrEmpty(num.Text) || !int.TryParse(num.Text, out _))
            {
                Label28.Text = "Please enter valid number";
                return;
            }

            int g = int.Parse(num.Text);


            string userIDString = Session["user"].ToString();

            int id = int.Parse(userIDString);


            SqlCommand loginProc = new SqlCommand("GuestsAllowed", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@admin_id", id));
            loginProc.Parameters.Add(new SqlParameter("@number_of_guests", g));

           
            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

           
           Label28.Text = "number of guests changed to: " + g;

          
        }

        protected void addGuest_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);



            if (string.IsNullOrEmpty(email.Text))
            {
                Label31.Text = "Please enter your email";
                return;
            }
            if (string.IsNullOrEmpty(pass.Text))
            {
                Label31.Text = "Please enter your password";
                return;
            }
            if (string.IsNullOrEmpty(first.Text))
            {
                Label31.Text = "Please enter first name";
                return;
            }
            if (string.IsNullOrEmpty(last.Text))
            {
                Label31.Text = "Please enter last name";
                return;
            }
           
            if (string.IsNullOrEmpty(address.Text) )
            {
                Label31.Text = "Please enter your address";
                return;
            }
            if (string.IsNullOrEmpty(room.Text)|| !int.TryParse(room.Text, out _))
            {
                Label31.Text = "Please enter your room";
                return;
            }
            if (string.IsNullOrEmpty(date.Text))
            {
                Label31.Text = "Please enter your birthdate";
                return;
            }

            if (!DateTime.TryParseExact(date.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
            {
                Label31.Text = "Invalid date format. Please enter the date in MM/dd/yyyy format.";
                return;
            }
            string email1 = email.Text;
            string fname = first.Text;
            string lname = last.Text;
            string addres = address.Text;
            string p = pass.Text;
            string roomID = room.Text;
            DateTime birth = DateTime.ParseExact(date.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            string userIDString = Session["user"].ToString();
            int id = int.Parse(userIDString);


            SqlCommand loginProc = new SqlCommand("AddGuest", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@email", email1));
            loginProc.Parameters.Add(new SqlParameter("@first_name", fname));
            loginProc.Parameters.Add(new SqlParameter("@last_name", lname));
            loginProc.Parameters.Add(new SqlParameter("@address", addres));
            loginProc.Parameters.Add(new SqlParameter("@room_id", roomID));
            loginProc.Parameters.Add(new SqlParameter("@birth_date", birth));
            loginProc.Parameters.Add(new SqlParameter("@guest_of", id));
            loginProc.Parameters.Add(new SqlParameter("@password", p));

            SqlParameter number = loginProc.Parameters.Add("@number_of_allowed_guests", SqlDbType.Int);
            number.Direction = ParameterDirection.Output;

            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;
            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "0")
            {
                Label31.Text = "no more guests allowed";

            }
            else if (success.Value.ToString() == "5")
                Label31.Text = "email belongs to an existing user";
            else if (success.Value.ToString() == "3")
                Label31.Text = "room does not exist";
            else
                Label31.Text = "Guest added successfully   Number of guests left: " + number.Value.ToString();
        }
    }
}