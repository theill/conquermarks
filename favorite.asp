<% Option Explicit %>
<%

	'
	' #: favorite.asp
	'
	' Adds new folder for this user. A hierarchy of folders are printed
	' and user is able to pick one as a parent. If no group is selected
	' a message will be printed and no folder will be added to system.
	'
	' Author: Peter Theill - peter@theill.com - ConquerWare
	'
	If ( Session("conquermarks_id") = "" ) Then
		Response.Redirect( "default.asp" )
	End If
	
	' find out about collaps/expand state of folders
	Dim expand_id, collaps_id, selectedId, parentId
	expand_id = Request.QueryString("expand")
	collaps_id = Request.QueryString("collaps")
	
	parentId = Request.QueryString("parentId")
	
	If (expand_id = "") Then
		selectedId = collaps_id
	Else
		selectedId = expand_id
	End If
	
	Dim oDB, oRS, errorMessage, hasGroups, pageState
	errorMessage = ""
	hasGroups = False
	pageState = "add"
	
	Dim groupId, name, url, description, publicMark, favoriteId
	url = "http://"
	
	favoriteId = Request.QueryString("id")
	If (favoriteId <> "") Then
		' we need to update this favorite, thus we have to get all stored
		' information about it first.
		pageState = "update"
		
		Set oDB = Server.CreateObject("ADODB.Connection")
		oDB.Open(Application("conquermarks_ConnectionString"))
		
		mSQL = "SELECT	groups_id, name, url, description, public " & _
				"FROM		bookmarks " & _
				"WHERE		id = " & favoriteId & " " & _
				"AND		account_id = " & Session("conquermarks_id") & ";"
		
		Set oRS = oDB.Execute(mSQL)
		
		Do While Not oRS.EOF
			selectedId = oRS(0)
			' this is a MAJOR hack - I can not compare it for NULL
			If (TypeName(selectedId) <> "Long") Then
				selectedId = ""
			End If
			name = oRS(1)
			url = oRS(2)
			description = oRS(3)
			publicMark = oRS(4)
			oRS.moveNext
		Loop
		
		oRS.Close
		Set oRS = Nothing	
		
		oDB.Close
		Set oDB = Nothing

	Else
		pageState = "add"
	End If
	
	If (StrComp(Request.Form("action"), "add_favorite", 1) = 0) Then
		' user wants to add a new favorite thus we check for
		' valid input
		
		pageState = "add"
		
		groupId = Request.Form("rbGroup")
		selectedId = groupId
		name = Server.HTMLEncode(Request.Form("ediName"))
		url = Server.HTMLEncode(Request.Form("ediURL"))
		description = Server.HTMLEncode(Request.Form("memDescription"))
		
		If (Len(name) = 0) Then
			errorMessage = "Please specify a name for your favorite."
		End If
		
		If (errorMessage = "") AND (Len(url) = 0) Then
			errorMessage = "Please specify an URL for your favorite."
		End If
		
		If (errorMessage = "") AND (InStr(LCase(url), "http://") = 0) Then
			' automatically append "http://" if it is not in url
			url = "http://" & url
		End If
		
		If (errorMessage = "") AND (Len(groupId) = 0) Then
			errorMessage = "Please select a folder as parent for your favorite."
		End If
		
		If (errorMessage = "") Then
			' Required information found thus we add new favorite
			' to specified group.
			
			' convert -1 to NULL for group_id
			If ( StrComp(groupId, "-1") = 0 ) Then
				groupId = "NULL"
			End If
			
			' add default description if no was entered
			If (Len(description) = 0) Then
				description = "no description available"
			End If
	
			' some length checks would be nice
			
			' replace ' with ''
			name = Replace(name, "'", "''")
			url = Replace(url, "'", "''")
			description = Replace(description, "'", "''")
			
			' create database access
			Dim mSQL
			Set oDB = Server.CreateObject("ADODB.Connection")
			oDB.Open(Application("conquermarks_ConnectionString"))
			
			' check <groupId> and make dynamic SQL statement
			If ( StrComp(groupId, "NULL") <> 0 ) Then
			
				' folder available, thus we make favorite in 
				' specified folder
				mSQL =	"INSERT INTO	bookmarks " & _
						"	(groups_id, account_id, name, description, url) " & _
						"VALUES (" & _
							groupId & ", " & _
							Session("conquermarks_id") & ", " & _
							"'" & name & "', " & _
							"'" & description & "', " & _
							"'" & url & "' " &_
						");"
			Else

				' no group available, so we will have to use id of account
				mSQL =	"INSERT INTO	bookmarks " & _
						"	(account_id, name, description, url) " & _
						"VALUES (" & _
							Session("conquermarks_id") & ", " & _
							"'" & name & "', " & _
							"'" & description & "', " & _
							"'" & url & "' " & _
						");"
			End If
		
			oDB.Execute(mSQL)
		
			oDB.Close
			Set oDB = Nothing
			
			' show hierarchy
			Response.Redirect("organize.asp")
			
		End If ' // > If (errorMessage = "") Then
		
	End If ' // > If (Request.Form("action") = "add_favorite") Then
	
	
	If (StrComp(Request.Form("action"), "update_favorite", 1) = 0) Then
		' user wants to submit form and update this favorite

		pageState = "update"
		
		groupId = Request.Form("rbGroup")
		selectedId = groupId
		
		favoriteId = Request.Form("id")
		name = Server.HTMLEncode(Request.Form("ediName"))
		url = Server.HTMLEncode(Request.Form("ediURL"))
		description = Server.HTMLEncode(Request.Form("memDescription"))
		
		If (Len(name) = 0) Then
			errorMessage = "Please specify a name for your favorite."
		End If
		
		If (errorMessage = "") AND (Len(url) = 0) Then
			errorMessage = "Please specify an URL for your favorite."
		End If
		
		If (errorMessage = "") AND (InStr(LCase(url), "http://") = 0) Then
			errorMessage = "<b>http://</b> is needed. Please check your URL."
			url = "http://" & url
		End If
		
		If (errorMessage = "") AND (Len(groupId) = 0) Then
			errorMessage = "Please select a folder as parent for your favorite."
		End If
		
		If (errorMessage = "") Then
			' Required information found thus we update favorite
			
			' convert -1 to NULL for group_id
			If ( StrComp(groupId, "-1") = 0 ) Then
				groupId = "NULL"
			End If
			
			' add default description if no was entered
			If (Len(description) = 0) Then
				description = "no description available"
			End If
	
			' some length checks would be nice
			
			' replace ' with ''
			name = Replace(name, "'", "''")
			url = Replace(url, "'", "''")
			description = Replace(description, "'", "''")
			
			' create database access
			Set oDB = Server.CreateObject("ADODB.Connection")
			oDB.Open(Application("conquermarks_ConnectionString"))
			
			' check <groupId> and make dynamic SQL statement
			If (StrComp(groupId, "-1", 1) = 0) Then
				groupId = "NULL"
			End If
			
			' folder available, thus we make favorite in 
			' specified folder
			mSQL =	"UPDATE	bookmarks " & _
					"SET 		groups_id = " & groupId & ", " & _
					"			name = '" & name & "', " & _
					"			url = '" & url & "', " & _
					"			description = '" & description & "' " & _
					"WHERE		id = " & favoriteId & " " & _
					"AND		account_id = " & Session("conquermarks_id") & ";"
			
			oDB.Execute(mSQL)
		
			oDB.Close
			Set oDB = Nothing
			
			' show hierarchy
			Response.Redirect("organize.asp")
			
		End If ' // > If (errorMessage = "") Then
		
	End If ' // > If (StrComp(Request.Form("action"), "update_favorite", 1) = 0) Then
	
