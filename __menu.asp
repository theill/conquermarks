<html>

<head>
 <title>menu @ theill.com</title>
 <link rel="stylesheet" type="text/css" href="default.css">
</head>

<body topmargin="0" leftmargin="0" marginwidth=0 marginheight=0>
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
</body>
</html>
