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
      <td align=center width="580" height="50"><a href="default.asp"><img border="0" src="images/header_conquermarks.gif" width="580" height="50" alt="ConquerMarks 1.0"></a></td>
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
          <p class="Caption">general <b>help</b></p>
          <p align="justify">This section should give you a general understanding of how
          ConquerMark works.</p>

          <p>&nbsp;</p>

          <p align="right"><b>g e t t i n g · s t a r t e d</b></p>

          <p align="justify">To get started with ConquerMarks, you need to set
          up a personal account. This will allow you to log into the system and
          maintain your favorites privately. To set up your account, click <a href="account.asp">here</a>.</p>

          <p align="justify">When you have successfully registered, you are able
          to log in. In the upper right of this window, you will see a <i>login</i>
          section. The fields named <i>usr</i> and <i>pass</i> are used to type
          in your personal username and password, which you selected in your
          registration procedure. Try to type in these and click on <i>login</i>
          button.</p>

          <p align="justify">Your main window changes to reflect your current
          favorites. You will have no favorites at this point, thus you should
          add some folder or favorites to it now. This is easily done by click
          on either <i>folder</i> or <i>favorite</i> links in the left side.</p>

          <p align="justify">&nbsp;</p>

          <p align="right"><b>o r g a n i z e · f a v o r i t e s</b></p>

          <p align="justify">There are two types of folders in ConquerMarks:
          public and private folders. If you have favorite, you think others may
          like, you can put them in a public folder. When a favorite is placed
          in this folder, it will automatically be displayed in your public
          area. Everybody are able to access this area without logging into the
          system. A private folder is used to keep your favorites for your use
          only. If you place a favorite in a private folder, you <i>will</i>
          have to log in using your username/password, before using the link.
          Please be aware, the private/public status are <b>not</b> inherited
          from the parent folder. This have been done, since you might want to
          share only a part of your e.g. <i>sports</i> folder, but not all of
          them.</p>

          <p align="justify">A new folder is added by clicking <i>add folder</i>
          item in left menu. To create a new folder, you will have to type a
          name (mandatory) and a description (optional). Furthermore, you should
          select your parent folder, i.e. the folder in which this new folder
          will be created and you have to select, if your folder should be a
          private (this is default) or a public folder. When you have filled
          your fields, you press <i>ok</i> button to create it.</p>

          <p align="justify">Favorites are added in a similar fashion. You click
          the <i>add favorite</i> item in left menu and type in a name
          (mandatory), an URL (mandatory) and an optional description. Favorites
          do not have a private/public status, thus you have to be aware in
          which folder you add your favorite. If it's added in a private folder,
          you will be the only one seeing this and if you select a public, it's
          available for anyone. Select your parent folder and click on <i>ok</i>
          button to create it.</p>

          <p align="justify">If an URL changes, you want to make a private
          folder public, etc. you have to update your current information. This
          is done pretty easily, just by clicking on the small pen and paper
          symbol (<img border="0" src="images/editable.gif" alt="pen and paper symbol" align="absmiddle" width="18" height="17">).
          You will enter a page looking like the one you use to create a folder
          or a favorite. Make your changes, e.g. select a new parent group and
          click on <i>ok</i> button to update.</p>

          <p align="justify">Obsolete links or folder have to be deleted
          somehow. This is done by marking them in the tree and clicking <i>delete</i>
          button.</p>

          <p align="justify">&nbsp;</p>

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