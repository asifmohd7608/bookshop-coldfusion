<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bookshop</title>
    <link href="../css/main.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="../css/bootstrap/dist/js/bootstrap.min.js"></script>
</head>
<body>
    <cfinclude   template="../templates/header.cfm">
<cfoutput>
   <div class="container col-8 col-sm-5  col-lg-3 border  shadow  rounded-md mt-10 p-4">
        <form action="../functions/loginUser.cfm" method="post">
        <h4 class="text-center font-weight-light-bold">LOGIN</h4>
            <div class="form-group ">
                <label class="font-weight-light-bold" for="username">Username</label>
                <input class="form-control" type="email" id="username" name="username" >
            </div>
            <div class="form-group">
                <label class="font-weight-light-bold" for="password">Password</label>
                <input class="form-control" type="password" id="password" name="password" >
            </div>
            <div class="text-center">
            <button type="submit" class="btn btn-primary">Login</button>
            </div>
            <cfif structKeyExists(url, "errormsg") >
                <div class="text-danger text-center mt-3">
                    <small>#url.errormsg#</small>
                </div>
            </cfif>
        </form>
   </div>

    


</cfoutput>
</body>
</html>