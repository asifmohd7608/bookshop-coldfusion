<cffunction  name="addtocart">
    <cfif structKeyExists(url, 'id')>
        <cfinvoke component="../components/bookservice"  method="addtocart" id="#url.id#">
    <cfelse>
        <cflocation  url="../user/books.cfm?errormsg=unable to add that book to cart">
    </cfif>
    
</cffunction>

<cfinvoke  method="addtocart">