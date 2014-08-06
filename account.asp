<% Option Explicit %>
<%

	'
	' @(#): account.asp
	'
	' Inserts or updates the 'account' table and redirects
	' user to a 'thank you for registering' or 'organize.asp'
	' page.
	'
	
	Dim errorMessage, actionType, pageState
	errorMessage = ""
	
	Dim oDB, oRS, mSQL
	Dim firstname, surname, country, gender, email, username, password, retypePassword
	gender = -1
	
	username = Request.QueryString("username")
	password = Request.QueryString("password")
	
	actionType = Request.Form("actionType")
	If ( (StrComp(actionType, "create") = 0) OR (StrComp(actionType, "update") = 0) ) Then
		' create or update account -> validate information
		pageState = actionType
		
		firstname = Request.Form("ediFirstname")
		surname = Request.Form("ediSurname")
		country = Request.Form("ediCountry")
		gender = Request.Form("cmbGender")
		email = Request.Form("ediEmail")
		username = Request.Form("ediUsername")
		password = Request.Form("ediPassword")
		retypePassword = Request.Form("ediRetypePassword")
		
		If ( errorMessage = "" ) AND ( Len(email) = 0 ) Then
			errorMessage = "Please type your email-address."
		End If
		
		If ( errorMessage = "" ) AND ( Len(username) = 0 ) Then
			errorMessage = "Please type a username for your account."
		End If
		
		If ( errorMessage = "" ) AND ( Len(password) = 0 ) Then
			errorMessage = "Please type a password for your account."
		End If
		
		If ( errorMessage = "" ) AND (StrComp(password, retypepassword, 1) <> 0) Then
			errorMessage = "Passwords do not match."
		End If
		
		If (errorMessage = "") Then
		
			Set oDB = Server.CreateObject("ADODB.Connection")
			oDB.Open(Application("conquermarks_ConnectionString"))
			
			Set oRS = oDB.Execute("SELECT id FROM account WHERE username = '" & Replace(username, "'", "''") & "'")
			If ( NOT oRS.EOF ) Then
				If (oRS(0) <> Session("conquermarks_id")) Then
					' user should NOT be able to create nor update his account
					' to use a username already in use.
					oRS.Close
					Set oRS = Nothing
					errorMessage = "Username is already in use. Please choose another one."
				End If
			Else
				' replace ' with ''
				firstname = Replace(firstname, "'", "''")
				surname = Replace(surname, "'", "''")
				country = Replace(country, "'", "''")
				email = Replace(email, "'", "''")
				username = Replace(username, "'", "''")
				password = Replace(password, "'", "''")
				
				' validate info for safe(r) insertion into database
				If ( Len(firstname) = 0 ) Then
					firstname = "NULL"
				Else
					firstname = "'" & firstname & "'"
				End If
				
				If ( Len(surname) = 0 ) Then
					surname = "NULL"
				Else
					surname = "'" & surname & "'"
				End If
				
				If ( Len(country) = 0 ) Then
					country = "NULL"
				Else
					country = "'" & country & "'"
				End If
				
				email = "'" & email & "'"
				username = "'" & username & "'"
				password = "'" & password & "'"
				
				If (StrComp(pageState, "create") = 0) Then
					' user wants to create a new account
					pageState = "create"
					
					' open database, insert info, close database
					
					mSQL = "INSERT INTO	account " & _
							"(firstname, surname, country, gender, email, username, password) " & _
							"VALUES (	" & _
											firstname & ", " & _
										surname & ", " & _
										country & ", " & _
										gender & ", " & _
										email & ", " & _
										username & ", " & _
											password & _
									");"
					
					oDB.Execute(mSQL)
					
					oDB.Close
					Set oDB = Nothing
					
					Response.Redirect("account_created.asp?username=" & Request.Form("ediUsername") & "&password=" & Request.Form("ediPassword"))
					
				End If ' // > If (StrComp(pageState, "create") = 0) Then
				
				If (StrComp(actionType, "update") = 0) Then
					' user wants to update profile
					pageState = "update"
					
					If (Session("conquermarks_id") = "") Then
						Response.Redirect("default.asp")
					End If
					
					' open database, insert info, close database
					
					mSQL = "UPDATE	account " & _
							"SET		firstname = " & firstname & ", " & _
							"			surname = " & surname & ", " & _
							"			country = " & country & ", " & _
							"			gender = " & gender & ", " & _
							"			email = " & email & ", " & _
							"			username = " & username & ", " & _
							"			password = " & password & " " & _
							"WHERE		id = " & Session("conquermarks_id") & ";"
					
					oDB.Execute(mSQL)
					
					oDB.Close
					Set oDB = nothing
					
					Response.Redirect("organize.asp")
					
				End If ' // > If (StrComp(pageState, "update") = 0) Then
				
			End If ' // > Else ... If ( NOT oRS.EOF ) Then
			
		End If ' // > If (errorMessage <> "") Then
		
	Else ' // > If ( (StrComp(actionType, "create") = 0) OR (StrComp(actionType, "update") = 0) ) Then
		pageState = "create"
	End If 
		
	If (Request.QueryString("update") <> "") Then
		pageState = "update"
		
		Set oDB = Server.CreateObject("ADODB.Connection")
		oDB.Open(Application("conquermarks_ConnectionString"))
		
		mSQL = "SELECT	firstname, surname, country, gender, email, username, password " & _
				"FROM		account " & _
				"WHERE		id = " & Session("conquermarks_id") & ";"
		
		Set oRS = oDB.Execute(mSQL)
		
		If (NOT oRS.EOF) Then
			firstname = oRS(0)
			surname = oRS(1)
			country = oRS(2)
			gender = oRS(3)
			email = oRS(4)
			username = oRS(5)
			password = oRS(6)
		End If
		
		retypePassword = password
		
		oRS.Close
		Set oRS = Nothing
		
		oDB.Close
		Set oDB = Nothing
		
	End If ' // > If (Request.QueryString("id") <> "") Then
	
