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
    <h2 class="text-center my-3 h2 font-weight-bold text-softgray">Books</h2>

    <cfinvoke component="../components/bookservice"  method="fetchAllBooks" returnvariable="books">

<!--- ------------------messages------------------- --->
    <cfif structKeyExists(url, 'errormsg')>
        <p class="text-danger text-center">#url.errormsg#</p>
    </cfif>
    <cfif structKeyExists(url, 'successmsg')>
        <p class="text-success text-center">#url.successmsg#</p>
    </cfif>
<!--- ---------------------------------------------- --->
    <div class="d-flex flex-wrap justify-content-center">
        <cfloop query="books">
            <div class="card rounded-md m-5 shadow-md" style="width:14rem;">
                <div class="ml-auto mr-auto mt-4 ">
                    <img src="../media/#books.File_Path#" style="height:12rem;object-fit:cover;" class="overflow-hidden w-10 rounded-md">
                </div>
                <div class="text-center mt-2 mb-4">
                    <h5>#books.Book_Title#</h5>
                    <a href="../functions/addtocart.cfm?id=#books.id#" class="btn btn-primary mt-2">Add to cart</a>
                </div>
            </div>
        </cfloop>
    </div>
    </cfoutput>
</body>
</html>