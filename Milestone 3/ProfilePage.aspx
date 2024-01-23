<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProfilePage.aspx.cs" Inherits="HomeSyncM3.ProfilePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Profile</title>
      <link rel="stylesheet" type="text/css" href="CSSComm/profileStyle.css" />
    <link rel="stylesheet" type="text/css" href="CSSComm/ButtonStyle.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label38" runat="server" Text="My profile" CssClass ="label3"></asp:Label>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="True"></asp:GridView>
            <br />
            <br />
           
            <asp:Label ID="Label1" runat="server" Text="Delete Guest" CssClass ="label"></asp:Label>
            
        <br />
        <asp:Label ID="Label20" runat="server" Text="guest id" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="guest" runat="server"></asp:TextBox>
        <br />
            <br />
        <br />
        <asp:Button ID="delete" runat="server" Text="delete guest" OnClick="delete_Click" class="button-34" role="button"  />
        <br />
            <br />
        <asp:Label ID="Label22" runat="server" Text="" CssClass ="label2"></asp:Label>
            <br />
            <hr />
          <br />
            <asp:Label ID="Label23" runat="server" Text="View number of current guests" CssClass ="label"></asp:Label>
            <br />
        <br />
        <asp:Button ID="ViewNumber" runat="server" Text="view" OnClick="ViewNumber_Click" class="button-34" role="button"  />
        <br />
            <br />
        <asp:Label ID="Label25" runat="server" Text="" CssClass ="label2"></asp:Label>
            <br />
            <hr />
            <asp:Label ID="Label26" runat="server" Text="Set number of guests: " CssClass ="label"></asp:Label>
       
        <br />
        <asp:Label ID="Label27" runat="server" Text="number of guests" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="num" runat="server"></asp:TextBox>
        <br />
            <br />
        <br />
        <asp:Button ID="setNumber" runat="server" Text="set number" OnClick="setNumber_Click" class="button-34" role="button"   />
        <br />
            <br />
        <asp:Label ID="Label28" runat="server" Text="" CssClass ="label2"></asp:Label>
            <br />
             <hr />
            <asp:Label ID="Label29" runat="server" Text="Add guest: " CssClass ="label"></asp:Label>
            <br />
         
        <asp:Label ID="Label36" runat="server" Text="email" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="email" runat="server"></asp:TextBox>
            <br />
     
        <asp:Label ID="Label37" runat="server" Text="password" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="pass" runat="server"></asp:TextBox>
            <br />

        <asp:Label ID="Label30" runat="server" Text="first name" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="first" runat="server"></asp:TextBox>
            <br />
     
        <asp:Label ID="Label32" runat="server" Text="last name" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="last" runat="server"></asp:TextBox>
        <br />
   
        <asp:Label ID="Label33" runat="server" Text="address" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="address" runat="server"></asp:TextBox>
            <br />

        <asp:Label ID="Label34" runat="server" Text="room id" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="room" runat="server"></asp:TextBox>
            <br />
    
        <asp:Label ID="Label35" runat="server" Text="birthdate" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="date" runat="server"></asp:TextBox>
            <br />

        <asp:Button ID="addGuest" runat="server" Text="Add guest" OnClick="addGuest_Click"  class="button-34" role="button"  />
        <br />
            <br />
        <asp:Label ID="Label31" runat="server" Text="" CssClass ="label2"></asp:Label>
  
            <br />
        </div>
    </form>
</body>
</html>
