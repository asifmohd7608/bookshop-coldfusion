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
        
            <cfif len(book) gt 0>
                <cfset session.cart[book.id[1]].productid = book.id[1]>
                <cfset session.cart[book.id[1]].quantity = 1>
                <cfset session.cart[book.id[1]].unitprice = book.Price[1]>
                <cflocation  url="../user/books.cfm?successmsg=Added to Cart">
            <cfelse>
            </cfif>
        <cfcatch type="exception">
        </cfcatch>
        </cftry>
    </cffunction>

<!--- ----------------remove from cart------------------ --->

    <cffunction  name="removefromcart" returnformat="json" access="remote">
        <cfargument  name="id" required="true">
        <cfset structDelete(session.cart, id)>
        <cfset result = {result:true}>
        <cfreturn serializeJSON(result)>
    </cffunction>
</cfcomponent>