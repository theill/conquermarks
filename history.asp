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
          <p class="Caption">version <b>history</b></p>
          <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#000000">
            <tr>
              <td width="100%">
<table border="0" width="100%" cellspacing="1" cellpadding="4">
  <tr>
    <td nowrap valign="top" bgcolor="#999999"><strong><font color="#FFFFFF">Date</font></strong></td>
    <td width="100%" valign="top" bgcolor="#999999" align="justify"><strong><font color="#FFFFFF">Action</font></strong></td>
    <td align="center" nowrap valign="top" bgcolor="#999999"><strong><font color="#FFFFFF">Version</font></strong></td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">18.11.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      Finally decided to make an official first version. I've used the last
      couple of weeks testing the system and haven't found any bugs. I'll
      release the source code as soon as I have removed all my debug
      information.
    </td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">1.0</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">03.11.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">
      Found a wrong link in my compact version, which made Netscrape try to save
      a 'default.asp' page. If you chose not to save it, it would crash on you!
      Don't we just all love this ridicules browser?</p>
    </td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.96</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">31.10.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">A <i>compact</i> version of ConquerMarks (in a small
      window) have been added and a lot of small bugs have been fixed.</td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.95</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">30.10.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      Help section improved.</td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.93</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">29.10.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">
      You will now be able to click a link in a folder to add a link directly.</p>
    </td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.92</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">29.10.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">
      Fixed bug when updating an account with same username.</p>
    </td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.91</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">23.10.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">Child-folders are now hidden, when a folder is updated.
      This is done to prevent circular parents. Username constraint is now
      checked, i.e. you will not get an error message if you tries to use a
      username already in use by another user.</td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.90</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">17.10.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">
      New images for 'ok', 'cancel' and 'delete' buttons.</p>
    </td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.85</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">15.10.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">
      Added more checks on data written to database and separated help-page into
      multiple sections.</p>
    </td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.70</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">13.10.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">Implemented 'update account' and add a new 'general'
      bitmap.</td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.65</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">12.10.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">Partly moved menus from top to left side of screen.
      Added (not working) menu item for changing your profile, i.e. name, email,
      etc.</td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.55</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">10.10.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">
      Hierarchy and Organize pages have been merged. No need to have a these two
      separated. Added legends description on help page.</p>
    </td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.50</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">09.10.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">Implemented 'delete' methods in organize mode. 
      You are not able to delete favorites and folders by using checkboxes to 
      the left of the folder/favorite.</td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.40</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">07.10.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">Implemented 'Update favorite' and optimized
      'update' methods a little bit.</p>
    </td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.29</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF"><nobr>06.10.99</nobr></td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">Implemented 'Update folder'.</p>
    </td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.27</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF"><nobr>05.10.99</nobr></td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">Implemented 'Add Favorite'. Still needs to set
      values on e.g. expand/collapse of groups</p>
    </td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.26</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF"><nobr>04.10.99</nobr></td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">
      <p align="justify">Layout has totally changed. I'm
      trying to implement it directly into my theill.com web site and the
      popup-version has been pushed back a little bit.</p>
    </td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.25</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF"><nobr>03.10.99</nobr></td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">Created new top image
      and made initial
      templates.</td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF"><nobr>0.24</nobr></td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF">03.10.99</td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">Decided
      to skip previous implementation totally and started&nbsp;designing new
      system.</td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.00</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF"><nobr>01.06.99</nobr></td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify"><a href="mailto:cwy@forum.dk">Christian
      Yttesen</a> brought up the idea, to create a simpler version of
      ConquerMarks and <a href="http://www.rhs.dk/cwy/">implemented one</a>
      himself.</td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF"><nobr>0.23</nobr></td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF"><nobr>06.04.99</nobr></td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">Updating of different frames
    on login, logout and refresh completed.</td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.22</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF"><nobr>05.04.99</nobr></td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">Frames changed to minimize
    screen usage.</td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.21</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF"><nobr>04.04.99</nobr></td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">General pages created and
    standard images (e.g. 'add', 'cancel') painted.</td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.2</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF"><nobr>03.04.99</nobr></td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">Created <em>new user</em>
    screens and all its images.</td>
    <td valign="top" align="center" nowrap cheight="14" bgcolor="#FFFFFF">0.11</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF"><nobr>03.04.99</nobr></td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">Created <em>login</em> screens
    and all its images.</td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.1</td>
  </tr>
  <tr>
    <td valign="top" nowrap bgcolor="#FFFFFF"><nobr>02.04.99</nobr></td>
    <td width="100%" valign="top" bgcolor="#FFFFFF" align="justify">Started designing overall
    layout, graphics standard determined.</td>
    <td valign="top" align="center" nowrap bgcolor="#FFFFFF">0.06</td>
  </tr>
</table>

</td>
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