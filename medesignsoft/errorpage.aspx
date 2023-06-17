<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="errorpage.aspx.cs" Inherits="totalsale_report.errorpage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <!-- Content Header (Page header) -->
    <section class="content-header">      
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="error-page">
            <h2 class="headline text-yellow">404 Error Page</h2>
            <div class="error-content">
                <h3><i class="fa fa-warning text-yellow"></i>Oops! Page not found.</h3>
                <p>
                    We could not find the page you were looking for.
            Meanwhile, you may <a href="../../default.aspx">return to dashboard</a> or try using the search form.
         
                </p>
            </div>
            <!-- /.error-content -->
        </div>
        <!-- /.error-page -->
    </section>
</asp:Content>
