<cfparam name="url.FuseAction" default="">

<cfparam name="page_filename" default="">

<cfparam name="url.page_id" default="0">

<cfparam name="request.dsn" default="#Application.defDSN#">

<cfparam name="session.admin_high" default="false">

<cfparam name="session.admin_low" default="false">

<cfparam name="session.admin_sandbox" default="false">

<cfparam name="session.admin_training" default="false">

 

<cfif isdefined ('url.pg')><cfset url.prodgroup=url.pg><cfset url.label="Blog"><cfset url.IsBlog = 1></cfif>

<cfif isdefined ('url.fa')><cfset url.fuseaction=url.fa></cfif>

 

<cfset variable.txtComponent = "">

<cfif isdefined ('url.m')>

    <cfinvoke component="get_PageInfo" method="getMenuInfo" returnvariable="MenuInfo">

        <cfinvokeargument name="defDSN" value="#request.dsn#">

        <cfinvokeargument name="MenuID" value="#url.m#">

    </cfinvoke>

   

    <cfset url.page_id = MenuInfo.page_id>

    <cfset url.label = MenuInfo.menu_item_label>

    <cfset url.menu_id = url.m>

    <cfif len(trim(MenuInfo.application_name)) and (MenuInfo.application_name neq 0)><cfset url.prodgroup = MenuInfo.application_name></cfif>

    <cfif len(trim(MenuInfo.fuse_action))><cfset url.FuseAction = MenuInfo.fuse_action></cfif>

    <cfif len(trim(MenuInfo.custpage))><cfset url.custpage = MenuInfo.custpage></cfif>

    <cfif (MenuInfo.access_level eq 1 and not session.admin_high)>

        <cflocation url="index.cfm?prodgroup=cf_register&FuseAction=Login&Msg=You must be an admin user to view this page.&Label=Login / Register" addtoken="no">

    <cfelseif (MenuInfo.access_level eq 2 and not session.registereduser)>

        <cflocation url="index.cfm?prodgroup=cf_register&FuseAction=Login&Msg=You must be logged in to view this page.&Label=Login / Register" addtoken="no">

    </cfif>

</cfif>

<cfif IsDefined ('url.spage_id')>

    <cfinvoke component="get_PageInfo" method="getSandPageInfo" returnvariable="PageInfo">

        <cfinvokeargument name="defDSN" value="#request.dsn#">

        <cfinvokeargument name="Page_id" value="#url.spage_id#">

    </cfinvoke>

   

    <cfset page_type = PageInfo.page_type>

    <cfif IsDefined ('PageInfo.fuseaction')><cfset url.fuseaction = PageInfo.fuseaction></cfif>

    <cfif IsDefined ('PageInfo.prodgroup')><cfset url.prodgroup = PageInfo.prodgroup></cfif>

    <cfif IsDefined ('PageInfo.custpage')><cfset url.custpage = PageInfo.custpage></cfif>

    <cfif IsDefined ('PageInfo.Page_Content')><cfset GetPageInfo.Page_Content = PageInfo.Page_Content></cfif>

<cfelseif not isdefined('url.prodgroup') and not isdefined('url.custpage') and not len(trim(url.fuseaction))>

    <cfif isdefined ('url.lp') or isdefined ('url.wm')>

        <cftry>

            <cfinvoke component="get_PageInfo" method="getPageInfoNoMenu" returnvariable="PageInfo">

                <cfinvokeargument name="defDSN" value="#request.dsn#">

                <cfinvokeargument name="Page_id" value="#url.page_id#">

            </cfinvoke>

           

        <cfcatch type="any">

            <cflocation url="index.cfm" addtoken="no">

        </cfcatch>

        </cftry>

    <cfelse>

        <cftry>

            <cfinvoke component="get_PageInfo" method="getPageInfo" returnvariable="PageInfo">

                <cfinvokeargument name="defDSN" value="#request.dsn#">

                <cfinvokeargument name="Page_id" value="#url.page_id#">

            </cfinvoke>

        <cfcatch type="any">

            <cflocation url="index.cfm" addtoken="no">

        </cfcatch>

        </cftry>

    </cfif>

   

    <cfset page_type = PageInfo.page_type>

    <cfif IsDefined ('PageInfo.fuseaction')><cfset url.fuseaction = PageInfo.fuseaction></cfif>

    <cfif IsDefined ('PageInfo.prodgroup')><cfset url.prodgroup = PageInfo.prodgroup></cfif>

    <cfif IsDefined ('PageInfo.custpage')><cfset url.custpage = PageInfo.custpage></cfif>

    <cfif IsDefined ('PageInfo.Page_Content')><cfset GetPageInfo.Page_Content = PageInfo.Page_Content></cfif>

<cfelse>

    <cfset page_type = 'include'>

</cfif>

 

<cfif isdefined ('url.pg')><cfset url.prodgroup=url.pg></cfif>

<cfif isdefined ('url.fa')><cfset url.fuseaction=url.fa></cfif>

<cfif isdefined ('url.prodgroup') and len(trim(url.prodgroup))>

    <cftry>

        <cfinclude template="addins/#url.prodgroup#/actions.cfm">

        <cfcatch type="any">

            <!---  <cfdump var="#cfcatch#"><cfabort> --->      

            <cflocation url="index.cfm" addtoken="no">

        </cfcatch>

    </cftry>

