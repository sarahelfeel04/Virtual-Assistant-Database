<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="homePage.aspx.cs" Inherits="HomeSyncM3.homePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home Page</title>
     <link rel="stylesheet" type="text/css" href="CSSComm/mainPageStyle.css" />
</head>
<body>
    
    <div class="welcome-section">
        <h1 class="welcome-label">Welcome to HomeSync</h1>
    </div>
    <form id="form1" runat="server">
   <div class="button-container">
    <asp:Button ID="TaskID" runat="server" Text="Tasks" OnClick="TaskOnClick" CssClass="button" />
    <asp:Button ID="EventsID" runat="server" Text="Events" OnClick="EventsOnClick" CssClass="button" />
    <asp:Button ID="RoomsID" runat="server" Text="Rooms" OnClick="Rooms_Click" CssClass="button" />
    <asp:Button ID="DeviceID" runat="server" Text="Devices" OnClick="DeviceID_Click" CssClass="button" />
    <asp:Button ID="FinanceID" runat="server" Text="Finance" OnClick="FinanceID_Click" CssClass="button" />
    <asp:Button ID="MessageID" runat="server" Text="Messages" OnClick="MessageID_Click" CssClass="button" />
    <asp:Button ID="Button1" runat="server" Text="My Profile" OnClick="Button1_Click" CssClass="button" />
</div>
        </form>

</body>
</html>
