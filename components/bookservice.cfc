<cfcomponent>

<!--- ----------------fetch all books --------------------- --->
    <cffunction  name="fetchAllBooks" >
        <cfquery name="fetchbooks" datasource="cfbookshop">
            select * from books
        </cfquery>
        <cfreturn fetchbooks>

    </cffunction>

<!--- ---------------------add to cart ----------------------- --->
    <cffunction  name="addtocart">
        <cfargument  name="id" required='true' type="string">
<!---         <cfset structDelete(session, 'cart')> --->
        <cfif NOT structKeyExists(session, 'user')>
            <cflocation  url="../user/books.cfm?errormsg=Please login first">
        </cfif>
        <cftry>
            <cfinvoke component="./queries"  method="fetchbookbyid" id="#id#" returnvariable="book">
        
            <cfif len(book) gt 0 >
            <cfif NOT structKeyExists(session, 'cart')>
                <cfset session.cart[book.id[1]].productid = book.id[1]>
                <cfset session.cart[book.id[1]].quantity = 1>
                <cfset session.cart[book.id[1]].unitprice = book.Price[1]>
                <cfset session.cart[book.id[1]].totalprice = book.Price[1]>
                <cflocation  url="../user/books.cfm?successmsg=Added to Cart">
            <cfelseif structKeyExists(session.cart, id)>
                <cflocation  url="../user/books.cfm?errormsg=item is already in cart">
            <cfelse>
                <cfset session.cart[book.id[1]].productid = book.id[1]>
                <cfset session.cart[book.id[1]].quantity = 1>
                <cfset session.cart[book.id[1]].unitprice = book.Price[1]>
                <cfset session.cart[book.id[1]].totalprice = book.Price[1]>
                <cflocation  url="../user/books.cfm?successmsg=Added to Cart">
            </cfif>

            <cfif expression>
            <cfelseif expression>
            <cfelse>
            </cfif>
                
            <cfelse>
                <cflocation  url="../user/books.cfm?errormsg=Item is already in cart">
            </cfif>
        <cfcatch type="exception">
        </cfcatch>
        </cftry>
    </cffunction>

<!--- ----------------remove from cart------------------ --->

    <cffunction  name="removefromcart" returnformat="json" access="remote">
        <cfargument  name="id" required="true">
        <cfset structDelete(session.cart, id)>
        <cfset cartTotal= 0>
        <cfloop collection='#session.cart#' item="key">
            <cfset cartTotal = cartTotal + session.cart['#key#'].totalprice>
        </cfloop>
        <cfset result = {result:true,cartTotal:cartTotal}>
        <cfreturn serializeJSON(result)>
    </cffunction>


<!--- ------------------------increment cart item quantity-------------------- --->
    <cffunction  name="incrementquantity"  returnformat="json" access="remote">
        <cfargument  name="id" required="true">
        <cfinvoke component="./queries" method="fetchbookbyid" id=#id# returnvariable="book">

        <cfset result = {}>

        <cfif len(book) gt 0>
            <cfset reqbook = session.cart['#id#']>
            <cfset reqbook.quantity = reqbook.quantity + 1 >
            <cfset reqbook.totalprice = reqbook.totalprice + book.Price[1] >
            <cfset result = {result:true,quantity:reqbook.quantity,totalprice:reqbook.totalprice}>
            <cfreturn serializeJSON(result)>
        <cfelse>
            <cfset result = {result:true}>
            <cfreturn serializeJSON(result) >
        </cfif>

    </cffunction>

<!--- -------------------------------decrement cart item quantity--------------- --->

    <cffunction  name="decrementquantity"  returnformat="json" access="remote">
        <cfargument  name="id" required="true">
        <cfinvoke component="./queries" method="fetchbookbyid" id=#id# returnvariable="book">

        <cfset result = {}>

        <cfif len(book) gt 0>
            <cfset reqbook = session.cart['#id#']>
            <cfif reqbook.quantity gt 1>
                <cfset reqbook.quantity = reqbook.quantity - 1 >
                <cfset reqbook.totalprice = reqbook.totalprice - book.Price[1] >
                <cfset result = {result:true,quantity:reqbook.quantity,totalprice:reqbook.totalprice}>
                <cfreturn serializeJSON(result)>
            <cfelse>
                <cfset result = {result=false,msg="cant decrement quantity below one"}>
                <cfreturn serializeJSON(result)>
            </cfif>
            
        <cfelse>
            <cfset result = {result:true}>
            <cfreturn serializeJSON(result) >
        </cfif>

    </cffunction>

<!---     -------------------------clear cart----------------- --->

    <cffunction  name="clearcart" access="remote" returnformat="json">
        <cfset  structDelete(session, 'cart')>
        <cfset result = {result:true}>
        <cfreturn serializeJSON(result)>
    </cffunction>

