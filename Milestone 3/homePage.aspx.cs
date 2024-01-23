using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeSyncM3
{
    public partial class homePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void TaskOnClick(object sender, EventArgs e)
        {
            Response.Redirect("TaskPage.aspx");
        }

        protected void EventsOnClick(object sender, EventArgs e)
        {
            Response.Redirect("EventPage.aspx");
        }

        protected void Rooms_Click(object sender, EventArgs e)
        {
            Response.Redirect("RoomPage.aspx");
        }

        protected void DeviceID_Click(object sender, EventArgs e)
        {
            Response.Redirect("device.aspx");
        }

        protected void FinanceID_Click(object sender, EventArgs e)
        {

            Response.Redirect("Finance.aspx");
        }

        protected void MessageID_Click(object sender, EventArgs e)
        {
            Response.Redirect("Communication.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProfilePage.aspx");
        }
    }
}