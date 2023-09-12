<cfcomponent>


    <cffunction  name="fetchAllBooks" >
        <cfquery name="fetchbooks" datasource="cfbookshop">
            select * from books
        </cfquery>
        <cfreturn fetchbooks>

    </cffunction>
</cfcomponent>