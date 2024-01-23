using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Collections.Specialized.BitVector32;

namespace HomeSyncM3
{
    public partial class EventPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string type = Session["type"].ToString();
            if (!Page.IsPostBack && type == "Guest")
            {
                this.Label29.Visible = false;
                this.Label30.Visible = false;
                this.Label31.Visible = false;
                this.Label32.Visible = false;
                this.event4.Visible = false;
                this.user4.Visible = false;
                this.delete.Visible = false;
                
            }
        }

        protected void createID_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);


             if (string.IsNullOrEmpty(event1.Text) || !int.TryParse(event1.Text, out _))
            {
                Label19.Text = "Please enter valid event id";
                return;
            }
            if (string.IsNullOrEmpty(name.Text))
            {
                Label19.Text = "Please enter the name";
                return;
            }
            if (string.IsNullOrEmpty(description.Text))
            {
                Label19.Text = "Please enter the description";
                return;
            }

            if (string.IsNullOrEmpty(location.Text) || !int.TryParse(location.Text, out _))
            {
                Label19.Text = "Please enter valid room id";
                return;
            }
            if (string.IsNullOrEmpty(reminder.Text))
            {
                Label19.Text = "Please enter the reminder date";
                return;
            }

            if (!DateTime.TryParseExact(reminder.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
            {
                Label19.Text = "Invalid date format. Please enter the date in MM/dd/yyyy format.";
                return;
            }

          

    

            int eventt = int.Parse(event1.Text);
            string namee = name.Text;
            string desc = description.Text;
            string room = location.Text;
            DateTime reminderID = DateTime.ParseExact(reminder.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            int userr;
            if (!string.IsNullOrEmpty(extraUser.Text) && int.TryParse(extraUser.Text, out _))
                userr = int.Parse(extraUser.Text);
            else if (!string.IsNullOrEmpty(extraUser.Text) && !int.TryParse(extraUser.Text, out _))
            {
                Label19.Text = "Enter other user id in correct format";
                return;
            }
            else
                userr = -1;

            string userIDString = Session["user"].ToString();
            int id = int.Parse(userIDString);


            SqlCommand loginProc = new SqlCommand("CreateEvent", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@event_id", eventt));
            loginProc.Parameters.Add(new SqlParameter("@user_id", id));
            loginProc.Parameters.Add(new SqlParameter("@name", namee));
            loginProc.Parameters.Add(new SqlParameter("@description", desc));
            loginProc.Parameters.Add(new SqlParameter("@location", room));
            loginProc.Parameters.Add(new SqlParameter("@reminder_date", reminderID));
            loginProc.Parameters.Add(new SqlParameter("@other_user_id", userr));

            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "-1")
            {
                Label19.Text = "event already exists";

            }
            else if (success.Value.ToString() == "1")
                Label19.Text = "event successfully added for 2 users";
            else
                Label19.Text = "event successfully added for 1 user";
        }

        protected void assignID_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                if (string.IsNullOrEmpty(user.Text) || !int.TryParse(user.Text, out _))
                {
                    DataTable emptyTable = new DataTable();
                    emptyTable.Columns.Add("Message", typeof(string));
                    emptyTable.Rows.Add("Please enter User ID");

                    GridView2.DataSource = emptyTable;
                    GridView2.DataBind();
                    GridView2.Visible = true;
                    return;
                }
                if (string.IsNullOrEmpty(eventID.Text) || !int.TryParse(eventID.Text, out _))
                {
                    DataTable emptyTable = new DataTable();
                    emptyTable.Columns.Add("Message", typeof(string));
                    emptyTable.Rows.Add("Please enter event ID");

                    GridView2.DataSource = emptyTable;
                    GridView2.DataBind();
                    GridView2.Visible = true;
                    return;
                }
                int id = int.Parse(user.Text);
                int eventt = int.Parse(eventID.Text);

                SqlCommand assignUserProc = new SqlCommand("AssignUser", conn);
                assignUserProc.CommandType = CommandType.StoredProcedure;

                assignUserProc.Parameters.Add(new SqlParameter("@user_id", id));
                assignUserProc.Parameters.Add(new SqlParameter("@event_id", eventt));

                conn.Open();

                // ExecuteNonQuery is used for INSERT/UPDATE/DELETE operations
                // Use ExecuteReader for queries that return data
                // Use ExecuteScalar for queries that return a single value
                SqlDataReader reader = assignUserProc.ExecuteReader();

                if (reader.HasRows)
                {
                    // Bind the SqlDataReader to the GridView
                    GridView2.DataSource = reader;
                    GridView2.DataBind();
                    GridView2.Visible = true;
                }
                else
                {
                    DataTable emptyTable = new DataTable();
                    emptyTable.Columns.Add("Message", typeof(string));
                    emptyTable.Rows.Add("Event or user does not exist or user already assigned");

                    GridView2.DataSource = emptyTable;
                    GridView2.DataBind();
                    GridView2.Visible = true;
                }

                conn.Close();
            }
        }


        protected void uninvite_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

           
            if (string.IsNullOrEmpty(event2.Text) || !int.TryParse(event2.Text, out _))
            {
                Label28.Text = "Please enter event ID";
                return;
            }
            if (string.IsNullOrEmpty(user2.Text) || !int.TryParse(user2.Text, out _))
            {
                Label28.Text = "Please enter user id";
                return;
            }
            int eventt = int.Parse(event2.Text);
            int userr = int.Parse(user2.Text);
          


            SqlCommand loginProc = new SqlCommand("Uninvited", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@event_id", eventt));
            loginProc.Parameters.Add(new SqlParameter("@user_id", userr));


            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "-1")
            {
                Label28.Text = "event or user does not exist";

            }
            else
                Label28.Text = "user uninvited successfully";
        }

        protected void viewEvent_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            int eventt=0;
            if (string.IsNullOrEmpty(user3.Text) || !int.TryParse(user3.Text, out _))
            {
                DataTable emptyTable = new DataTable();
                emptyTable.Columns.Add("Message", typeof(string));
                emptyTable.Rows.Add("Please enter User ID");

                GridView3.DataSource = emptyTable;
                GridView3.DataBind();
                GridView3.Visible = true;
                return;
            }
            if (string.IsNullOrEmpty(event3.Text)){
                eventt = -1;
            }

            else if (!int.TryParse(event3.Text, out _))
            {
                DataTable emptyTable = new DataTable();
                emptyTable.Columns.Add("Message", typeof(string));
                emptyTable.Rows.Add("Please enter event ID in correct format");

                GridView3.DataSource = emptyTable;
                GridView3.DataBind();
                GridView3.Visible = true;
                return;
            }
            if (eventt!=-1)
            eventt = int.Parse(event3.Text);

            int userr = int.Parse(user3.Text);



            SqlCommand loginProc = new SqlCommand("ViewEvent", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@event_id", eventt));
            loginProc.Parameters.Add(new SqlParameter("@user_id", userr));



            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();


            SqlDataAdapter adapter = new SqlDataAdapter(loginProc);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                // Bind the DataTable to the GridView
                GridView3.DataSource = dt;
                GridView3.DataBind();
                GridView3.Visible = true;
            }
            else
            {

                DataTable emptyTable = new DataTable();
                emptyTable.Columns.Add("Message", typeof(string));
                emptyTable.Rows.Add("No events found with this user");

                GridView3.DataSource = emptyTable;
                GridView3.DataBind();
                GridView3.Visible = true;
            }
        }

        protected void delete_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);


            if (string.IsNullOrEmpty(event4.Text) || !int.TryParse(event4.Text, out _))
            {
                Label32.Text = "Please enter event ID";
                return;
            }
            if (string.IsNullOrEmpty(user4.Text) || !int.TryParse(user4.Text, out _))
            {
                Label32.Text = "Please enter user id";
                return;
            }
            int eventt = int.Parse(event4.Text);
            int userr = int.Parse(user4.Text);



            SqlCommand loginProc = new SqlCommand("RemoveEvent", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@event_id", eventt));
            loginProc.Parameters.Add(new SqlParameter("@user_id", userr));


            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "-1")
            {
                Label32.Text = "event or user does not exist";

            }
            else
                Label32.Text = "event deleted successfully";
        }
    }
}