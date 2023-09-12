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

   <div class="container col-8 col-lg-6 border border-mediumgray  shadow-lg   rounded-md mt-4 mb-4 p-4">
        <form action="../functions/registeruser.cfm" method="post">
        <h4 class="text-center font-weight-light-bold">SIGNUP</h4>
        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group ">
                        <label class="font-weight-light-bold" for="firstname">First Name</label>
                        <input class="form-control" type="text" id="firstname" name="firstname" >
                </div>
                <div class="form-group ">
                    <label class="font-weight-light-bold" for="email">Email</label>
                    <input class="form-control" type="email" id="email" name="username" >
                    
                    
                </div>
                <div class="form-group ">
                    <label class="font-weight-light-bold" for="mobile">Mobile</label>
                    <input class="form-control" type="text" id="mobile" name="mobile" >
                </div>
                <div class="form-group ">
                    <label class="font-weight-light-bold" for="city">City</label>
                    <input class="form-control" type="text" id="city" name="city" >
                </div>
                <div class="form-group ">
                    <label class="font-weight-light-bold" for="password">Password</label>
                    <input class="form-control" type="password" id="password" name="password" >
                </div>
            </div>
            <div class="col-12 col-md-6">
                <div class="form-group ">
                    <label class="font-weight-light-bold" for="lastname">Last Name</label>
                    <input class="form-control" type="text" id="lastname" name="lastname" >
                </div>
                <div class="form-group ">
                    <label class="font-weight-light-bold" for="addressline1">Address Line 1</label>
                    <input class="form-control" type="text" id="addressline1" name="addressline1" >
                </div>
                <div class="form-group ">
                    <label class="font-weight-light-bold" for="addressline2">Address Line 2</label>
                    <input class="form-control" type="text" id="addressline2" name="addressline2" >
                </div>
                <div class="form-group ">
                    <label class="font-weight-light-bold" for="addressline3">Address Line 3</label>
                    <input class="form-control" type="text" id="addressline3" name="addressline3" >
                </div>
            </div>
        </div>
        <div class="text-center">
        <button type="submit" name="signup" class="btn btn-primary">SIGNUP</button>
        </div>
        
        </form>
   </div>

</cfoutput>
</body>
</html>