%>
<html>

<head>
 <title>conquermarks @ theill.com</title>
 <link rel="stylesheet" type="text/css" href="default.css">
</head>

<body background="images/backline.gif" topmargin=2 leftmargin="0" marginwidth=0 marginheight=2>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
      <td width="50%">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr>
            <td width="100%"><img border="0" src="images/dot.gif" width="1" height="31"></td>
          </tr>
          <tr>
            <td width="100%" bgcolor="#FFFFFF"><img border="0" src="images/dot.gif" width="1" height="19"></td>
          </tr>
        </table>
      </td>
      <td align=center><a href="default.asp"><img border="0" src="images/header_conquermarks.gif" alt="ConquerMarks 1.0"></a></td>
      <td width="50%">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr>
            <td width="100%"><img border="0" src="images/dot.gif" width="1" height="31"></td>
          </tr>
          <tr>
            <td width="100%" bgcolor="#FFFFFF"><img border="0" src="images/dot.gif" width="1" height="19"></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
      <td width="50%" bgcolor="#FFFFFF">
        <p><img border="0" src="images/dot.gif" width="1" height="31">
      </td>
      <td align=center width="580" height="50"><table border="0" width="580" cellspacing="0" cellpadding="0">
  <tr align="top">
    <td bgcolor="#ffffff" valign="top"><table border="0" cellspacing="0" cellpadding="4" width="100%">
      <tr>
        <td valign="top" height="100%">
        <!--webbot bot="Include" U-Include="__menu.asp" TAG="BODY" startspan
        -->
 <script language="JavaScript">
 	function openCompactMode()
 	{
 		var m_compact
 		m_compact = window.open('compact.html', m_compact, 'toolbar=no,width=180,height=450,resizable=1');
		m_compact.focus();
 	}
 	
 </script> 

 <div align="center"><center>

