<cfcomponent>
    <cffunction  name="fetchbookbyid" >
        <cfargument  name="id" required="true">

        <cfquery name="fetchbookbyid" datasource="cfbookshop">
            select * from books
            where books.id = <cfqueryparam value="#id#" CFSQLType="CF_SQL_INTEGER">
        </cfquery>
        <cfreturn fetchbookbyid>
    </cffunction>

<!---     ---------------------------fetch orders----------------- --->
    <cffunction  name="fetchorders">
        <cfquery name="fetchorders" datasource="cfbookshop">
            select * from purchases
            LEFT JOIN books ON purchases.Book_Id=books.id
            WHERE purchases.Customer_Id	= #session.user.id#
        </cfquery>
        <cfreturn fetchorders>
    </cffunction>
</cfcomponent>