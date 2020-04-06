<%
  String path = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    ...
    <link
      rel="stylesheet"
      href="<%=path %>/static/bootstrap-4.4.1-dist/css/bootstrap.min.css"
    />
    ...
  </head>
  <body>
    ...
    <script src="<%=path %>/static/jquery-3.4.1.min.js"></script>
    <script src="<%=path %>/static/bootstrap-4.4.1-dist/js/bootstrap.min.js"></script>
  </body>
  ...
</html>
