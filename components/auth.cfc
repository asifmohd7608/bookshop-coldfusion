<cfcomponent>

    <cffunction  name="loginuser" >
        <cfargument  name="form" type="struct" required="true">
        <cftry>
            <cfquery name='loginuser' datasource="cfbookshop">
                select * from users
                where users.Email = <cfqueryparam value='#form.username#' CFSQLType="CF_SQL_LONGNVARCHAR"> 
            </cfquery>
            <cfif len(loginuser) gt 0>
                <cfif loginuser.Email[1] eq form.username AND loginuser.Password[1] eq form.password>
                    <cfset session.user = loginuser>
                    <cflocation  url="../user/books.cfm">
                <cfelse>
                    <cflocation  url="../user/login.cfm?errormsg=Username or Password is incorrect">
                </cfif>
            <cfelse>
            <cflocation  url="../user/login.cfm?errormsg=Account doesnt exist" addToken="false">
            </cfif> 


            
        <cfcatch type="exception">
            <cflocation  url="../pages/login.cfm">
        </cfcatch>
        </cftry> 
   

        
            
    </cffunction>

<!--- --------------------------register user -------------------- --->
    <cffunction  name="registeruser">
        <cfargument  name="form" required="true" type="struct">
        <cfset errors = structNew()>
        <cfif isStruct(form)>
            <cfloop list="#form.fieldnames#" item="item">
                <cfif len(form[item]) lt 1 AND item neq 'signup' >
                <cfset errors[item] = 'empty'>      
                </cfif>
            </cfloop>
            <cfif structIsEmpty(errors)>
                <cfset Email = form.username>
                <cfset First_Name = #form['firstname']#>
                <cfset Last_Name = form.lastname>
                <cfset Address_line1 = form.addressline1>
                <cfset Address_line2 = form.addressline2>
                <cfset Address_line3 = form.addressline3>
                <cfset City = form.city>
                <cfset Mobile = form.mobile>
                <cfset Password = form.password>
                <cftry>
                    <cfquery result="registeruser" datasource='cfbookshop'>
                        INSERT INTO users(Email, First_Name, Last_Name, Address_line1, Address_line2, Address_line3, City, Mobile, Profile_Pic, Password, role, access_token)
                        VALUES (<cfqueryparam value="#Email#" CFSQLType="CF_SQL_LONGNVARCHAR">, <cfqueryparam value="#First_Name#" CFSQLType="CF_SQL_LONGNVARCHAR">, <cfqueryparam value="#Last_Name#" CFSQLType="CF_SQL_LONGNVARCHAR">, <cfqueryparam value="#Address_line1#" CFSQLType="CF_SQL_VARCHAR">, <cfqueryparam value="#Address_line2#" CFSQLType="CF_SQL_VARCHAR">, <cfqueryparam value="#Address_line3#" CFSQLType="CF_SQL_VARCHAR">, <cfqueryparam value="#City#" CFSQLType="CF_SQL_LONGNVARCHAR">, <cfqueryparam value="#Mobile#" CFSQLType="CF_SQL_BIGINT">, <cfqueryparam value="" CFSQLType="CF_SQL_VARCHAR">, <cfqueryparam value="#Password#" CFSQLType="CF_SQL_LONGNVARCHAR">, 'user', '')
                    </cfquery>
                    <cflocation  url="../user/login.cfm">
                
                <cfcatch type="exception">
                    <cfdump  var="#exception#">
                </cfcatch>
                </cftry>
                
            </cfif>
        </cfif>
    </cffunction>


<!---     -------------------------logout user ------------------ --->

    <cffunction  name="logoutuser">
        <cfif structKeyExists(session, 'user')>
            <cfset structDelete(session, 'user')>
            <cflocation  url="../user/login.cfm">
        <cfelse>
            <cflocation  url="../user/books.cfm">
        </cfif>
    </cffunction>
</cfcomponent>