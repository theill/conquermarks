
 ConquerMarks README
 Copyright(c) Peter Theill, ConquerWare
 
 -----------------------------------------------------------------------------
 Important Info
 -----------------------------------------------------------------------------
 This archive contains  all files needed  to set up  your own online  bookmark
 manager. For an online demo of ConquerMarks, visit:
 
   http://www.theill.com/ConquerMarks/
 
 For updated information, please check the ASP section of the Theill Web
 Site:
 
 	http://www.theill.com/asp/conquermarks.asp
 
 -----------------------------------------------------------------------------
 Getting started
 -----------------------------------------------------------------------------
 Unpack all files in a directory on your webserver and place the database file
 (cmarks.mdb) in your database directory.
 
 Add this line to your global.asa file, which can be found in the root of your
 server.
 
  Application("conquermarks_ConnectionString") = 
   "DRIVER={Microsoft Access Driver (*.mdb)}; " _
    "DBQ=" & Server.MapPath("cmarks.mdb")
 
 If you need to move the database file to a special directory in order for  it
 to work, make sure you update the  lines above. E.g. if you have a  directory
 called 'databases' you will need to replace it with:
 
  Application("conquermarks_ConnectionString") = 
   "DRIVER={Microsoft Access Driver (*.mdb)}; " _
    "DBQ=" & Server.MapPath("databases/cmarks.mdb")
 
 If no global.asa file  exist on your server  a default is provided  with this
 package.
 
 
 That's it. You should be able to run it by now. Enjoy :o)
 
 
 You're very welcome to send  me a link to your  site, if you're going to  use
 ConquerMarks ...
 
 
 -----------------------------------------------------------------------------
 FAQ - Frequently Asked Questions
 -----------------------------------------------------------------------------
 Please check  the updated  Frequently Asked  Questions (FAQ)  on the web site
 before sending me a mail about problems setting up ConquerMarks.
 
 
 // >> Peter Theill, 2/10/2001 10:29AM