<!--- --------------------------checkout cart--------------------- --->
    <cffunction  name="checkoutcart" access="remote" returnformat="json">
        <cfloop collection="#session.cart#" item="key">
            <cfset reqbook = session.cart['#key#']>
             <cfset couponid = 0>
             <cfset discount = 0>
            <cfif structKeyExists(reqbook, "appliedCoupon")>
                <cfset couponid = reqbook.appliedCoupon.id>
                <cfset discount = reqbook.appliedCoupon.discount>
            </cfif>
            <cftry>
                <cfquery result="checkout" datasource="cfbookshop">
                INSERT INTO purchases(Purchase_Count, Amount, Customer_Id, Book_Id, createdAt, updatedAt, Coupon_Id, Subtotal, Discount_Amount)
                VALUES(#reqbook.quantity#,#reqbook.unitprice#,#session.user.id[1]#,#key#,#Now()#,#Now()#,#couponid#,#reqbook.totalprice#,#discount#)
            </cfquery>
            <cfcatch type="exception">
                <cfdump  var="#exception#">
            </cfcatch>
            </cftry>
        </cfloop>
        <cfset structDelete(session, 'cart')>
        <cflocation  url="../user/myorders.cfm">
<!---         <cfset result = {result:true}> --->
<!---         <cfreturn serializeJSON(result)> --->
    </cffunction>

    <cffunction  name="fetchcoupons" access="remote" returnformat="json">
        <cfargument  name="catid" required="true">
        <cfquery name=fetchcoupons datasource="cfbookshop" returnType="array">
            SELECT * FROM coupons
            WHERE coupons.Coupon_Category=#catid# OR coupons.Coupon_Category="all"
        </cfquery>
        <cfset result = {result:true,data:fetchcoupons}>
        <cfreturn result>
    </cffunction>

<!---     -------------------------apply coupon----------------------- --->

    <cffunction  name="applycoupon" access="remote" returnformat="json">
        <cfargument  name="bookid" required="true">
        <cfargument  name="couponid" required="true">
        <cfset reqbook = session.cart[bookid]>
        <cfset isAnyCouponApplied = false>
        <cfloop collection="#session.cart#" item="key">
            <cfif structKeyExists(session.cart[key], 'appliedCoupon')>
                <cfset isAnyCouponApplied = true>
            </cfif>
        </cfloop>
        <cfif isAnyCouponApplied eq true>
            <cfreturn result={result:false,msg:'Already a coupon is applied to an item in cart'}>
        <cfelse>
            <cfquery name=reqcoupon returnType="array" datasource="cfbookshop">
                SELECT * FROM coupons
                WHERE coupons.id=#couponid#
            </cfquery>
            <cfif reqcoupon[1].Coupon_Type eq "Fixed">
                <cfset reqbook.appliedCoupon = {id:reqcoupon[1].id}>
                <cfset reqbook.totalprice = reqbook.totalprice-reqcoupon[1].Coupon_Offer>
                <cfset cartTotal= 0>
                <cfloop collection='#session.cart#' item="key">
                    <cfset cartTotal = cartTotal + session.cart['#key#'].totalprice >
                </cfloop>
                <cfset discount = (reqbook.quantity * reqbook.unitprice) - reqbook.totalprice>
                <cfset reqbook.appliedCoupon.discount = discount>
                <cfreturn result={result:true,coupon:'fixed',reqbook:reqbook,carttotal:cartTotal,discount:discount}>
            <cfelse>
                <cfset reqbook.appliedCoupon = {id:reqcoupon[1].id}>
                <cfset reqbook.totalprice = reqbook.totalprice-(reqbook.unitprice * (reqcoupon[1].Coupon_Offer/100))>
                <cfset cartTotal= 0>
                <cfloop collection='#session.cart#' item="key">
                    <cfset cartTotal = cartTotal + session.cart['#key#'].totalprice >
                </cfloop>
                <cfset discount = (reqbook.quantity * reqbook.unitprice)-reqbook.totalprice>
                <cfset reqbook.appliedCoupon.discount = discount>
                <cfreturn result={result:true,reqbook:reqbook,carttotal:cartTotal,discount:discount}>
            </cfif>
            
        </cfif>
    </cffunction>
<!--- -----------------------------remove coupon--------------------- --->
    <cffunction  name="removecoupon" access="remote" returnformat="json">
        <cfargument  name="bookid">
        <cfset reqbook = session.cart[bookid]>
           
        <cfif structKeyExists(reqbook, 'appliedCoupon')>
            <cfset couponid = reqbook.appliedCoupon.id>
            <cfquery name=reqcoupon returnType="array" datasource="cfbookshop">
                SELECT * FROM coupons
                WHERE coupons.id=#couponid#
            </cfquery>
            <cfif reqcoupon[1].Coupon_Type eq "Fixed">
                <cfset reqbook.totalprice = reqbook.totalprice + reqcoupon[1].Coupon_Offer> 
                <cfset  structDelete(reqbook, 'appliedCoupon')>
                <cfset cartTotal= 0>
                <cfloop collection='#session.cart#' item="key">
                    <cfset cartTotal = cartTotal + session.cart['#key#'].totalprice>
                </cfloop>
                <cfset discount = (reqbook.quantity * reqbook.unitprice)-reqbook.totalprice>
                <cfreturn result={result:true,reqbook:reqbook,carttotal:cartTotal,discount:discount}>
            <cfelse>
                <cfset reqbook.totalprice = reqbook.totalprice + (reqbook.unitprice * (reqcoupon[1].Coupon_Offer/100))> 
                <cfset  structDelete(reqbook, 'appliedCoupon')>
                <cfset cartTotal= 0>
                <cfloop collection='#session.cart#' item="key">
                    <cfset cartTotal = cartTotal + session.cart['#key#'].totalprice>
                </cfloop>
                <cfset discount = (reqbook.quantity * reqbook.unitprice)-reqbook.totalprice>
                <cfreturn result={result:true,reqbook:reqbook,carttotal:cartTotal,discount:discount}>
            </cfif>
            
        <cfelse>
            <cfreturn result={result:false,msg:"no coupon to remove"}>
        </cfif>
        
    </cffunction>
</cfcomponent>