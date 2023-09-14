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
        <cfset carttotal = 0>

    <!--- ------------------messages------------------- --->
        <cfif structKeyExists(url, 'errormsg')>
            <p class="text-danger text-center">#url.errormsg#</p>
        </cfif>
        <cfif structKeyExists(url, 'successmsg')>
            <p class="text-success text-center">#url.successmsg#</p>
        </cfif>
    <!--- ---------------------------------------------- --->
        <cfif structKeyExists(session, 'cart') AND structCount(session.cart) gt 0>
            <div class="d-none d-lg-flex mx-1 p-3 my-4 rounded-md shadow-md text-center row  flex-nowrap sticky-top bg-white top-4" id="labels">
                <div class="col-md-1">Cover</div>
                <div class="col-md-3">Title</div>
                <div class="col">Unit Price</div>
                <div class="col">Quantity</div>
                <div class="col">Discount</div>
                <div class="col">Total Price</div>
                <div class="col">Option</div>
                <div class="col">Remove</div>
            </div>
            <cfloop collection="#session.cart#" item="key">
            <cfset carttotal = carttotal + session.cart['#key#'].totalprice>
                <cfinvoke component="../components/queries"  method="fetchbookbyid" id="#key#" returnvariable="book">
                <div class="card mb-3  p-3 rounded-md shadow-md text-center cartitem" data-key="#book.id#" >
                    <div class="row no-gutters align-items-baseline">
                        <div class="col-md-1">
                            <img src="../media/#book.File_Path#" alt="book cover" style="object-fit:cover" class="img-fluid w-5 h-8 rounded-md">
                        </div>
                        <div class="col-md-3">
                            <div class="card-body">
                                <h5 class="card-title">#ucFirst(book.Book_Title)#</h5>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row align-items-baseline text-center ">
                                <div class="col-12 col-sm-4 col-md-2">Rs #book.Price#</div>
                                <div class="col-12 col-sm-4 col-md-2 d-flex justify-content-center" data-bookid=#book.id#>
                                    <btn class="btn btn-danger btn-sm mr-2  font-weight-bold" onClick="modifyItem(#book.id#,'decrementquantity')">
                                    -
                                    </btn>
                                    <span id="quantity-#book.id#">#session.cart[book.id].quantity#</span>
                                    <btn class="btn btn-success btn-sm ml-2  font-weight-bold addbtn" onClick="modifyItem(#book.id#,'incrementquantity')">
                                    +
                                    </btn>
                                </div>
                                <div class="col-12 col-sm-4 col-md-2">Discount</div>
                                <div class="col-12 col-sm-4 col-md-2" >
                                   Rs <span id="totalprice-#book.id#">#session.cart[book.id].totalprice#</span>
                                </div>
                                <div class="col-12 col-sm-4 col-md-2">Delete</div>
                                <btn class="col-12 col-sm-4 col-md-2 removebtn btn btn-sm mw-fit btn-danger ml-auto mr-auto" onClick="removeItem(#book.id#)"  data-id=#book.id#>
                                    Remove
                                </btn>
                            </div>
                        </div>
                    </div>
                </div>
            </cfloop>
            <div id="cartActions">
                <p class="text-center font-weight-bold h5 mt-3">Total Cart Value : <span id="carttotal">#carttotal#</span></p>
                <div class="d-flex justify-content-center my-3 " >
                    <btn class="btn btn-danger mr-4" onClick="clearCart()">Clear Cart</btn>
                    <btn class="btn btn-success" ><a class="text-white" href="../components/bookservice.cfc?method=checkoutcart">Checkout</a></btn>
                </div>
            </div>
            
        <cfelse>
            <p class="font-weight-bold text-dark text-center mt-10 h1" >Your cart is empty</p>
        </cfif>
    </div>
    </cfoutput>


    <script>
        let removebtns = document.querySelectorAll(".removebtn");
        let addbtns=document.querySelectorAll(".addbtn")

        modifyItem=(cartItemId,action)=>{
            $.ajax({
                type:"GET",
                url:"../components/bookservice.cfc",
                data:{
                    method:action,
                    id:cartItemId
                },
                dataType:'json',
                success:(res)=>{
                    const result=JSON.parse(res);
                    if(result.RESULT){
                       let totalPriceEl=document.getElementById('totalprice-'+cartItemId);
                       let quantityEl=document.getElementById('quantity-'+cartItemId);
                        let cartTotalEl=document.getElementById("carttotal");

                        cartTotalEl.innerHTML=parseInt(cartTotalEl.innerHTML) + (result.TOTALPRICE-(parseInt(totalPriceEl.innerHTML)));
                        totalPriceEl.innerHTML=result.TOTALPRICE;
                        quantityEl.innerHTML=result.QUANTITY;
                    }
                },
                error:(res)=>{
                    console.log(res)
                }
            })
        }

        removeItem=(cartItemId)=>{
            $.ajax({
                type:"GET",
                url:"../components/bookservice.cfc",
                data:{
                    method:"removefromcart",
                    id:cartItemId
                },
                dataType: 'json',
                success:function(data){
                    res=JSON.parse(data);
                    if(res.RESULT==true){
                      removedbook=document.querySelector('[data-key='+'"'+cartItemId+'"'+']')
                       let cartTotalEl=document.getElementById("carttotal");
                       cartTotalEl.innerHTML=res.CARTTOTAL
                      removedbook.remove()
                    }
                },
                error:function(data){
                    console.log('error');
                    console.log(data);
                }
            });
        };

        let clearCart=()=>{
            $.ajax({
                type:"GET",
                url:"../components/bookservice.cfc",
                dataType:'json',
                data:{
                    method:"clearcart",
                },
                success:(res)=>{
                    let result=JSON.parse(res);
                    if(result.RESULT){
                        let labels=document.getElementById('labels');
                        let cartItems=document.querySelectorAll('.cartitem');
                        let cartTotal=document.getElementById("carttotal");
                        let cartActions=document.getElementById("cartActions");
                        labels.remove();
                        cartActions.remove();
                        cartItems.forEach(item=>{
                            item.remove();
                        })
                    }
                }
            })
        }


        // let checkoutcart=()=>{
        //     $.ajax({
        //         type:"GET",
        //         url:"../components/bookservice.cfc",
        //         dataType:'json',
        //         data:{
        //             method:"checkoutcart",
        //         },
        //         success:(res)=>{
        //             let result=JSON.parse(res);
        //             if(result.RESULT){
        //                 let labels=document.getElementById('labels');
        //                 let cartItems=document.querySelectorAll('.cartitem');
        //                 let cartTotal=document.getElementById("carttotal");
        //                 let cartActions=document.getElementById("cartActions");
        //                 labels.remove();
        //                 cartActions.remove();
        //                 cartItems.forEach(item=>{
        //                     item.remove();
        //                 })
        //                 window.location.href="http://bookshop.local/user/myorders.cfm"
        //             }
        //         }
        //     })
        // }
    </script>
</body>
</html>

