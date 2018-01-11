<%@Page Language="C#" %>
<%
//Response.Clear();
//Response.Cache.SetNoStore();
//Response.AddHeader("Pragma", "no-cache");
//Response.Expires = -1;
string url = Request.QueryString["url"];
Response.WriteFile(url);
%>