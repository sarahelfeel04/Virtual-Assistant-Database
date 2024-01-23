<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EventPage.aspx.cs" Inherits="HomeSyncM3.EventPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Event</title>
          <link rel="stylesheet" type="text/css" href="CSSComm/profileStyle.css" />
<link rel="stylesheet" type="text/css" href="CSSComm/ButtonStyle.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label20" runat="server" Text="My events" CssClass ="label3"></asp:Label>
            <br />
       
      
            <asp:Label ID="Label18" runat="server" Text="create event:" CssClass ="label"></asp:Label>

            <br />

            <br />
        <asp:Label ID="Label2" runat="server" Text="event id" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="event1" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label16" runat="server" Text="name of the event" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="name" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label17" runat="server" Text="description" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="description" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Text="location" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="location" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label1" runat="server" Text="reminder date (write in the form MM/DD/YYYY)" CssClass ="label2"></asp:Label>
         <br />
         <asp:TextBox ID="reminder" runat="server"></asp:TextBox>
         <br />
         <br />
         <asp:Label ID="Label3" runat="server" Text="other user id" CssClass ="label2"></asp:Label>
          <br />
          <asp:TextBox ID="extraUser" runat="server"></asp:TextBox>
         <br />
         <br />
        <asp:Button ID="createID" runat="server" Text="create event" OnClick="createID_Click"  class="button-34" />
            <br />
            <asp:Label ID="Label19" runat="server" Text="" CssClass ="label2"></asp:Label>
            <br />
            <br />

        <hr />

        <asp:Label ID="Label7" runat="server" Text="Assign User:" CssClass ="label"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label23" runat="server" Text="user id" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="user" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label22" runat="server" Text="event id" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="eventID" runat="server"></asp:TextBox>
            <br />
        <br />
        <asp:Button ID="assignID" runat="server" Text="assign user" OnClick="assignID_Click"  class="button-34" />
        <br />
        <br />
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="True" CssClass ="gridview"></asp:GridView>
            <br />

        <br />
        <hr />


        <asp:Label ID="Label24" runat="server" Text="Uninvite user from an event:" CssClass ="label"></asp:Label>
        <br />
        <br />  
        <asp:Label ID="Label25" runat="server" Text="event id" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="event2" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label26" runat="server" Text="user id" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="user2" runat="server"></asp:TextBox>
            <br />
        <br />
        <asp:Button ID="uninvite" runat="server" Text="uninvite" OnClick="uninvite_Click"  class="button-34"  />
        <br />
        <br />
         <asp:Label ID="Label28" runat="server" Text="" CssClass ="label2"></asp:Label>
        <hr />

        
        <asp:Label ID="Label4" runat="server" Text="View Event:" CssClass ="label"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label6" runat="server" Text="user id" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="user3" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label8" runat="server" Text="event id" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="event3" runat="server"></asp:TextBox>
            <br />
        <br />
        <asp:Button ID="viewEvent" runat="server" Text="view event" OnClick="viewEvent_Click"  class="button-34"  />
        <br />
        <br />
        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="True" CssClass ="gridview"></asp:GridView>
            <br />

        <br />
        <hr />


       


        <asp:Label ID="Label29" runat="server" Text="Delete event: " CssClass ="label"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label30" runat="server" Text="event id" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="event4" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label31" runat="server" Text="user id" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="user4" runat="server"></asp:TextBox>
            <br />
        <br />
        <asp:Button ID="delete" runat="server" Text="delete event" OnClick="delete_Click" class="button-34"   />
        <br />
        <br />
         <asp:Label ID="Label32" runat="server" Text="" CssClass ="label2"></asp:Label>
        

 </div>
    </form>
</body>
</html>
