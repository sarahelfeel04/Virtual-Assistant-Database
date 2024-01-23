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
using System.Net.NetworkInformation;
using System.Runtime.InteropServices;

namespace HomeSyncM3
{
    public partial class device : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string type = Session["type"].ToString();
            if (!Page.IsPostBack && type == "Guest")
            {
               
                this.Label14.Visible = false;
                this.Label5.Visible = false;
                this.Label6.Visible = false;
                this.Label7.Visible = false;
                this.Label8.Visible = false;
                this.Label9.Visible = false;
                this.Label10.Visible = false;
                this.Label11.Visible = false;
                this.Label15.Visible = false;
                this.Label16.Visible = false;
                this.Label17.Visible = false;
                this.deviceID1.Visible = false;
                this.status1.Visible = false;
                this.battery1.Visible = false;
                this.location1.Visible = false;
                this.type1.Visible = false;
                this.Button2.Visible = false;
                this.Button3.Visible = false;
                this.Button4.Visible = false;
                this.Button5.Visible = false;
                this.GridView3.Visible = false;
                this.GridView3.Visible = false;

            }
        }

        protected void viewchargeClick(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

           
            if (string.IsNullOrEmpty(deviceID.Text)|| !int.TryParse(deviceID.Text, out _))
            {
                Label2.Text = "Please enter a device";
                return;
            }
            int device_id = Int32.Parse(deviceID.Text);

            SqlCommand loginProc = new SqlCommand("ViewMyDeviceCharge", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@device_id", device_id));


            SqlParameter charge = loginProc.Parameters.Add("@charge", SqlDbType.Int);
            SqlParameter location = loginProc.Parameters.Add("@location", SqlDbType.Int);
            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            charge.Direction = ParameterDirection.Output;
            location.Direction = ParameterDirection.Output;
            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "0")
                Label2.Text = "does not exist";
            else
            {
                Label2.Text = "Device "+ device_id+ "\n"+ "Charge: "+ charge.Value.ToString() + " Room: "+ location.Value.ToString();
               

            }

        }

        protected void addDevice(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            if (string.IsNullOrEmpty(deviceID1.Text) || !int.TryParse(deviceID1.Text, out _))
            {
                Label10.Text = "Please enter the device ID";
                return;
            }
            if (string.IsNullOrEmpty(status1.Text))
            {
                Label10.Text = "Please enter a status";
                return;
            }
            if (string.IsNullOrEmpty(battery1.Text) || !int.TryParse(battery1.Text, out _))
            {
                Label10.Text = "Please enter battery";
                return;
            }
            if (string.IsNullOrEmpty(location1.Text) || !int.TryParse(location1.Text, out _))
            {
                Label10.Text = "Please enter room";
                return;
            }
            if (string.IsNullOrEmpty(type1.Text))
            {
                Label10.Text = "Please enter device type";
                return;
            }

            int deviceID = Int32.Parse(deviceID1.Text);
            string status = status1.Text;
            int battery = Int32.Parse(battery1.Text);
            int location = Int32.Parse(location1.Text);
            string type = type1.Text;


            SqlCommand loginProc = new SqlCommand("AddDevice", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@device_id", deviceID));
            loginProc.Parameters.Add(new SqlParameter("@status", status));
            loginProc.Parameters.Add(new SqlParameter("@battery", battery));
            loginProc.Parameters.Add(new SqlParameter("@location", location));
            loginProc.Parameters.Add(new SqlParameter("@type", type));

            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "0")
                Label10.Text = "room does not exist";
            else if (success.Value.ToString() == "-1")
                Label10.Text = "device already exists";
            else
                Label10.Text = "device added successfully";

        }

        protected void OutOfBattery(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand loginProc = new SqlCommand("OutOfBattery", conn);

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
                emptyTable.Rows.Add("No devices out of battery found");

                GridView2.DataSource = emptyTable;
                GridView2.DataBind();
                GridView2.Visible = true;
            }

        }
        protected void charging(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            
                SqlCommand chargingProc = new SqlCommand("Charging", conn);
                chargingProc.CommandType = CommandType.StoredProcedure;

                SqlParameter successParam = chargingProc.Parameters.Add("@success", SqlDbType.Int);
                successParam.Direction = ParameterDirection.Output;

                conn.Open();
                chargingProc.ExecuteNonQuery();
                conn.Close();

                int successValue = (int)successParam.Value;

                if (successValue == 0)
                    Label11.Text = "All devices are already charged";
                else
                    Label11.Text = "Charged successfully";
            
        }

        protected void OutOfBatterylocation(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["HomeSync"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand loginProc = new SqlCommand("NeedCharge", conn);

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
                emptyTable.Rows.Add("No devices out of battery found");

                GridView3.DataSource = emptyTable;
                GridView3.DataBind();
                GridView3.Visible = true;
            }
        }

        
    }
}