<cfcomponent>
    <cffunction  name="fetchbookbyid" >
        <cfargument  name="id" required="true">

        <cfquery name="fetchbookbyid" datasource="cfbookshop">
            select * from books
            where books.id = <cfqueryparam value="#id#" CFSQLType="CF_SQL_INTEGER">
        </cfquery>
        <cfreturn fetchbookbyid>
    </cffunction>
</cfcomponent>