Dim m_SQL
	
'
' Prints all children (bookmarks) in specified group
'
function printBookmarks(groups_id, radio_btn)

	Dim rs
	
	' check <groups_id> and make SQL statement from it
	If ( StrComp(groups_id, "NULL") <> 0 ) Then
		m_SQL = "SELECT		id, name, url, description " & _
				"FROM		bookmarks " & _
				"WHERE		groups_id = " & groups_id & ";"
	Else
		m_SQL = "SELECT		id, name, url, description " & _
				"FROM		bookmarks " & _
				"WHERE		account_id = " & Session("conquermarks_id") & " " & _
				"AND		groups_id Is Null;"
	
	End If
			
	set rs = oDB.Execute(m_SQL)
	
	do while not rs.EOF
		Response.Write("<nobr><a href='"&rs(2)&"' target='conquermarks'><img src='images/iebookmark.gif' width=18 height=17 border=0 align=absmiddle>&nbsp;" & rs(1)) & "</a></nobr><br>"
		rs.moveNext
	loop
	
	rs.close
	set rs = nothing	

end function

'
' Prints all children (groups) in specified group
'
Function printGroups(parent_id, action_page, radio_btn, print_marks, selectedId)

	Dim rs

	If ( StrComp(parent_id, "NULL") <> 0 ) Then
		m_SQL=	"SELECT	id, name, description, public " & _
				"FROM		groups " & _
				"WHERE		account_id = " & Session("conquermarks_id") & " " & _
				"AND		parent_id = " & parent_id & " " & _
				"ORDER BY	name;"
	Else
		m_SQL=	"SELECT	id, name, description, public " & _
				"FROM		groups " & _
				"WHERE		account_id = " & Session("conquermarks_id") & " " & _
				"AND		parent_id Is Null " & _
				"ORDER BY	name;"
	
	End If

	Set rs = oDB.Execute(m_SQL)
	
	Do While Not rs.EOF
	
		If ( StrComp(expand_id, rs(0), 1) = 0 ) Then
			Session("expanded"&rs(0)) = rs(0)
		End If
		
		If ( StrComp(collaps_id, rs(0), 1) = 0 ) Then
			Session("expanded"&rs(0)) = ""
		End If
		
		Dim img
		If ( StrComp(Session("expanded"&rs(0)), rs(0), 1) = 0 ) Then
			If (rs(3)) Then
				img = "<img src='images/opened.gif' border=0 width=18 height=17 align=absmiddle>"
			Else
				img = "<img src='images/private_opened.gif' border=0 width=18 height=17 align=absmiddle>"
			End If
			
			If (radio_btn) Then
				If ( (StrComp(selectedId, rs(0), 1) <> 0) AND (StrComp(parentId, rs(0), 1) <> 0) ) Then
					Response.Write("<nobr><input type='radio' name='rbGroup' value='" & rs(0) & "'><a href='" & action_page & "&collaps=" & rs(0) & "'>" & img & "&nbsp;" & rs(1) & "</a></nobr>")
				Else
					Response.Write("<nobr><input type='radio' name='rbGroup' value='" & rs(0) & "' checked><a href='" & action_page & "&collaps=" & rs(0) & "'>" & img & "&nbsp;" & rs(1) & "</a></nobr>")
				End If
			Else
				Response.Write("<nobr><a href='" & action_page & "&collaps=" & rs(0) & "'>" & img & "&nbsp;" & rs(1) & "</a></nobr>")
			End If
			Response.Write("<dl>" & vbCR)
			Call printGroups(rs(0), action_page, radio_btn, print_marks, selectedId)
			If (print_marks) Then
				Call printBookmarks(rs(0), radio_btn)
			End If
			Response.Write("</dl>" & vbCR)
		Else
			If (rs(3)) Then
				img = "<img src='images/closed.gif' border=0 width=18 height=17 align=absmiddle>"
			Else
				img = "<img src='images/private_closed.gif' border=0 width=18 height=17 align=absmiddle>"
			End If
			
			If (radio_btn) Then
				If (StrComp(selectedId, rs(0), 1) <> 0) Then
					Response.Write("<nobr><input type='radio' name='rbGroup' value='" & rs(0) & "'><a href='" & action_page & "&expand=" & rs(0) & "'>" & img & "&nbsp;" & rs(1) & "</a></nobr>")
				Else
					Response.Write("<nobr><input type='radio' name='rbGroup' value='" & rs(0) & "' checked><a href='" & action_page & "&expand=" & rs(0) & "'>" & img & "&nbsp;" & rs(1) & "</a></nobr>")
				End If
			Else
				Response.Write("<nobr><a href='" & action_page & "&expand=" & rs(0) & "'>" & img & "&nbsp;" & rs(1) & "</a></nobr>")
			End If
			Response.Write("<br>")
		End If
		rs.moveNext
		
		' You have a group, thus you do not need to select ROOT as default
		hasGroups = True
	Loop
	
	' Close this resultset
	rs.Close
	Set rs = Nothing

