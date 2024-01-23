<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaskPage.aspx.cs" Inherits="HomeSyncM3.TaskPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Task</title>
      <link rel="stylesheet" type="text/css" href="CSSComm/profileStyle.css" />
<link rel="stylesheet" type="text/css" href="CSSComm/ButtonStyle.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <asp:Label ID="Label1" runat="server" Text="My tasks" CssClass ="label3"></asp:Label>
      
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Text="view my tasks:"  CssClass ="label"></asp:Label>
        <br />
        <br />
        <asp:Button ID="viewTaskID" runat="server" Text="view tasks" OnClick="viewTaskID_Click" class="button-34" role="button"/>
        <br />
         <br />
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="True" CssClass ="gridview"></asp:GridView>
        <br />
        <hr />
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="finish my task:" CssClass ="label"></asp:Label>
        <br />
        <asp:Label ID="Label4" runat="server" Text="title of the task" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="titleID" runat="server"></asp:TextBox>
        <br />
        
        <br />
        <asp:Button ID="finishID" runat="server" Text="finish" OnClick="finishID_Click" class="button-34" role="button" />
        <br />
        <br />
        <asp:Label ID="Label13" runat="server" Text="" CssClass ="label2"></asp:Label>
        <br />
        <hr />
        <br />
        <asp:Label ID="Label5" runat="server" Text="view tasks status:" CssClass ="label"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label6" runat="server" Text="enter id of the creator" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="creatorID" runat="server"></asp:TextBox>
        <br />
        <br />
        
        <asp:Button ID="statusID" runat="server" Text="view status" OnClick="statusID_Click" class="button-34" role="button"/>
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="True" CssClass ="gridview"></asp:GridView>
        <br />
        <br />
        <br />
        <hr />
        <asp:Label ID="Label7" runat="server" Text="Add reminder to task:" CssClass ="label"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label8" runat="server" Text="task id" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="taskIDR" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label9" runat="server" Text="reminder date (MM/DD/YYYY)" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="reminderIDR" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="reminderID" runat="server" Text="reminder" OnClick="reminderID_Click" class="button-34" role="button" />
        <br />
        <asp:Label ID="Label14" runat="server" Text="" CssClass ="label2"></asp:Label>
        <br />
        <br />
         <hr />
        <asp:Label ID="Label10" runat="server" Text="Update deadline of task:" CssClass ="label"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label11" runat="server" Text="task id" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="taskIDU" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label12" runat="server" Text="deadline date (MM/DD/YYYY)" CssClass ="label2"></asp:Label>
        <br />
        <asp:TextBox ID="updateIDU" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="updateID" runat="server" Text="update" OnClick=" updateID_Click" class="button-34" role="button"/>
        <br />
        <asp:Label ID="Label15" runat="server" Text="" CssClass ="label2"></asp:Label>
  
        </div>
    </form>
</body>
</html>
