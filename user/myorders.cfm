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
    <cfinvoke component="../components/queries"  method="fetchorders" returnvariable="orders">

    <div class="container">
        <h2 class="text-center my-3 h2 font-weight-bold text-softgray">My Orders</h2>
        <div class="d-none d-md-flex mx-1 p-3 my-4 top-4 rounded-md shadow-md text-center row  flex-nowrap sticky-top bg-white" id="labels">
                <div class="col-md-1">Cover</div>
                <div class="col-md-3">Title</div>
                <div class="col">Unit Price</div>
                <div class="col">Quantity</div>
                <div class="col">Total</div>
                <div class="col">Discount</div>
                <div class="col">Sub Total</div>
                <div class="col">Date</div>
            </div>
        <cfloop query="orders">
                <div class="card mb-3  p-3 rounded-md shadow-md text-center" >
                    <div class="row no-gutters align-items-baseline">
                        <div class="col-md-1">
                            <img src="../media/#orders.File_Path#" alt="book cover" style="object-fit:cover" class="img-fluid w-5 h-8 border rounded-md">
                        </div>
                        <div class="col-md-3">
                            <div class="card-body">
                                <h5 class="card-title">#ucFirst(orders.Book_Title)#</h5>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row align-items-baseline text-center col-8 col-md-12 mx-auto ">
                                <div class="col-12  col-md-2 d-flex justify-content-center">
                                    <span class="d-inline d-md-none">Unit Price : </span>Rs #orders.Price#
                                </div>
                                <div class="col-12  col-md-2 d-flex justify-content-center">
                                    <span class="d-inline d-md-none">Quantity : </span>#orders.Purchase_Count#
                                </div>
                                <div class="col-12  col-md-2 d-flex justify-content-center">
                                    <span class="d-inline d-md-none">Total : </span>#orders.Price * orders.Purchase_Count#
                                </div>
                                <div class="col-12  col-md-2 d-flex justify-content-center">
                                    <span class="d-inline d-md-none">Discount : </span>#orders.Discount_Amount#
                                </div>
                                <div class="col-12  col-md-2 d-flex justify-content-center" >
                                    <span class="d-inline d-md-none">Sub Total : </span>#orders.Subtotal#</div>
                                <div class="col-12  col-md-2 d-flex justify-content-center">
                                    <span class="d-inline d-md-none">Date : </span>#dateFormat(orders.createdAt,'dd/mm/yy')#
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </cfloop>
    </div>
    
    </cfoutput>
</body>
</html>