<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Finance.aspx.cs" Inherits="HomeSyncM3.Finance" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Finance</title>
          <link rel="stylesheet" type="text/css" href="CSSComm/profileStyle.css" />
<link rel="stylesheet" type="text/css" href="CSSComm/ButtonStyle.css" />

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="My Financial Details"  CssClass ="label3"></asp:Label>

        <br />
            <asp:Label ID="Label2" runat="server" Text="Receive a transation:"  CssClass ="label"></asp:Label>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Enter amount" CssClass ="label2"></asp:Label>
            <br />
            <asp:TextBox ID="amountRT" runat="server" ></asp:TextBox>
           <br />
           <br />
      
            <asp:Label ID="Label4" runat="server" Text="Date (write in the form MM/DD/YYYY)" CssClass ="label2"></asp:Label>
        <br />
    
            <asp:TextBox ID="dateRT" runat="server" ></asp:TextBox>

        <br />

        <br />

        <asp:Button ID="Button1" runat="server"  OnClick="Button1_Click" Text="Receive Transaction" class="button-34"  />
        <br />
            <br />
        <asp:Label ID="succcessRT" runat="server" Text="" CssClass ="label2"></asp:Label>
        <br />
        <hr />
        <br />
        <asp:Label ID="Label5" runat="server" Text="Plan Payment:" CssClass ="label"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label6" runat="server" Text="Enter receiver id " CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="recID" runat="server"></asp:TextBox>
         <br />
         <asp:Label ID="Label7" runat="server" Text="Enter amount " CssClass ="label2"></asp:Label>
         <br />
        <asp:TextBox ID="amountMP" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label8" runat="server" Text="Enter date (write in the form MM/DD/YYYY) " CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="dateMP" runat="server"></asp:TextBox>
        <p>
            <asp:Button ID="Button2" runat="server" Text="Make Payment" OnClick="Button2_Click" class="button-34" />
            <br />
            <br />
            <asp:Label ID="successMP" runat="server" Text="" CssClass ="label2"></asp:Label>
        </p>
        </div>
    </form>
</body>
</html>