<form name="LoginForm" method="POST" action="default.asp">
<table border="0" cellspacing="0" cellpadding="4" bgcolor="#E7E7E7" background="images/white_stripe.gif" height="100%">
  <tr>
    <td valign="top" class="IndexTable">

		<% If (Session("conquermarks_id") = "") Then %>
		<table border="0" width="112" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center" colspan="2"><img border="0" src="images/login_menu.gif" WIDTH="112" HEIGHT="16" alt="login"></td>
        </tr>
        <tr>
          <td class="BottomNote" colspan="2"><img border="0" src="images/dot.gif" width="112" height="2"></td>
        <tr>
          <td class="BottomNote"><b>&nbsp;user</b></td>
          <td align="right"><input type="text" name="username" size="10" style="font-family: none; font-size: 9pt"></td>
        </tr>
        <tr>
          <td class="BottomNote"><b>&nbsp;pass</b></td>
          <td align="right"><input type="password" name="password" size="10" style="font-family: none; font-size: 9pt"></td>
        </tr>
        <tr>
          <td align="center" colspan="2"><img border="0" src="images/dot.gif" width="112" height="2"></td>
        </tr>
        <tr>
          <td><img border="0" src="images/dot.gif" width="2" height="2"></td>
          <td align="right"><input type="submit" name="login" value="enter" class="LoginButton"></td>
        </tr>
        </table>
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td width="100%"><img border="0" src="images/dot.gif" width="12" height="12"></td>
        </tr>
      </table>
      <% End If %>
		
		<% If (Session("conquermarks_id") <> "") Then %>
      <table border="0" width="112" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100%" align="center"><img border="0" src="images/organize_menu.gif" WIDTH="112" HEIGHT="16" alt="organize"></td>
        </tr>
        <tr>
          <td>
          <p class="BottomNote">&nbsp;&nbsp;<a href="organize.asp">hierarchy</a><br>
          &nbsp; <a href="folder.asp">add folder</a><br>
          &nbsp;&nbsp;<a href="favorite.asp">add favorite</a></p>
          </td>
      </table>
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td width="100%"><img border="0" src="images/dot.gif" width="12" height="12"></td>
        </tr>
      </table>
      <% End If %>
      
		<% If (Session("conquermarks_id") <> "") Then %>
      <table border="0" width="112" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100%" align="center"><img border="0" src="images/account_menu3.gif" alt="account" width="112" height="16"></td>
        </tr>
        <tr>
          <td>
          <p class="BottomNote">&nbsp;&nbsp;<a href="account.asp?update=yes">profile</a>
          </td>
      </table>
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td width="100%"><img border="0" src="images/dot.gif" width="12" height="12"></td>
        </tr>
      </table>
      <% End If %>

      <table border="0" width="112" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100%" align="center"><img border="0" src="images/general_menu.gif" WIDTH="112" HEIGHT="16" alt="general"></td>
        </tr>
        <tr>
          <td>
          <p class="BottomNote">
		<% If (Session("conquermarks_id") = "") Then %>
          &nbsp; <a href="account.asp">create account</a><br>
          &nbsp; <br>
       <% End If %>
          &nbsp; <a href="help.asp">help</a><br>
          &nbsp; <a href="legends.asp">legends</a><br>
          &nbsp; <a href="history.asp">history</a><br>
		<% If (Session("conquermarks_id") <> "") Then %>
          &nbsp; <a href="logout.asp">logout</a><br>
          &nbsp; <br>
          &nbsp; <a href="javascript:openCompactMode()">compact</a>
      <% End If %>
          </td>
      </table>
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td width="100%"><img border="0" src="images/dot.gif" width="12" height="12"></td>
        </tr>
      </table>

	<table border="0" width="112" cellspacing="0" cellpadding="1">
      <tr>
        <td align="center" height="100%"><img border="0" src="images/dot.gif" width="16" height="100"></td>
      </tr>
      <tr>
        <td align="center"><span style="font-family: verdana, sans-serif; font-size: 7.5pt; font-weight: bold;">experience with</span></td>
      </tr>
      <tr>
        <td align="center"><a HREF="http://www.microsoft.com/ie/logo.asp"><img SRC="images/ie_logo.gif" BORDER="0" ALT="Download Internet Explorer" width="88" height="31"></a></td>
      </tr>
      <tr>
        <td align="center"><img border="0" src="images/dot.gif" width="16" height="16"></td>
      </tr>
    </table>
	
    </td>
  </tr>