End Function

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
        <td width="100%" valign="top" align="justify">
          <p class="Caption"><%= pageState %> <b>favorite</b></p>
          <form action="favorite.asp" method="POST">
          <% If (pageState = "add") Then %>
          <input type="hidden" name="action" value="add_favorite">
          <% Else %>
          <input type="hidden" name="action" value="update_favorite">
          <input type="hidden" name="id" value="<%= Request.QueryString("id") %>">
          <% End If %>
<p align="justify">Enter name, URL and description for your favorite and select a parent by marking a radiobutton in the
tree below.</p>
<%
	If (errorMessage <> "") Then
		Response.Write("<span class='Error'>" & errorMessage & "</span>")
	End If
%>

<table border="0" cellpadding="4" cellspacing="0" width="100%">
  <tr>
    <td nowrap>Name</td>
    <td style="font-family: none;" width="100%" valign="top"><input style="width: 100%;" type="text" name="ediName" size="20" value="<%= name %>" tabindex="1"></td>
  </tr>
  <tr>
    <td nowrap valign="top" bgcolor="#F6F6F6">URL</td>
    <td width="100%" valign="top" bgcolor="#F6F6F6"><input style="width: 100%;" onFocus="javascript:ediURL.select();" type="text" name="ediURL" value="<%= url %>" size="20" tabindex="2">
