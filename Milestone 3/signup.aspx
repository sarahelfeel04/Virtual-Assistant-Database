<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="HomeSyncM3.signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HomeSync Signup</title>
    <link rel="stylesheet" type="text/css" href="CSSComm/SignupStyles.css" />
</head>
<body>
    <form id="form1" runat="server" class="login-form">
        <div class="logo">
            HomeSync
        </div>
        <div class="login-container">
            <h2>Sign up</h2>
            
            <asp:Label ID="Label2" runat="server" Text="Email" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="emailID" runat="server" class="form-input"></asp:TextBox>

            <asp:Label ID="Label3" runat="server" Text="Password" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="passID" runat="server" class="form-input"></asp:TextBox>

            <asp:Label ID="Label4" runat="server" Text="First Name" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="firstID" runat="server" class="form-input"></asp:TextBox>

            <asp:Label ID="Label5" runat="server" Text="Last Name" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="lastID" runat="server" class="form-input"></asp:TextBox>

            <asp:Label ID="Label6" runat="server" Text="Birthdate (MM/DD/YYYY)" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="birthID" runat="server" class="form-input"></asp:TextBox>

            <asp:Label ID="Label7" runat="server" Text="" CssClass="error-label"></asp:Label>

            <asp:Button ID="button2ID" runat="server" OnClick="signupClick" Text="Signup" class="form-button" />
            
            <asp:Label ID="Label1" runat="server" Text="Already a user? Login" CssClass="form-label"></asp:Label>
            <p>
                <asp:Button ID="login" runat="server" Text="Login" OnClick="login_Click" class="form-button" />
            </p>
        </div>
    </form>
</body>
</html>

