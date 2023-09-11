<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bookshop</title>
    <link href="./css/main.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="./css/bootstrap/dist/js/bootstrap.min.js"></script>
</head>
<body>
    <cfinclude   template="./templates/header.cfm">

 
<!---  <cfif CGI.SCRIPT_NAME eq '/login.cfm' >  --->
    <cfinclude  template="./login.cfm">
<!---  </cfif>  --->
<!---  <cfif CGI.SCRIPT_NAME eq '/home.cfm' >  --->
<!---     <cfinclude  template="./home.cfm"> --->
<!---  </cfif>  --->

</body>
</html>