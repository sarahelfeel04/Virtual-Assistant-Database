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
using System.Globalization;

namespace HomeSyncM3
{
    public partial class RoomPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string type = Session["type"].ToString();
            if (!Page.IsPostBack && type=="Guest")
            {
                this.scheduleID.Visible = false;
                this.Label18.Visible = false;
                this.Label19.Visible = false;
                this.Label2.Visible = false;
                this.Label16.Visible = false;
                this.Label17.Visible = false;
                this.Label5.Visible = false;
                this.room.Visible = false;
                this.start.Visible = false;
                this.end.Visible = false;
                this.action.Visible = false;
                this.scheduleID.Visible = false;
                this.Label7.Visible = false;
                this.Label20.Visible = false;
                this.Label21.Visible = false;
                this.Label22.Visible = false;
                this.status.Visible = false;
                this.statusID.Visible = false;
                this.location.Visible = false;
                this.Label25.Visible = false;
                this.viewAvailableID.Visible = false;
                this.GridView3.Visible = false;

            }

        }

        protected void viewRoomID_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);



            string userIDString = Session["user"].ToString();

            int id = int.Parse(userIDString);

            SqlCommand loginProc = new SqlCommand("ViewAssignedRoom", conn);
            loginProc.CommandType = CommandType.StoredProcedure;

            loginProc.Parameters.Add(new SqlParameter("@user_id", id));


            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(loginProc);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                // Bind the DataTable to the GridView
                GridView2.DataSource = dt;
                GridView2.DataBind();
                GridView2.Visible = true;
            }
            else
            {

                DataTable emptyTable = new DataTable();
                emptyTable.Columns.Add("Message", typeof(string));
                emptyTable.Rows.Add("No rooms found");

                GridView2.DataSource = emptyTable;
                GridView2.DataBind();
                GridView2.Visible = true;
            }

        }

        protected void bookID_Click(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            int room;
            if (roomID == null || !int.TryParse(roomID.Text, out room))
            {
                 Label15.Text = "Please enter valid room";
                return;
                 //room = 19999;
            }
            // room = 19999;
            else
            room = int.Parse(roomID.Text);


            string userIDString = Session["user"].ToString();

            int id = int.Parse(userIDString);

           


            SqlCommand loginProc = new SqlCommand("AssignRoom", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@room_id", room));
            loginProc.Parameters.Add(new SqlParameter("@user_id", id));


            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();




            if (success.Value.ToString() == "0")
                Label15.Text = "room is booked or not found";
            else
                Label15.Text = "Room "+ room+" successfully booked";


        }

        protected void scheduleID_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (string.IsNullOrEmpty(room.Text) || !int.TryParse(room.Text, out _))
            {
                Label19.Text = "Please enter valid room id";
                return;
            }
            if (string.IsNullOrEmpty(start.Text))
            {
                Label19.Text = "Please enter the start date";
                return;
            }

            if (!DateTime.TryParseExact(start.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
            {
                Label19.Text = "Invalid date format. Please enter the date in MM/dd/yyyy format.";
                return;
            }

            if (string.IsNullOrEmpty(end.Text))
            {
                Label19.Text = "Please enter the end date";
                return;
            }

            if (!DateTime.TryParseExact(end.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
            {
                Label19.Text = "Invalid date format. Please enter the date in MM/dd/yyyy format.";
                return;
            }
            
            if (string.IsNullOrEmpty(action.Text) )
            {
                Label19.Text = "Please enter action";
                return;
            }

            int roomID = int.Parse(room.Text);
            DateTime startTime = DateTime.ParseExact(start.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            DateTime endTime = DateTime.ParseExact(end.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            string act = action.Text;
            string userIDString = Session["user"].ToString();
            int id = int.Parse(userIDString);


            SqlCommand loginProc = new SqlCommand("CreateSchedule", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@creator_id", id));
            loginProc.Parameters.Add(new SqlParameter("@room_id", roomID));
            loginProc.Parameters.Add(new SqlParameter("@start_time", startTime));
            loginProc.Parameters.Add(new SqlParameter("@end_time", endTime));
            loginProc.Parameters.Add(new SqlParameter("@action", act));

            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Label19.Text = "room scheduled successfully";

            }
            else if (success.Value.ToString() == "0")
                Label19.Text = "room does not exist";
            else
                Label19.Text = "you already have a room scheduled at that time";
        }

        protected void statusID_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (string.IsNullOrEmpty(location.Text) || !int.TryParse(location.Text, out _))
            {
                Label22.Text = "Please enter valid room id";
                return;
            }
            if (string.IsNullOrEmpty(status.Text))
            {
                Label22.Text = "Please enter the status";
                return;
            }
            string loc = location.Text;
            int locationID = int.Parse(loc);
            string statuss = status.Text;
          
            


            SqlCommand loginProc = new SqlCommand("RoomAvailability", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@status", statuss));
            loginProc.Parameters.Add(new SqlParameter("@location", locationID));


            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Label22.Text = "room status changed to: " + statuss;

            }
            else
                Label22.Text = "room does not exist";
        }

        protected void viewAvailableID_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);



            SqlCommand loginProc = new SqlCommand("ViewRoom", conn);
            loginProc.CommandType = CommandType.StoredProcedure;

           


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
                emptyTable.Rows.Add("No available rooms");

                GridView3.DataSource = emptyTable;
                GridView3.DataBind();
                GridView3.Visible = true;
            }
        }
    }
}