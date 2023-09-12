<cffunction  name="registeruser" >
    <cfinvoke component="../components/auth"  method="registeruser" form='#form#'>
</cffunction>

<cfinvoke  method="registeruser">