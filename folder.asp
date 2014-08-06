<% Option Explicit %>

<%

	'
	' #: folder.asp
	'
	' Add new or edit folder for this user. A hierarchy of folders are 
	' printed and user is able to pick one as a parent. If no group is 
	' selected a message will be printed and no folder will be added or
	' updated in system. Children of edited node will not be printed,
	' since you cannot select these as parent folders.
	'
	' Author: Peter Theill, ConquerWare
	'
	If ( Session("conquermarks_id") = "" ) Then
		Response.Redirect( "default.asp" )
	End If

	' handle collaps/expand of folders
	Dim expand_id, collaps_id, selectedId, parentId
	
	parentId = Request.QueryString("parentId")
	
	expand_id = Request.QueryString("expand")
	collaps_id = Request.QueryString("collaps")
	
	If (expand_id = "") Then
		selectedId = collaps_id
	Else
		selectedId = expand_id
	End If

	Dim oDB, oRS, mSQL, errorMessage, hasGroups, groupId, name, pageState, publicFolder
	errorMessage = ""
	hasGroups = False
	
	groupId = Request.QueryString("id")
	If (groupId <> "") Then
		' we need to update this folder, thus we have to get all stored
		' information about it first. 
		pageState = "update"
		
		Set oDB = Server.CreateObject("ADODB.Connection")
		oDB.Open(Application("conquermarks_ConnectionString"))
		
		mSQL = "SELECT	parent_id, name, public " & _
				"FROM		groups " & _
				"WHERE		id = " & groupId & " " & _
				"AND		account_id = " & Session("conquermarks_id") & ";"
		
		Set oRS = oDB.Execute(mSQL)
		
		Do While Not oRS.EOF
			selectedId = oRS(0)
			If ( IsNull(selectedId) ) Then
				selectedId = ""
			End If
			name = oRS(1)
			publicFolder = oRS(2)
			oRS.moveNext
		Loop
		
		oRS.Close
		Set oRS = Nothing	
		
		oDB.Close
		Set oDB = Nothing

	Else
		pageState = "add"
	End If
	
	If (StrComp(Request.Form("action"), "add_folder", 1) = 0) Then
		' user wants to submit form and add this folder
		
		pageState = "add"
		
		groupId = Request.Form("rbGroup")
		selectedId = groupId
		
		name = Server.HTMLEncode(Request.Form("ediName"))
		publicFolder = Request.Form("ckbPublic")
		If (publicFolder <> "") Then
			publicFolder = True
		Else
			publicFolder = False
		End If
		
		If (name = "") Then
			errorMessage = "You have to specify a name for your folder."
		End If
		
		If (errorMessage = "") Then
			' A folder were found in form thus we will have to collect
			' group_id and enter this into system.
			
			If (groupId <> "") Then
				' We have all needed information thus we are going to create
				' a new folder.
				
				' replace ' with ''
				name = Replace(name, "'", "''")
				
				Set oDB = Server.CreateObject("ADODB.Connection")
				oDB.Open(Application("conquermarks_ConnectionString"))
				
				mSQL = "INSERT INTO	groups " & _
					"(parent_id, account_id, name, public) "
				
				' If <groupId> is -1, we have selected 'Root' and will have to
				' create group in toplevel
				If (StrComp(groupId, "-1", 1) = 0) Then
					mSQL = mSQL & "VALUES (NULL, "
				Else
					mSQL = mSQL & "VALUES (" & groupId & ", "
				End If
				
				mSQL = mSQL & Session("conquermarks_id") & ", " & _
						"'" & name & "', " & publicFolder & ");"
				
				oDB.Execute(mSQL)
				
				oDB.Close
				Set oDB = Nothing
				
				Response.Redirect("organize.asp")
				
			Else
				pageState = "add"
				errorMessage = "You have to select a group as parent for your new folder."
			End If
			
		End If
	
	End If ' // > If (StrComp(Request.Form("action"), "add_folder", 1) <> 0) Then
	
	
	If (StrComp(Request.Form("action"), "update_folder", 1) = 0) Then
		' user wants to submit form and update this folder
		
		pageState = "update"
		
		groupId = Request.Form("rbGroup")
		selectedId = groupId
		
		name = Server.HTMLEncode(Request.Form("ediName"))
		
		If (name = "") Then
			errorMessage = "You have to specify a name for your folder."
		End If
		
		publicFolder = Request.Form("ckbPublic")
		If (publicFolder <> "") Then
			publicFolder = True
		Else
			publicFolder = False
		End If
		
		If (errorMessage = "") Then
			' A folder were found in form thus we will have to collect
			' group_id and enter this into system.
			
			If (groupId <> "") Then
				' We have all needed information thus we are going to
				' update folder.
				
				' replace ' with ''
				name = Replace(name, "'", "''")
				
				Set oDB = Server.CreateObject("ADODB.Connection")
				oDB.Open(Application("conquermarks_ConnectionString"))

				If (StrComp(groupId, "-1", 1) = 0) Then
					groupId = "NULL"
				End If
				
				mSQL = "UPDATE	groups " & _
						"SET		parent_id = " & groupId & ", " & _
						"			name = '" & name & "', " & _
						"			public = " & publicFolder & " " & _
						"WHERE		id = " & Request.Form("id") & " " & _
						"AND		account_id = " & Session("conquermarks_id") & ";"
				
				oDB.Execute(mSQL)
				
				oDB.Close
				Set oDB = Nothing
				
				Response.Redirect("organize.asp")
				
			Else
				pageState = "update"
				errorMessage = "You have to select a group as parent for your new folder."
			End If
			
		End If ' // > If (errorMessage = "") Then
		
	End If ' // > If (StrComp(Request.Form("action"), "update_folder", 1) = 0) Then
	
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

	Dim rs, id

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
		
		id = rs(0)
		
		' this step is _very_ important, since we do NOT want to allow a user
		' to select folder edited to become parent of itself. Nor do we need to
		' show children of it.
		If ( (StrComp(pageState, "add") = 0) OR (StrComp(id, groupId) <> 0) ) Then
			
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
					If ( (StrComp(selectedId, rs(0), 1) <> 0) AND (StrComp(parentId, rs(0), 1) <> 0) )Then
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
          <p class="Caption"><%= pageState %> <b>folder</b></p>
          <form action="folder.asp" method="POST">
          <% If (pageState = "add") Then %>
	          <input type="hidden" name="action" value="add_folder">
          <% Else %>
	          <input type="hidden" name="action" value="update_folder">
	          <input type="hidden" name="id" value="<%= Request.QueryString("id") %>">
          <% End If %>
