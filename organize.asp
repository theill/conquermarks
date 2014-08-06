<% Option Explicit %>
<%

	'
	' #: organize.asp
	' 
	' Shows list of folders and favorites with a checkbox
	' for deletion. When a link is clicked, the user will
	' be redirected to a page for editing either a folder
	' or a favorite.
	' 
	' Author: Peter Theill - peter@theill.com - ConquerWare
	'
	If ( Session("conquermarks_id") = "" ) Then
		Response.Redirect( "default.asp" )
	End If
	
	' handle collaps/expand of folders
	Dim expand_id, collaps_id, selectedId, hasData
	hasData = False
	
	expand_id = Request.QueryString("expand")
	collaps_id = Request.QueryString("collaps")
	
	If (expand_id = "") Then
		selectedId = collaps_id
	Else
		selectedId = expand_id
	End If
	
	Dim oDB, oRS, errorMessage, hasGroups, groupId
	errorMessage = ""
	hasGroups = False
	
	If (StrComp(Request.Form("action"), "delete_marks", 1) = 0) Then
		
		' user wants to delete all checked folders/favorites
		
		Dim groupsList, subList, mSQL, moreIds
		groupsList = Request.Form("ckbGroups")
		subList = groupsList
		moreIds = True
		
		Set oDB = Server.CreateObject("ADODB.Connection")
		oDB.Open(Application("conquermarks_ConnectionString"))
		
		If (groupsList <> "") Then
			
			Do While moreIds
				
				mSQL = "SELECT	id " & _
						"FROM		groups " & _
						"WHERE		parent_id IN (" & subList &") "
			
				Set oRS = oDB.Execute(mSQL)
				moreIds = False
				
				subList = ""
				Do While Not oRS.EOF
					subList = oRS(0) & ", " & subList
					oRS.MoveNext
					moreIds = True
				Loop
				
				If (Right(subList, 2) = ", ") Then
					subList = Left(subList, Len(subList)-2)
				End If
				groupsList = groupsList & ", " & subList
				
			Loop
			
			If (Right(groupsList, 2) = ", ") Then
				groupsList = Left(groupsList, Len(groupsList)-2)
			End If
			
			mSQL = "DELETE FROM	groups " & _
					"WHERE		id IN (" & groupsList & ") "
			
			oDB.Execute(mSQL)
			
			mSQL = "DELETE FROM	bookmarks " & _
					"WHERE		groups_id IN (" & groupsList & ") " 
			
			oDB.Execute(mSQL)
			
		End If
		
		If (Request.Form("ckbMarks") <> "") Then
			mSQL = "DELETE FROM	bookmarks " & _
					"WHERE		id IN (" & Request.Form("ckbMarks") & ");"
			
			oDB.Execute(mSQL)
		End If

		oDB.Close
		Set oDB = Nothing
		
	End If ' // > If (StrComp(Request.Form("action"), "delete_marks", 1) <> 0) Then
	
Dim m_SQL
	
