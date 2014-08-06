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
      <td align=center width="580" height="50"><a href="default.asp"><img border="0" src="images/header_conquermarks.gif" alt="ConquerMarks 1.0" width="580" height="50"></a></td>
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
        <td width="100%" valign="top" align="justify" class="Hierarchy">
          <p class="Caption">used <b>legends</b></p>
          <table border="0" cellpadding="4" cellspacing="0" width="100%">
            <tr>
              <td valign="top" class="BottomNote"><img border="0" src="images/closed.gif" width="18" height="17"></td>
              <td width="100%" class="BottomNote"> closed public folder, i.e.
                none of its favorites will be shown. A public folder is
                available for all people. <b>This feature has yet to be
                implemented.</b></td>
            </tr>
            <tr>
              <td valign="top" bgcolor="#F6F6F6" class="BottomNote"><img border="0" src="images/opened.gif" width="18" height="17"></td>
              <td width="100%" bgcolor="#F6F6F6" class="BottomNote">
                opened public folder, i.e. all of its favorites will be shown. A
                public folder is available for all people. <b>This feature has
                yet to be implemented.</b></td>
            </tr>
            <tr>
              <td valign="top" class="BottomNote"><img border="0" src="images/private_closed.gif" width="18" height="17"></td>
              <td width="100%" class="BottomNote"> closed private folder. A
                private folder is only visible for your account.</td>
            </tr>
            <tr>
              <td valign="top" bgcolor="#F6F6F6" class="BottomNote"><img border="0" src="images/private_opened.gif" width="18" height="17"></td>
              <td width="100%" bgcolor="#F6F6F6" class="BottomNote">
                opened private folder, i.e. all of its favorites will be
                visible. A private folder is only visible for your account.</td>
            </tr>
            <tr>
              <td valign="top" class="BottomNote"><img border="0" src="images/iebookmark.gif" width="18" height="17"></td>
              <td width="100%" class="BottomNote">favorite/bookmark.</td>
            </tr>
            <tr>
              <td valign="top" bgcolor="#F6F6F6" class="BottomNote"><img border="0" src="images/iebookmark_gray.gif" width="18" height="17"></td>
              <td width="100%" bgcolor="#F6F6F6" class="BottomNote">none-existing
                favorite, shown when a group is opened but doesn't contain any
                favorites.</td>
            </tr>
            <tr>
              <td valign="top" class="BottomNote"><img border="0" src="images/editable.gif" width="18" height="17"></td>
              <td width="100%" class="BottomNote">edit properties for a folder
                or favorite.</td>
            </tr>
            <tr>
              <td valign="top" bgcolor="#F6F6F6" class="BottomNote"><img border="0" src="images/marked.gif" width="18" height="17"></td>
              <td width="100%" bgcolor="#F6F6F6" class="BottomNote">marked
                folder or favorite.</td>
            </tr>
            <tr>
              <td valign="top" class="BottomNote"><img border="0" src="images/unmarked.gif" width="18" height="17"></td>
              <td width="100%" class="BottomNote">unmarked folder or favorite.</td>
            </tr>
            <tr>
              <td valign="top" bgcolor="#F6F6F6" class="BottomNote"><img border="0" src="images/selected.gif" width="18" height="17"></td>
              <td width="100%" bgcolor="#F6F6F6" class="BottomNote">selected
                parent folder.</td>
            </tr>
            <tr>
              <td valign="top" class="BottomNote"><img border="0" src="images/unselected.gif" width="18" height="17"></td>
              <td width="100%" class="BottomNote">unselected parent folder.</td>
            </tr>
            <tr>
              <td valign="top" class="BottomNote" bgcolor="#F6F6F6"><img border="0" src="images/ico_trashcan.gif" width="16" height="15"></td>
              <td width="100%" class="BottomNote" bgcolor="#F6F6F6">trashcan currently not used,
                but could replace checkboxes.</td>
            </tr>
          </table>

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