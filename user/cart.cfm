<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bookshop</title>
    <link href="../css/main.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="../css/bootstrap/dist/js/bootstrap.min.js"></script>
</head>
<body>
    <cfinclude   template="../templates/header.cfm">
    <cfoutput>

    <div class="container">

        <h2 class="text-center my-3 h2 font-weight-bold text-softgray">CART</h2>

        <cfinvoke component="../components/bookservice"  method="fetchAllBooks" returnvariable="books">

    <!--- ------------------messages------------------- --->
        <cfif structKeyExists(url, 'errormsg')>
            <p class="text-danger text-center">#url.errormsg#</p>
        </cfif>
        <cfif structKeyExists(url, 'successmsg')>
            <p class="text-success text-center">#url.successmsg#</p>
        </cfif>
    <!--- ---------------------------------------------- --->
        <cfif structKeyExists(session, 'cart') AND structCount(session.cart) gt 0>
            <cfloop collection="#session.cart#" item="key">
                <cfinvoke component="../components/queries"  method="fetchbookbyid" id="#key#" returnvariable="book">
                <div class="card mb-3  p-3 rounded-md shadow-md text-center" data-key="#book.id#" >
                    <div class="row no-gutters align-items-center">
                        <div class="col-md-1">
                            <img src="../media/#book.File_Path#" alt="book cover" style="object-fit:cover" class="img-fluid w-5 h-8 rounded-md">
                        </div>
                        <div class="col-md-3">
                            <div class="card-body">
                                <h5 class="card-title">#ucFirst(book.Book_Title)#</h5>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row ">
                                <div class="col-12 col-sm-4 col-md-2">Rs #book.Price#</div>
                                <div class="col-12 col-sm-4 col-md-2">#session.cart[book.id].quantity#</div>
                                <div class="col-12 col-sm-4 col-md-2">Discount</div>
                                <div class="col-12 col-sm-4 col-md-2">Total Price</div>
                                <div class="col-12 col-sm-4 col-md-2">Delete</div>
                                <btn class="col-12 col-sm-4 col-md-2 removebtn"  data-id=#book.id#>Remove</btn>
                            </div>
                        </div>
                    </div>
                </div>
            </cfloop>
        <cfelse>
            <p class="font-weight-bold text-dark text-center mt-10 h1">Your cart is empty</p>
        </cfif>
    </div>
    </cfoutput>


    <script>
        let removebtns = document.querySelectorAll(".removebtn");
        removebtns.forEach(btn=>btn.addEventListener("click",(e)=>{
            console.log('clicked')
            console.log('id',btn.dataset.id)
            $.ajax({
                type:"GET",
                url:"../components/bookservice.cfc",
                data:{
                    method:"removefromcart",
                    id:btn.dataset.id
                },
                dataType: 'json',
                success:function(data){
                    res=JSON.parse(data);
                    if(res.RESULT==true){
                      removedbook=document.querySelector('[data-key='+'"'+btn.dataset.id+'"'+']')
                      removedbook.remove()
                    }
                },
                error:function(data){
                    console.log('error');
                    console.log(data);
                }
            });
        }));
    </script>
</body>
</html>