'
' Prints all children (bookmarks) in specified group
'
Function printBookmarks(groups_id)

	Dim rs, hasBookmarks, url, description, isTopLevel
	isTopLevel = False
	
	' check <groups_id> and make SQL statement from it
	If ( StrComp(groups_id, "NULL") <> 0 ) Then
		m_SQL = "SELECT	id, name, url, description " & _
				"FROM		bookmarks " & _
				"WHERE		groups_id = " & groups_id & ";"
	Else
		m_SQL = "SELECT	id, name, url, description " & _
				"FROM		bookmarks " & _
				"WHERE		account_id = " & Session("conquermarks_id") & " " & _
				"AND		groups_id Is Null;"
		hasBookmarks = True
		isTopLevel = True
	End If
			
	Set rs = oDB.Execute(m_SQL)
	
	Do While Not rs.EOF
		url = rs(2)
		description = rs(3)
		Response.Write("<nobr><input type='checkbox' name='ckbMarks' value='" & rs(0) & "'><a href='favorite.asp?id=" & rs(0) & "'><img src='images/edit_small3.gif' width=12 height=12 border=0 alt='Edit Favorite'></a><a href='" & url & "' title=""" & url & vbCrLf & _
		description & """ target='conquermarks'><img src='images/iebookmark.gif' width=18 height=17 border=0 align=absmiddle alt=""" & url & vbCrLf &description & """>&nbsp;" & rs(1)) & "</a></nobr><br>"
		
		' We have SOME kind of data > no need to print a "no marks available 
		' yet" message
		hasData = True
		
		rs.MoveNext
	Loop
	
	rs.Close
	Set rs = Nothing	
	
	' print an grayed out favorite which adds new favorites to same folder
	' but only if you are NOT showing root level favorites
	If (NOT isTopLevel) Then
		Response.Write "<nobr><img src='images/dot.gif' width=33 height=12><a href='favorite.asp?parentId=" & groups_id & "'><img src='images/iebookmark_gray.gif' width=18 height=17 border=0 align=absmiddle>&nbsp;Create new Favorite...</a></nobr><br>"
	End If
	
End Function

'
' Prints all children (groups) in specified group
'
Function printGroups(parent_id, action_page, selectedId)

	Dim rs, img

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
	
		if ( StrComp(expand_id, rs(0), 1) = 0 ) then
			Session("expanded"&rs(0)) = rs(0)
		end if
		
		if ( StrComp(collaps_id, rs(0), 1) = 0 ) then
			Session("expanded"&rs(0)) = ""
		end if
		
		If ( StrComp(Session("expanded"&rs(0)), rs(0), 1) = 0 ) Then
			If (rs(3)) Then
				img = "<img src='images/opened.gif' border=0 width=18 height=17 align=absmiddle>"
			Else
				img = "<img src='images/private_opened.gif' border=0 width=18 height=17 align=absmiddle>"
			End If
			
			Response.Write("<nobr><input type='checkbox' name='ckbGroups' value='" & rs(0) & "'><a href='folder.asp?id=" & rs(0) & "'><img src='images/edit_small3.gif' width=12 heigh=12 border=0 alt='Edit Folder'></a><a href='" & action_page & "?collaps=" & rs(0) & "'>" & img & "</a>&nbsp;" & rs(1) & "</nobr>" & vbCrLf)
			Response.Write("<dl>" & vbCrLf)
			Call printGroups(rs(0), action_page, -1)
			Call printBookmarks(rs(0))
			Response.Write("</dl>" & vbCrLf)
		Else
			If (rs(3)) Then
				img = "<img src='images/closed.gif' border=0 width=18 height=17 align=absmiddle>"
			Else
				img = "<img src='images/private_closed.gif' border=0 width=18 height=17 align=absmiddle>"
			End If
			
			Response.Write("<nobr><input type='checkbox' name='ckbGroups' value='" & rs(0) & "'><a href='folder.asp?id=" & rs(0) & "'><img src='images/edit_small3.gif' width=12 heigh=12 border=0 alt='Edit Folder'></a><a href='" & action_page & "?expand=" & rs(0) & "'>" & img & "</a>&nbsp;" & rs(1) & "</nobr><br>" & vbCrLf)
		End If

		' We have SOME kind of data > no need to print a "no marks available 
		' yet" message
		hasData = True
		
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
          <p class="Caption"><b>organize</b> favorites</p>
          <form action="organize.asp" method="POST">
          <input type="hidden" name="action" value="delete_marks">
<%
	If (errorMessage <> "") Then
		Response.Write("<span class='Error'>" & errorMessage & "</span>")
	End If
%>

<table border="0" cellpadding="4" cellspacing="0" width="100%">
  <tr>
    <td width="100%" valign="top" class="Hierarchy" bgcolor="#F6F6F6">
<%

	Set oDB = Server.CreateObject("ADODB.Connection")
	oDB.Open(Application("conquermarks_ConnectionString"))
	
	' print root and its top levels
'	Response.Write("<dl>" & vbCrLf)
	Call printGroups("NULL", "organize.asp", -1)
	Call printBookmarks("NULL")
'	Response.Write("</dl>" & vbCrLf)
	
	oDB.Close
	Set oDB = Nothing
	
%>

<% If (NOT hasData) Then %>
<p>No folders nor favorites are available at the moment. You are able to add a
new folder or favorite using the menuitems to your left.</p>
<% End If %>
</td>
  </tr>
  <% If (hasData) Then %>
  <tr>
    <td width="100%" valign="top" class="Hierarchy" align="right">
          <p align="justify" class="BottomNote">
          Please be aware when you delete a folder, that all subfolders and favorites in
          this will be deleted too.</p>
</td>
  </tr>
  <tr>
    <td width="100%" valign="top" class="Hierarchy" align="right"><input border="0" src="images/btn_delete.gif" name="I2" value="submit" type="image"></td>
  </tr>
  <% End If %>
</table>
</form>
<% If (LCase(Request.QueryString("openCompactMode")) = "true") Then %>
<script language="JavaScript">
  openCompactMode();
</script>
<% End If %>
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