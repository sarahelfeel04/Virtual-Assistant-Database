<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="HomeSyncM3.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HomeSync Login</title>
    <link rel="stylesheet" type="text/css" href="CSSComm/LoginStyles.css" />
</head>
<body>
    <form id="form1" runat="server" class="login-form">
        <div class="logo">
            HomeSync
        </div>
        <div class="login-container">
            <h2>Login</h2>
            

            <asp:Label ID="Label1" runat="server" Text="Enter your email" CssClass="form-label"></asp:Label> <!-- Use ID instead of for -->
            <asp:TextBox ID="emailID" runat="server" class="form-input"></asp:TextBox>

            <asp:Label ID="Label2" runat="server" Text="Enter your password" CssClass="form-label"></asp:Label> <!-- Use ID instead of for -->
            <asp:TextBox ID="passID" runat="server" TextMode="Password" class="form-input"></asp:TextBox>
            
             <asp:Label ID="errorLabel" runat="server" CssClass="error-label" Text=""></asp:Label> <!-- Use ID instead of for -->

            <asp:Button ID="Button1" runat="server" OnClick="loginClick" Text="Login" class="form-button" />
            <div class="register-section">
                <asp:Label ID="Label3" runat="server" Text="Not a user? Register" CssClass="form-label"></asp:Label> <!-- Use ID instead of for -->
                <asp:Button ID="Button2" runat="server" Text="Register" OnClick="signupClick" class="form-button" />
            </div>
        </div>
    </form>
</body>
</html>


