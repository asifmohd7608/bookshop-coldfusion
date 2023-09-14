<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top z-high">
  <a class="navbar-brand" href="../index.cfm">Bookshop</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <cfoutput>
    <div class="collapse navbar-collapse " id="navbarNav">
        <ul class="navbar-nav ">
          <cfif structKeyExists(session, 'user')>
            <li class="nav-item">
              <a class="nav-link text-mediumgray" href="http://bookshop.local/user/books.cfm">Books</a>
            </li>
          </cfif>
        </ul>
        <cfif Not structKeyExists(session, 'user')>
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link text-mediumgray" href="http://bookshop.local/user/login.cfm">Login</a>
            </li>
          </ul>
        </cfif>
        <cfif structKeyExists(session, 'user')>
<!---         -------------------user menu dropdown---------------------- --->
            <div class="dropdown mr-1 ml-auto align-self-center d-none d-lg-block">
              <div type="button" class="bg-dark dropdown-toggle text-mediumgray h6 mt-auto user-select-none" data-toggle="dropdown" aria-expanded="false" data-offset="10,20">
                #ucFirst(session.user.First_Name,true,false)#
              </div>
              <div class="dropdown-menu dropdown-menu-right bg-dark mt-4 rounded-md  overflow-hidden">
                <a class="dropdown-item text-white" href="../user/cart.cfm">cart</a>
                <a class="dropdown-item text-white" href="http://bookshop.local/user/myorders.cfm">My orders</a>
                <a class="dropdown-item text-white" href="../functions/logout.cfm">Logout</a>
              </div>
            </div>
<!---             -----------------user menu collapse----------------- --->
              <div class="bg-dark text-mediumgray d-lg-none user-select-none" type="button" data-toggle="collapse"        data-target='##collapseExample' aria-expanded="false" aria-controls="collapseExample">
                  #ucFirst(session.user.First_Name,true,false)#
              </div>
              <div class="collapse" id="collapseExample">
                <a href="../functions/logout.cfm" class="nav-link text-mediumgray">Logout</a>
              </div>
        </cfif>
    </div>
  </cfoutput>
</nav>