</td>
  </tr>
  <tr>
    <td nowrap valign="top">Description</td>
    <td width="100%" valign="top" style="font-family: none;"><textarea rows="3" style="width: 100%;" name="memDescription" cols="20" tabindex="3"><%= description %></textarea>
</td>
  </tr>
  <tr>
    <td nowrap valign="top" bgcolor="#F6F6F6">Parent</td>
    <td width="100%" valign="top" class="Hierarchy" bgcolor="#F6F6F6"><%

	Set oDB = Server.CreateObject("ADODB.Connection")
	oDB.Open(Application("conquermarks_ConnectionString"))
	
	' print root and its top levels
	Response.Write("<nobr><input type='radio' name='rbGroup' value='-1' checked><img src='images/opened.gif' border=0 width=18 height=17 align=absmiddle>&nbsp;<b>Root</b></nobr>")
	Response.Write("<dl>" & vbCR)
	If (Request.QueryString("id") <> "") Then
		Call printGroups("NULL", "favorite.asp?id=" & Request.QueryString("id"), True, False, selectedId)
	Else
		Call printGroups("NULL", "favorite.asp?none=none", True, False, selectedId)
	End If
	Response.Write("</dl>" & vbCR)
	
	oDB.Close
	Set oDB = Nothing
	
%>
</td>
  </tr>
  <tr>
    <td nowrap valign="top"></td>
    <td width="100%" valign="top" class="Hierarchy" align="right"><input border="0" src="images/btn_ok.gif" name="submit" type="image"><img border="0" src="images/dot.gif" width="4" height="19"><a href="organize.asp"><img border="0" src="images/btn_cancel.gif">
      </a>
</td>
  </tr>
</table>
</form>

</td>
      </tr>
    </table>
    <p>&nbsp;</td>
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