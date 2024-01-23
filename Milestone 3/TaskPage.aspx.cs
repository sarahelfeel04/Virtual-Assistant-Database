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

namespace HomeSyncM3
{
    public partial class TaskPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void viewTaskID_Click(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

           

            string userIDString = Session["user"].ToString();

            int id = int.Parse(userIDString);

            SqlCommand loginProc = new SqlCommand("ViewMyTask", conn);
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
                emptyTable.Rows.Add("No tasks found.");

                GridView2.DataSource = emptyTable;
                GridView2.DataBind();
                GridView2.Visible = true;
            }


        }

        protected void finishID_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            string title = titleID.Text;


            string userIDString = Session["user"].ToString();

            int id = int.Parse(userIDString);

           


            SqlCommand loginProc = new SqlCommand("FinishMyTask", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@title", title));
            loginProc.Parameters.Add(new SqlParameter("@user_id", id));


            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            
           
            
            if (success.Value.ToString() == "-1")
                Label13.Text = "task does not exist";
            else
                Label13.Text = "finished successfully";



        }

        protected void statusID_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (string.IsNullOrEmpty(creatorID.Text) || !int.TryParse(creatorID.Text, out _))
            {
               
                DataTable emptyTable = new DataTable();
                emptyTable.Columns.Add("Message", typeof(string));
                emptyTable.Rows.Add("Please enter valid creator.");

                GridView1.DataSource = emptyTable;
                GridView1.DataBind();
                GridView1.Visible = true;
                return;
            }
            string creator = creatorID.Text;
           

            string userIDString = Session["user"].ToString();

            int id = int.Parse(userIDString);

            SqlCommand loginProc = new SqlCommand("ViewTask", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@creator", creator));
            loginProc.Parameters.Add(new SqlParameter("@user_id", id));

            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();
            
            if (success.Value.ToString() == "5")
            {
              
                DataTable emptyTable = new DataTable();
                emptyTable.Columns.Add("Message", typeof(string));
                emptyTable.Rows.Add("No tasks found.");

                GridView1.DataSource = emptyTable;
                GridView1.DataBind();
                GridView1.Visible = true;

            }
            else {
               
                SqlDataAdapter adapter = new SqlDataAdapter(loginProc);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    GridView1.Visible = true;
                }
            } 
        }

        protected void reminderID_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (string.IsNullOrEmpty(reminderIDR.Text))
            {
                Label14.Text = "Please enter the reminder date";
                return;
            }

            if (!DateTime.TryParseExact(reminderIDR.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
            {
                Label14.Text = "Invalid date format. Please enter the date in MM/dd/yyyy format.";
                return;
            }
            if (string.IsNullOrEmpty(taskIDR.Text) || !int.TryParse(taskIDR.Text, out _))
            {
                Label14.Text = "Please enter valid task id";
                return;
            }
             string taskID = taskIDR.Text;
            DateTime remind = DateTime.ParseExact(reminderIDR.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);


            SqlCommand loginProc = new SqlCommand("AddReminder", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@task_id", taskID));
            loginProc.Parameters.Add(new SqlParameter("@reminder", remind));

            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();
            
            if (success.Value.ToString() == "1")
            {
                Label14.Text = "reminder added for the " + remind;
               
            }
            else
            {
                Label14.Text = "task does not exist";
            }
        }

        protected void updateID_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            if (string.IsNullOrEmpty(updateIDU.Text))
            {
                Label15.Text = "Please enter the due date";
                return;
            }

            if (!DateTime.TryParseExact(updateIDU.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
            {
                Label15.Text = "Invalid date format. Please enter the date in MM/dd/yyyy format.";
                return;
            }
            if (string.IsNullOrEmpty(taskIDU.Text) || !int.TryParse(taskIDU.Text, out _))
            {
                Label15.Text = "Please enter valid task id";
                return;
            }
            string taskIDR = taskIDU.Text;
            int taskk= int.Parse(taskIDR);
            DateTime update = DateTime.ParseExact(updateIDU.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
         

            SqlCommand loginProc = new SqlCommand("UpdateTaskDeadline", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@task_id", taskk));
            loginProc.Parameters.Add(new SqlParameter("@deadline", update));


            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Label15.Text = "task updated successfully to: " + update;

            }
            else
                Label15.Text = "task does not exist";




        }
    }
}