<cfelseif isdefined ('url.custpage')>

    <cfset include_template = "custom/SystemFiles/CustomPages/#url.custpage#">

    <cfif not FileExists (ExpandPath ("custom/SystemFiles/CustomPages/#url.custpage#"))>

        <cfinvoke component="get_PageInfo" method="getPageInfo" returnvariable="PageInfo">

            <cfinvokeargument name="defDSN" value="#request.dsn#">

        </cfinvoke>

       

        <cfset page_type = PageInfo.page_type>

        <cfif IsDefined ('PageInfo.fuseaction')><cfset url.fuseaction = PageInfo.fuseaction></cfif>

        <cfif IsDefined ('PageInfo.prodgroup')><cfset url.prodgroup = PageInfo.prodgroup></cfif>

        <cfif IsDefined ('PageInfo.custpage')><cfset url.custpage = PageInfo.custpage></cfif>

        <cfif IsDefined ('PageInfo.Page_Content')><cfset GetPageInfo.Page_Content = PageInfo.Page_Content></cfif>

    </cfif>

<cfelse>

 

    <cfswitch expression="#url.FuseAction#">

        <cfcase value="GoHome">

            <cflocation url="../cf_#Session.FuseApp#/index.cfm?FuseAction=#Session.ReferAction#" addtoken="No">

        </cfcase>

        <cfcase value="PrintToPDF">

            <cfinclude template="dsp_PrintToPDF.cfm">

        </cfcase>

        <cfcase value="manage_bookmarks">

            <cfset include_template = "common/dsp_bookmarks.cfm">

        </cfcase>

        <cfcase value="SearchAll">

            <cfset include_template = "dsp_SearchAll.cfm">

        </cfcase>

        <cfcase value="websiteBuilder">

            <cfset variable.txtComponent = "Ad CMS">

            <cfif session.Admin_High or session.admin_sandbox>

                <!--- <cflocation url="site_builder/dashboard_manager.cfm" addtoken="no"> --->

                <cflocation url="site_builder/index.cfm" addtoken="no">

            <cfelse>

                <cfset include_template = "dsp_NotAdmin.cfm">

            </cfif>

        </cfcase>

        <cfcase value="SiteMap">

            <cfset include_template = "inc/site_map.cfm">

        </cfcase>

 

        <cfcase value="GettingStarted">

           <cfif session.Admin_High or (session.Admin_Low and session.admin_training eq 1)>

              <cfset include_template = "dsp_GettingStarted.cfm">

            <cfelse>

                <cfset include_template = "dsp_NotAdmin.cfm">

           </cfif>

        </cfcase>

        <cfcase value="NotLoggedIn">

           <cfset include_template = "dsp_NotLoggedIn.cfm">

        </cfcase>

        <cfcase value="myworkdashboard">

            <cfset include_template = "inc/dsp_wm_dashboard.cfm">

        </cfcase>

        <cfcase value="adr_settings">

            <cfset include_template = "inc/dsp_adr_settings.cfm">

        </cfcase>

        <cfcase value="LaunchAdCMS">

            <cfset session.bsblive = 0>

            <cfset variable.txtComponent = "Ad CMS">

            <cfset include_template = "site_builder/dsp_launch_adcms.cfm">

        </cfcase>

        <cfcase value="LaunchAdTeams">

            <cfset session.bsblive = 1>

            <cfset variable.txtComponent = "Ad Teams">

            <cfset include_template = "addins/cf_register/dsp_launch_adteams.cfm">

        </cfcase>

        <cfcase value="StaticPage">

            <cfset include_template = "#url.cp#">

        </cfcase>

        <cfcase value="UpdateSite">

            <cfset include_template = "updateadreflexsite.cfm">

        </cfcase>

   

        <cfcase value="EmailFormSubmit">

            <cfset include_template = "addins/cf_form/prc_custom_email_form.cfm">

        </cfcase>

       

        <!--- <cfdefaultcase>

            <cfset include_template = "addins/cf_register/actions.cfm">

            <cfset page_type = "include">

        </cfdefaultcase> --->

    </cfswitch>

</cfif>

 

<cfif len(trim(variable.txtComponent))>

    <script type="text/javascript">

        $(document).ready(function ()

        {

            if ($('.AdrRepIssue').length)

            {

                var oldRef = $('.AdrRepIssue').attr('href');

                if (oldRef.indexOf('engtxt') == -1)

                {

                    var engId = '<cfoutput>#variable.txtComponent#</cfoutput>';

                    $('.AdrRepIssue').attr('href', oldRef + '&engtxt='+engId);

                }

            }

        });

    </script>

</cfif>

 

<cfif not isdefined('include_template') AND (page_type NEQ "dynamic")> <!--- get default home page --->

    <cfinvoke component="get_PageInfo" method="getPageInfo" returnvariable="PageInfo">

        <cfinvokeargument name="defDSN" value="#request.dsn#">

    </cfinvoke>

 

    <cfset page_type = PageInfo.page_type>

    <cfif IsDefined ('PageInfo.fuseaction')><cfset url.fuseaction = PageInfo.fuseaction></cfif>

    <cfif IsDefined ('PageInfo.prodgroup')><cfset url.prodgroup = PageInfo.prodgroup></cfif>

    <cfif IsDefined ('PageInfo.custpage')><cfset url.custpage = PageInfo.custpage></cfif>

    <cfif IsDefined ('PageInfo.Page_Content')><cfset GetPageInfo.Page_Content = PageInfo.Page_Content></cfif>

</cfif>

has context menu