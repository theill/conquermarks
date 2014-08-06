<% Option Explicit %>

<%

	If ( Session("conquermarks_id") <> "" ) Then
		Response.Redirect( "organize.asp?update=true" )
	End If
	
	Dim username, password
	username = Request.Form("username")
	password = Request.Form("password")
	
	' you are able to login using standard GET method, i.e. having username and password
	' in your URL, like http://www.conquermarks.com/login.asp?username=test&password=test
	If ( (Request.QueryString("username") <> "") AND (Request.QueryString("password") <> "") ) Then
		username = Request.QueryString("username")
		password = Request.QueryString("password")
	End If
	
	Dim login_message
	login_message = ""

	If ( ( username <> "" ) AND ( password <> "" ) ) Then
		
		' check database
		Dim m_sql
		m_sql =	"SELECT	id, firstname, surname, email " & _
					"FROM		account " & _
					"WHERE		username = '" & username & "' " & _
					"AND		password = '" & password & "';"
		
		Dim oRS, dbConquerMarks
		Set dbConquerMarks = Server.CreateObject("ADODB.Connection")
		dbConquerMarks.Open(Application("conquermarks_ConnectionString"))
		
		Set oRS = dbConquerMarks.execute(m_sql)
		
		If ( Not oRS.EOF ) Then
			' user found in database
			Session("conquermarks_id") = oRS(0)
'			Session("username") = username
'			Session("firstname") = oRS(1)
'			Session("surname") = oRS(2)
'			Session("email") = oRS(3)
			Session.TimeOut = 10
			
			' we should read a 'open compact as default' state from database
			
			Response.Redirect( "organize.asp?update=true&openCompactMode=False" )
		Else
			' user was not found in database, thus we redirect him/her to our
			' "create account" page, using entered username and password
			Response.Redirect "account.asp?username=" & username & "&password=" & password
			Response.End
'			login_message = "Sorry, username/password combination is not recognized."
		End If
		
		oRS.close
		Set oRS = Nothing
		
		dbConquerMarks.Close
		Set dbConquerMarks = Nothing
		
	Else
		login_message = ""
	End If
	
%>
<html>

<head>
 <meta name="description" content="ConquerMarks is a free services for managing your favorites / bookmarks online.">
 <meta name="keywords" content="online favorites, favorites, online bookmarks, bookmarks, online manager, manager bookmark manager, manage bookmarks, ConquerMarks, theill, peter">
 <title>conquermarks @ theill.com</title>
 <link rel="stylesheet" type="text/css" href="default.css">
 <script language="JavaScript">
 	var m_compact
 	function openCompactMode()
 	{
 		m_compact = window.open('compact.html', m_compact, 'toolbar=no,width=150,height=250');
		m_compact.focus();
 	}
 </script> 
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
      <td align=center><a href="default.asp"><img border="0" src="images/header_conquermarks.gif" width="580" height="50" alt="ConquerMarks 1.0"></a></td>
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
        <td valign="top">
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
        <td width="100%" valign="top" align="justify"><%
	
	If (login_message <> "") Then
		Response.Write("<span class='Error'>" & login_message & "</span>")
	End If
%>
          <p align="justify" class="Caption">what's <b>new</b>?</p>


                    <p align="justify">It's now possible to log into your
                    account directly using an URL. Of course, it's not as secure
                    as a normal login, but it's much quicker, if you're the only
                    one using the computer. To log directly into a account with
                    username <i>test</i> and password <i>test</i>, you just have
                    to type:</p>


                    <p align="center" class="IndexTable"><a href="http://www.theill.com/ConquerMarks/default.asp?username=test&amp;password=test">http://www.theill.com/ConquerMarks/default.asp?username=test&amp;password=test</a></p>


          <p align="justify">&nbsp;</p>


                    <p align="justify" class="Caption">get <b>your</b> account</p>
                    <p align="justify">You will have to create an account before
                    starting to manage your favorites/bookmarks online. It only
                    takes a couple of seconds. Just <a href="account.asp">click here to create
                    your own profile</a>.
                    <p align="justify">&nbsp;</p>


          <p align="justify" class="Caption"><b>what</b>
          is it?</p>


          <p align="justify"><font color="green">ConquerMarks</font>
          is a new project
          made available by <a href="http://www.conquerware.dk/" target="_blank">ConquerWare</a>, which
          will enable you to maintain all your bookmarks
          online. It doesn't matter, whether you're at work, in school, down at
          your local library or anywhere else - you'll be able to use your own
          bookmarks. Normally, these services is pretty clumsy to work with, but
          <font color="green">ConquerMarks</font> have been designed to use a
          minimal area of your screen and furthermore its layout looks a lot
          like the 'Favorites' section in Microsoft Internet Explorer 4.0 and up
          browsers.</p>


          <p align="justify">
          <script language="JavaScript">
				document.LoginForm.username.focus();
          </script>
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
