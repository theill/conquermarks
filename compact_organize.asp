<% Option Explicit %>
<%

	'
	' #: compact_organize.asp
	' 
	' Shows list of folders and favorites with a checkbox
	' for deletion. When a link is clicked, the user will
	' be redirected to a page for editing either a folder
	' or a favorite.
	' 
	' Author: Peter Theill - peter@theill.com - ConquerWare
	'
	If (Session("conquermarks_id") = "") Then
		Response.Redirect "compact_login.asp"
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
		Response.Write("<nobr><a href='" & url & "' title=""" & url & vbCrLf & _
		description & """ target='conquermarks' onMouseOver=""linkSelected('" & url & "', 'fdjk')""><img src='images/iebookmark.gif' width=18 height=17 border=0 align=absmiddle alt=""" & url & vbCrLf &description & """>&nbsp;" & rs(1)) & "</a></nobr><br>"
		
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
		Response.Write "<nobr><a href='favorite.asp?parentId=" & groups_id & "' target='conquermarks'><img src='images/iebookmark_gray.gif' width=18 height=17 border=0 align=absmiddle>&nbsp;Create new Favorite...</a></nobr><br>"
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
			
			Response.Write("<nobr><a href='" & action_page & "?collaps=" & rs(0) & "'>" & img & "</a>&nbsp;" & rs(1) & "</nobr>" & vbCrLf)
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
			
			Response.Write("<nobr><a href='" & action_page & "?expand=" & rs(0) & "'>" & img & "</a>&nbsp;" & rs(1) & "</nobr><br>" & vbCrLf)
'			Response.Write("<br>")
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
 <META HTTP-EQUIV="REFRESH" CONTENT="300; URL=compact_organize.asp">
 <title>conquermarks @ theill.com</title>
 <link rel="stylesheet" type="text/css" href="default.css">
 <script language="JavaScript">
 
 	function linkSelected(linkName, linkDescription)
 	{
 		; // set description on tag in bottom frame
 	}
 
 </script>
 <base target="compact_main">
</head>


<body leftmargin=2 topmargin=2 marginwidth=2 marginheight=2>

<table border=0 cellspacing=0 cellpadding=0>
<tr>
<td class="Hierarchy">
<%

	Set oDB = Server.CreateObject("ADODB.Connection")
	oDB.Open(Application("conquermarks_ConnectionString"))
	
	' print root and its top levels
'	Response.Write "<dl>" & vbCrLf
	Call printGroups("NULL", "compact_organize.asp", -1)
	Call printBookmarks("NULL")
'	Response.Write "</dl>" & vbCrLf
	
	oDB.Close
	Set oDB = Nothing
	
	If (NOT hasData) Then %>
	<p align="justify">No folders nor favorites are available at the moment. You are able to add a new folder or favorite using the menuitems to your left.</p>
	<% End If %>
</td>
</tr>
</table>
</body>
</html>