</table>
</form>
</center></div>
<!--webbot bot="Include" endspan i-checksum="37330"
        -->

        </td>
        <td width="100%" valign="top" align="justify">
          <p class="Caption"><strong><%= pageState %></strong>    account...</p>
			
			<p class="Error"><%= errorMessage %></p>
			
          <p> To set
up your ConquerMarks account properly, we need some information from you. Please fill fields below;
fields marked with a&nbsp;<img border="0" src="images/goldstar.gif" align="absbottom" alt="mandatory" width="15" height="15">&nbsp;are mandatory (required).</p>

<form action="account.asp" method="POST">
<input type="hidden" name="actionType" value="<%= pageState %>">
  <div align="center"><center><table border="0" cellspacing="0" cellpadding="4" width="50" height="50">
    <tr>
      <td width="10" bgcolor="#848284"><font color="#FFFFFF"><img border="0" src="images/dot.gif" width="8" height="16"></font></td>
      <td width="100%" bgcolor="#848284"><p><strong><font color="#FFFFFF">Account
        Information</font></strong></td>
      <td width="10" bgcolor="#848284"><font color="#FFFFFF"><img border="0" src="images/dot.gif" width="8" height="16"></font></td>
    </tr>
    <tr>
      <td width="10"><font color="#FFFFFF"><img border="0" src="images/dot.gif" width="8" height="16"></font></td>
      <td width="100%">
      

      <table border="0" cellspacing="0" cellpadding="2" width="100%">
        <tr>
          <td width="100%" nowrap><p>Firstname<img src="images/dot.gif" WIDTH="4" HEIGHT="4" border="0"></td>
          <td style="font-family: none;"><input name="ediFirstname" size="20" value="<%= firstname %>"></td>
          <td nowrap><img border="0" src="images/dot.gif" width="10" height="10"></td>
        </tr>
        <tr>
          <td width="100%" bgcolor="#F0F0F0" nowrap><p>Surname<img src="images/dot.gif" WIDTH="4" HEIGHT="4" border="0"></td>
          <td style="font-family: none;" bgcolor="#F0F0F0"><input name="ediSurname" size="20" value="<%= surname %>"></td>
          <td bgcolor="#F0F0F0" nowrap><img border="0" src="images/dot.gif" width="10" height="10"></td>
        </tr>
        <tr>
          <td width="100%" nowrap><p>Country<img src="images/dot.gif" WIDTH="4" HEIGHT="4" border="0"></td>
          <td style="font-family: none;"><input name="ediCountry" size="20" value="<%= country %>"></td>
          <td nowrap><img border="0" src="images/dot.gif" width="10" height="10"></td>
        </tr>
        <tr>
          <td width="100%" nowrap bgcolor="#F0F0F0"><p>Gender<img src="images/dot.gif" WIDTH="4" HEIGHT="4" border="0"></td>
          <td style="font-family: none;" bgcolor="#F0F0F0"><select name="cmbGender" size="1">
            <option selected value="-1" <% If (gender = -1) Then Response.Write " selected " %>>Not
            specified&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
            <option value="0" <% If (gender = 0) Then Response.Write " selected " %>>Male</option>
            <option value="1" <% If (gender = 1) Then Response.Write " selected " %>>Female</option>
            <option value="2" <% If (gender = 2) Then Response.Write " selected " %>>Hermaphrodite</option>
          </select></td>
          <td nowrap bgcolor="#F0F0F0"><img border="0" src="images/dot.gif" width="10" height="10"></td>
        </tr>
        <tr>
          <td width="100%" nowrap><p>Email<img src="images/dot.gif" WIDTH="4" HEIGHT="4" border="0"></td>
          <td style="font-family: none;"><input name="ediEmail" size="20" value="<%= email %>"></td>
          <td nowrap><p><img border="0" src="images/goldstar.gif" align="absmiddle" alt="mandatory" width="15" height="15"><img src="images/dot.gif" WIDTH="4" HEIGHT="4" border="0"></td>
        </tr>
        <tr>
          <td width="100%" bgcolor="#F0F0F0" nowrap><p>Username<img src="images/dot.gif" WIDTH="4" HEIGHT="4" border="0"></td>
          <td style="font-family: none;" bgcolor="#F0F0F0"><input name="ediUsername" size="20" maxlength="16" value="<%= username %>"></td>
          <td bgcolor="#F0F0F0" nowrap><img border="0" src="images/goldstar.gif" align="absmiddle" alt="mandatory" width="15" height="15"><img src="images/dot.gif" WIDTH="4" HEIGHT="4" border="0"></td>
        </tr>
        <tr>
          <td width="100%" nowrap><p>Password<img src="images/dot.gif" WIDTH="4" HEIGHT="4" border="0"></td>
          <td style="font-family: none;"><input type="password" name="ediPassword" size="20" maxlength="16" value="<%= password %>"></td>
          <td nowrap><p><img border="0" src="images/goldstar.gif" align="absmiddle" alt="mandatory" width="15" height="15"><img src="images/dot.gif" WIDTH="4" HEIGHT="4" border="0"></td>
        </tr>
        <tr>
          <td width="100%" nowrap bgcolor="#F0F0F0"><p>Retype password<img src="images/dot.gif" WIDTH="4" HEIGHT="4" border="0"></td>
          <td style="font-family: none;" bgcolor="#F0F0F0"><input name="ediRetypePassword" type="password" size="20" maxlength="16" value="<%= retypePassword %>"></td>
          <td nowrap bgcolor="#F0F0F0"><p><img border="0" src="images/goldstar.gif" align="absmiddle" alt="mandatory" width="15" height="15"><img src="images/dot.gif" WIDTH="4" HEIGHT="4" border="0"></td>
        </tr>
      </table>
        </td>
      <td width="10"><font color="#FFFFFF"><img border="0" src="images/dot.gif" width="8" height="16"></font></td>
    </tr>
    <tr>
      <td width="100%" colspan="3"><table border="0" width="100%" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100%"><img src="images/sline.gif" width="100%" height="10" alt="sline.gif (51 bytes)" border="0"></td>
            </tr>
            <tr>
              <td width="100%" align="right"><img border="0" src="images/dot.gif" width="10" height="8"><br>
                <input border="0" src="images/btn_ok.gif" name="submit" type="image" width="68" height="19"><img border="0" src="images/dot.gif" width="4" height="19"><a href="default.asp"><img border="0" src="images/btn_cancel.gif" width="68" height="19"></a></td>
            </tr>
          </table>
      </td>
    </tr>
  </table>
    </div>
  </form>
  </center>
</td>
      </tr>
    </table>
      </td>
  </tr>
</table>
</td>
      <td width="50%" bgcolor="#FFFFFF"><img border="0" src="images/dot.gif" width="1" height="31"></td>
    </tr>
  </table>
<!--webbot bot="Include" U-Include="__footer.htm" TAG="BODY" startspan -->

      <table border="0" width="580" background="http://pt/images/footer_curve.gif" height="100" cellspacing="0" cellpadding="0" align=center>
        <tr>
          <td width="100%" valign="top" align="right">
            <p class="BottomNote"><img border="0" src="images/dot.gif" width="25" height="10"><br>
            <img border="0" src="images/dot.gif" width="25" height="10"><br>
            Send your comments to <a href="mailto:conquermarks@theill.com">conquermarks@theill.com</a><img border="0" src="images/dot.gif" width="30" height="10"><b><br>
  </b>©1996-2000 <a href='http://www.conquerware.dk/' target='_new'>ConquerWare</a>.<img border="0" src="images/dot.gif" width="35" height="10"><br>
            All rights reserved.<img border="0" src="images/dot.gif" width="40" height="10"></p>
          </td>
        </tr>
      </table>


<!--webbot bot="Include" endspan i-checksum="44150" -->

</body>
</html>