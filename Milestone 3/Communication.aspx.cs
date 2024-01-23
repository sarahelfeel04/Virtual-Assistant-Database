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
using System.Reflection.Emit;

namespace HomeSyncM3
{
    public partial class Communication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string type = Session["type"].ToString();
            if (!Page.IsPostBack && type == "Guest")
            {
                this.Label11.Visible = false;
                this.Button3.Visible = false;
                this.Label3.Visible = false;
               
            }
            }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            if (string.IsNullOrEmpty(recID.Text) || !int.TryParse(recID.Text, out _))
            {
                Label1.Text = "Please enter the receiver ID";
                return;
            }
            if (string.IsNullOrEmpty(title.Text))
            {
                Label1.Text = "Please enter a title";
                return;
            }
            if (string.IsNullOrEmpty(content.Text))
            {
                Label1.Text = "Please enter message content";
                return;
            }
       
            int receiver = Int16.Parse(recID.Text);

            SqlCommand loginProc = new SqlCommand("SendMessage", conn);
            loginProc.CommandType = CommandType.StoredProcedure;

            string userIDString = Session["user"].ToString();
            int id = int.Parse(userIDString);

            string nowWithSeconds = DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss");
            DateTime now = DateTime.ParseExact(nowWithSeconds, "MM/dd/yyyy HH:mm:ss", CultureInfo.InvariantCulture);


            // string titlee = title.Text;
            // string contentt = content.Text;

            loginProc.Parameters.Add(new SqlParameter("@sender_id", id));
            loginProc.Parameters.Add(new SqlParameter("@receiver_id", receiver));
            loginProc.Parameters.Add(new SqlParameter("@title", title.Text));
            loginProc.Parameters.Add(new SqlParameter("@content", content.Text));
            loginProc.Parameters.Add(new SqlParameter("@timesent", now));
            loginProc.Parameters.Add(new SqlParameter("@timereceived", now));

            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;


            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Label1.Text = "message sent!";
            }
            else
                Label1.Text = "invalid receiver id ";
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            if (string.IsNullOrEmpty(withUser.Text) || !int.TryParse(withUser.Text, out _))
            {
                DataTable emptyTable = new DataTable();
                emptyTable.Columns.Add("Message", typeof(string));
                emptyTable.Rows.Add("Please enter the other user id");

                GridView2.DataSource = emptyTable;
                GridView2.DataBind();
                GridView2.Visible = true;
                return;
            }

            int other = Int16.Parse(withUser.Text);
            SqlCommand loginProc = new SqlCommand("ShowMessages", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            string userIDString = Session["user"].ToString();
            int id = int.Parse(userIDString);


            loginProc.Parameters.Add(new SqlParameter("@user_id", id));
            loginProc.Parameters.Add(new SqlParameter("@sender_id", other));

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
                emptyTable.Rows.Add("No messages found");

                GridView2.DataSource = emptyTable;
                GridView2.DataBind();
                GridView2.Visible = true;
            }



            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();


        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand loginProc = new SqlCommand("DeleteMsg", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            string userIDString = Session["user"].ToString();



            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();
            Label3.Text = "Last message deleted!";
        }
    }
}