<p>Type a name for your new folder and select a parent by marking a radiobutton in the
tree below.</p>
<%
	If (errorMessage <> "") Then
		Response.Write("<span class='Error'>" & errorMessage & "</span>")
	End If
%>
<table border="0" cellpadding="4" cellspacing="0" width="100%">
  <tr>
    <td nowrap>Name</td>
    <td width="100%" valign="top"><input type="text" style="width: 100%;" name="ediName" size="20" value="<%= name %>" tabindex="1">
    </td>
  </tr>
  <tr>
    <td nowrap valign="top" bgcolor="#F6F6F6">Parent</td>
    <td width="100%" valign="top" class="Hierarchy" bgcolor="#F6F6F6"><%

	Set oDB = Server.CreateObject("ADODB.Connection")
	oDB.Open(Application("conquermarks_ConnectionString"))
	
	' print root and its top levels
	If (selectedId = "") Then
		Response.Write("<nobr><input type='radio' name='rbGroup' value='-1' checked><img src='images/opened.gif' border=0 width=18 height=17 align=absmiddle>&nbsp;<b>Root</b></nobr>")
	Else
		Response.Write("<nobr><input type='radio' name='rbGroup' value='-1'><img src='images/opened.gif' border=0 width=18 height=17 align=absmiddle>&nbsp;<b>Root</b></nobr>")
	End If
	Response.Write("<dl>" & vbCR)
	If (Request.QueryString("id") <> "") Then
		Call printGroups("NULL", "folder.asp?id=" & Request.QueryString("id"), True, False, selectedId)
	Else
		Call printGroups("NULL", "folder.asp?none=none", True, False, selectedId)
	End If
	Response.Write("</dl>" & vbCR)
	
	oDB.Close
	Set oDB = Nothing
	
%>
</td>
  </tr>
  <tr>
    <td nowrap valign="top">Public</td>
    <td width="100%" class="Hierarchy"><input type="checkbox" <% If (publicFolder) Then %>checked<% End If %> name="ckbPublic" value="ON"></td>
  </tr>
  <tr>
    <td nowrap valign="top"></td>
    <td width="100%" valign="top" class="Hierarchy" align="right"><input border="0" src="images/btn_ok.gif" name="submit" type="image"><img border="0" src="images/dot.gif" width="4" height="19"><a href="organize.asp"><img border="0" src="images/btn_cancel.gif"></a></td>
  </tr>
</table>
</form>
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