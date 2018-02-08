PART ONE: FORM AND CGI/PERL BASICS

ISINDEX
<HTML>
<HEAD>
<TITLE>ISINDEX Example</TITLE>
<ISINDEX ACTION="http://www.example.com/cgi-bin/search.cgi">
</HEAD>
<BODY>
You can enter a description of what you're searching here.
</BODY>
</HTML>

FORM TAG ATTRIBUTES
The ACTION attribute accepts a URL, usually the URL for a CGI program that will process the data the user enters in the form. If you omit the ACTION attribute, the form is submitted to the page that created it.
ENCTYPEENCTYPE specifies how the form element values will be encoded. The default value is application/x-www-form-urlencoded.
The METHOD attribute specifies which method returns the data to the Web server.
TARGET If you want to direct the output of the form to another frame or window, you can use the TARGET attribute, which can include not only window names but also the built-in target values such as top, parent, and self.

INPUT TYPE
<FORM ACTION="/cgi-bin/search.cgi" METHOD=GET>
<P>
Search for: <INPUT TYPE="text" NAME="terms">
</P>
<INPUT TYPE="submit" VALUE="Submit Form">
<INPUT TYPE="reset" VALUE="Reset Form">
</FORM>

RADIO, CHECKBOX
<FORM ACTION="/cgi-bin/subscribe.cgi" METHOD=GET>
<P>
What is your name:
<INPUT TYPE="text" NAME="username" SIZE=25 MAXLENGTH=40>
<INPUT TYPE="password" NAME="userpassword" SIZE="10" MAXLENGTH="10">
</P>
<P>
What is your title?<BR>
<INPUT TYPE="radio" NAME="title" VALUE="CEO"> Chief Executive Officer<BR>
<INPUT TYPE="radio" NAME="title" VALUE="CIO"> Chief Information Officer<BR>
<INPUT TYPE="radio" NAME="title" VALUE="clerk" CHECKED> Mail Clerk<BR>
</P>
<P>
What products do you recommend or purchase?<BR>
<INPUT TYPE="checkbox" NAME="software" VALUE="ON"> Software<BR>
<INPUT TYPE="checkbox" NAME="computers" VALUE="ON"> Computers<BR>
<INPUT TYPE="checkbox" NAME="supplies" VALUE="ON"> Office supplies<BR>
</P>
<INPUT TYPE="submit" VALUE="Submit Form">
</FORM>

IMAGE (RETURNS X,Y COORD)

<INPUT TYPE="image" NAME="submitimage" SRC="submit.gif"
HEIGHT=50 WIDTH=100 ALT="Submit">

MISCELLANEOUS

<INPUT TYPE="hidden" NAME="site-section" VALUE="headlines">

<FORM ACTION="/cgi-bin/comments.cgi">
Please enter your comments below: <BR>
<TEXTAREA NAME="comments" ROWS=5 COLS=20 WRAP="physical">
Your comments.
</TEXTAREA>
<INPUT TYPE="submit" VALUE="Submit Comments">
</FORM>

SELECT

<FORM ACTION="/cgi-bin/select.cgi">
What kind of pet do you have? <BR>
<SELECT SIZE=1 NAME="pet">    (THE 1 MEANS IT IS A PULL-DOWN MENU)
     <OPTION VALUE="dog">Dog
     <OPTION VALUE="cat">Cat
     <OPTION VALUE="lemur" SELECTED>Lemur
     <OPTION VALUE="budgie">Budgie
</SELECT><P>
What continents have you been to? <BR>
<SELECT SIZE=3 NAME="continents" MULTIPLE>
    <OPTION VALUE="northamerica">North America
    <OPTION VALUE="southamerica">South America
    <OPTION VALUE="asia">Asia
    <OPTION VALUE="europe">Europe
    <OPTION VALUE="antarctica">Antarctica
    <OPTION VALUE="australia">Australia
    <OPTION VALUE="africa">Africa
</SELECT>
</FORM>

SELECT MULTIPLE

What continents have you been to? <BR>
<SELECT SIZE=3 NAME="continents" MULTIPLE>
    <OPTION VALUE="northamerica">North America
    <OPTION VALUE="southamerica">South America
    <OPTION VALUE="asia">Asia

ENCODING TO CGI

The default for the ENCTYPE attribute isapplication/x-www-form-urlencoded. 
URL-encoded data is a single string made up of the names and values of each item in the form. 
A string of data that can be added to the end of a URL
Kenny Wrightwell, and today's date, 11/7/98  THIS EQUALS: username=Kenny+Wrightwell&date=11%2F7%2F98 
using the TEXTAREA tag, the hexadecimal code %0D%0A%0A is used to replace line endings 
ALTERNATIVE ENCODING 

The other encoding format is multipart/form-data.
multipart/form-data encoding type makes it possible to send large chunks of data such as images, program executables, compressed files, or other binary files to the server.
Content-Disposition: form-data; name="username"

Kenny Wrightwell
 —  —  —  —  —  —  —  —  —  —  —  —  —  — 031144697856008
Content-Disposition: form-data; name="date"

11/7/98

GET/PUT  (GET IS NOT SECURE)
GET AND POST USUSALLY BOTH WORK: HOWEVER, GET: (BOOKMARKS AND LINKS (E.G.,LATEST STOCK QUOTES) AND POST (INPUT FIELDS) AND (PRIVACY)
GET method is used simply to request a document from the Web server, whereasPOST is actually used to post, or send, data to the Web server to be processed.
GET method is the easiest request method; it simply requests a document 

The Web server knows to send everything after the question mark to the CGI scriptexample.cgi for processing.  QUERY_STRING. :
GET HTTP/1.0 /cgi-bin/example.cgi?username=Kenny+Wrightwell&date=11%2F7%2F98%2F

POST method, which sends the form data back to the server after the headers are sent

POST HTTP/1.0 /cgi-bin/example.cgi
Content-type: application/x-www-form-urlencoded
Content-length: 45
... other optional header lines ...

username=Kenny+Wrightwell&date=11%2F7%2F98%2F

EXAMPLE: SCRIPTING A FORM
<FORM ACTION="/cgi-bin/getreg.cgi" METHOD="GET">
<P>Name: <INPUT TYPE="text" SIZE=40 MAXLENGTH=40 NAME="username"></P>
<P><INPUT TYPE="submit" VALUE="Register"></P>
</FORM>

NEXT: ENSURE FORM IS EXECUTABLE FOR PUBLIC: chmod 755 your_file_name


















EXAMPLE: CGI SCRIPT IN GET FORM
#!/usr/bin/perl  This line simply tells the script where the Perl interpreter is on the server, and that the program is a Perl program
($field_name, $user_name) = split (/=/, $ENV {'QUERY_STRING'});  split function takes the contents of the environment variable QUERY_STRING and splits it into two variables (with the = sign being the point where it splits), $field_name and$user_name
$user_name =~ s/\+/" "/eg; binding operator =~ is used to set a variable equal to a pattern match, substitution, or translation. The code below uses the binding operator to replace the plus signs in $_ with spaces, and then set the variable $user_name to $_. 
s/// is used to perform substitutions. The e flag indicates that the replacement string should be evaluated as an expression, instead of a normal string. In this case it means that the " " should be treated as to its meaning in context, a blank space, instead of the actual double quotes characters. The g flag indicates that the substitution is global. Every time the first expression is found, it is replaced, not just the first time.
print "Content-type: text/html", "\n\n";   In order to let the browser know what type of data the server is sending with its response, the CGI program includes the Content-type header line along with the data that it returns. As you can see from the line of code, the content that you're going to send to the browser is of typetext/html. The "\n\n" expression sends two carriage returns. The extra carriage return sends a blank line in order to let the browser know that the server is finished sending header information.
print "<HTML>\n<HEAD>\n<TITLE>Registration Results</TITLE>\n</HEAD>\n";
print "<BODY>\n";
print "<P><FONT SIZE=5>Hey, ", $user_name, ", thanks for registering!</FONT></P>";
The remaining print statements send the actual HTML to be displayed in the browser. The third print statement includes the contents of the $user_name variable, which print the data that the user entered in the form when the page is rendered
print "</BODY>\n</HTML>";

POST VERSION OF THE PREVIOUS CGI SCRIPT (The POST method uses the program's standard input to send data rather than using an environment variable. )
#!/usr/bin/perl
$size_of_posted_information = $ENV{'CONTENT_LENGTH'};   a Content-type(usually application/x-www-form-urlencoded) and Content-length are sent as headers, along with the data entered in the form.
read (STDIN, $posted_information, $size_of_posted_information);  This line assigns the CONTENT_LENGTH environment variable to the $size_of_posted_informationvariable, which increases the readability of our code.
 To use the data that was posted, we use the read function to copy the data fromSTDIN (standard input) to the variable $posted_information.  
($field_name, $user_name) = split (/=/, posted_information);    
$posted_information variable is used instead of theQUERY_STRING environment variable.
$user_name =~ s/\+/" "/eg;
print "Content-type: text/html", "\n\n";
print "<HTML>\n<HEAD>\n<TITLE>Registration Results</TITLE>\n</HEAD>\n";
print "<BODY>\n";
print "<P><FONT SIZE=5>Hey, ", $user_name, ", thanks for registering!</P>";
print "</BODY>\n</HTML>";


EXTRA PATH INFORMATION (STARTS WITH /HEADLINES…( File locations appended to the URL after the path to a CGI script)

<A HREF=/cgi-bin/showstory.cgi/headlines/bignews.txt">Big news!</A> 

HEADER INFORMATION
The header information is automatically stored in environment variables (like PATH_INFO andPATH_TRANSLATED) when a request is received by the server.
You can use headers to send personalized information to the user, to send specific pages based on the browser they're using, or to keep detailed logs of the people who visit your site

ENVIRONMENT  VARIABLES
To use the information from the headers, you simply access the environment variables from your CGI scripts. 
EXAMPLE PERL SCRIPT THAT CREATES A WEB PAGE SHOWING THE VALUES OF THESE VARIABLES…
#!/usr/bin/perl

print "Content-type: text/html", "\n\n";
print "<HTML>\n",
print "<HEAD><TITLE>Web Servers spy on you</TITLE></HEAD>\n";
print "<BODY>\n";
print "<HR><PRE>";
print "CONTENT_TYPE            ", $ENV{'CONTENT_TYPE'}, "\n";
print "CONTENT_LENGTH          ", $ENV{'CONTENT_LENGTH'}, "\n";
print "HTTP_ACCEPT             ", $ENV{'HTTP_ACCEPT'}, "\n";
print "HTTP_REFERER            ", $ENV{'HTTP_REFERER'}, "\n";
print "HTTP_USER_AGENT         ", $ENV{'HTTP_USER_AGENT'}, "\n";
print "PATH_INFO               ", $ENV{'PATH_INFO'}, "\n";
print "PATH_TRANSLATED         ", $ENV{'PATH_TRANSLATED'}, "\n";
print "QUERY_STRING            ", $ENV{'QUERY_STRING'}, "\n";
print "REMOTE_ADDR             ", $ENV{'REMOTE_ADDR'}, "\n";
print "REMOTE_HOST             ", $ENV{'REMOTE_HOST'}, "\n";
print "REQUEST_METHOD          ", $ENV{'REQUEST_METHOD'}, "\n";
print "</PRE><HR>\n";
print "</BODY>\n</HTML>\n";
print "CONTENT_TYPE            ", $ENV{'CONTENT_TYPE'}, "\n";   (SAME AS ENCTYPE)
print "CONTENT_LENGTH          ", $ENV{'CONTENT_LENGTH'}, "\n";
print "HTTP_ACCEPT             ", $ENV{'HTTP_ACCEPT'}, "\n";  (LIST OF CONTENT TYPES ACCEPTED)
print "HTTP_REFERER            ", $ENV{'HTTP_REFERER'}, "\n"; (it can track Internet pages linked to your site.)
print "HTTP_USER_AGENT         ", $ENV{'HTTP_USER_AGENT'}, "\n"; WEB USER’S BROWSER
print "PATH_INFO               ", $ENV{'PATH_INFO'}, "\n";
print "PATH_TRANSLATED         ", $ENV{'PATH_TRANSLATED'}, "\n"; INFO ABOUT THE WEB SERVER’S ROOT
print "QUERY_STRING            ", $ENV{'QUERY_STRING'}, "\n";
print "REMOTE_ADDR             ", $ENV{'REMOTE_ADDR'}, "\n"; (This variable contains the IP address of the computer connecting to your site.
print "REMOTE_HOST             ", $ENV{'REMOTE_HOST'}, "\n"; HOSTNAME OF THE USER’S COMPUTER
print "REQUEST_METHOD          ", $ENV{'REQUEST_METHOD'}, "\n"; 

SCRIPTING TO MULTIPLE WEBSITES (EXAMPLE OF DETERMINING USER’S BROWSER) to send them appropriately
#!/usr/bin/perl

$web_browser = substr($ENV{'HTTP_USER_AGENT'},0,7);
if ($web_browser eq "Mozilla") {
     print "Location: /netscape.html\n\n";
}
else {
     print "Location: /notnetscape.html\n\n";
}






PART TWO: BUILDING PROGRAMS

Internet is referred to as a TCP/IP network
1	If the URL entered in the Web browser was http://www.example.com, the first thing the client computer would do is perform a DNS (Domain Name Service) lookup on the name of machine in the URL (the contents of a URL were discussed in detail in an earlier course).
2	A DNS lookup is basically equivalent to looking up a phone number in a telephone book. The DNS server then converts the hostname in the URL into an IP address. Every computer on the Internet has a unique IP address, consisting of four numbers between 0 and 255. An example of an IP address is 192.9.200.155.
3	If the name is successfully looked up by the DNS server, the client will try to connect to the Web server using TCP; if the DNS lookup fails, the HTTP request will fail.
4	If you are connecting to a Web server over the Internet, chances are the request will travel through a number of routers in the process of connecting to the destination Web server. Routers are computers that connect independent networks to one another.
5	If the TCP connection is made, then the HTTP session itself can start, and the server will begin sending data to the client. If the Web server is unreachable, the HTTP request will fail.

FIRST COMMAND FROM BROWSER TO SERVER: METHOD, PATH, HTTP VERSION
GET /cgi-bin/vote.cgi HTTP/1.0

SAME THING WITH FORM DATA:
GET HTTP/1.0 /cgi-bin/example.cgi?username=Rafe+Colburn&date=9%2F7%2f98%2F

FIRST SERVER RESPONSE
HTTP/1.0 200 OK  <-MEANS STATUS OK, OTHERWISE, 404 NOT FOUND

TYPICAL RESPONSE HEADER:
Date: Tue, 26 Aug 1997 00:45:46 GMT
Server: Apache/1.2.4
Last-Modified: Thu, 14 Aug 1997 15:17:43 GMT
Content-Length: 7437
Content-Type: text/html

200 OK	Hopefully, the 200 OK is the most common response used by your Web site. It means that the client's request was successful, and that the requested document is being sent back to the user with this response.
401 Unauthorized	When a site is set up to use authentication, and the user fails to enter the correct user name and password, they are greeted with the 401 Unauthorized response.
403 Forbidden	The 403 Forbidden code is a generic response code that the server sends when the request can't be fulfilled but the server doesn't know why, or does know why but isn't allowed to tell. You will often see this response when the requested document file permissions are set up incorrectly, and the Web server can't read the file, or in the case of CGI scripts, it doesn't have permission to execute the file.
404 Not Found	The 404 Not Found response code indicates that the document you are requesting is no longer at the requested URL. Since many users never see the 200 OK status code when it is sent, the 404 is probably the most recognized response code on the World Wide Web, and has, in fact, attained pop culture status.
500 Internal Server Error	Another common error response code is 500 Internal Server Error. When a Web server is misconfigured, or there's a problem with a CGI script, the 500 is the error response code typically sent to the user.

MIME,Multipurpose Internet Mail Extensions. a common system (standard) of file types is used.

Each time you write a CGI script, be sure that it sends the appropriate Content-type header so that the browser can handle the content correctly.

The most common standard for providing secure connections over the Internet is the Secure Sockets Layer, or SSL protocol. THIS IS AN APPLICATION LEVEL PROTOCOL LIKE HTTP (SSLis Publickey)

SSL servers generally run on TCP port 443 instead of the default for HTTP, port 80.


PART THREE:  SERVER SIDE INLUDES 

Unlike CGI programs, which are generally set apart in their own directory
(cgi-bin), SSI pages are located in your Web directories with your regular HTML pages.

SSI files have specific extensions, including.shtml and .stm, that differentiate them from HTML files.
When an SSI page is requested by a user, the Web server reads the file and interprets the directives in the file.  It then puts the results of each directive into the file, in place of the original directive.
The basic format for SSI directives is as follows:

<!--#command parameter="argument"--> 

LAST MODIFIED DIRECTIVE:
 
OTHER DIRECTIVES: 
<!--#echo var="variable_name"--> (CAN BE ANY ENVIRONMENT VARIABLE DEFINED IN SERVER.)
DOCUMENT_NAME	The filename of the current document.
DOCUMENT_URI	The file path of the current document.
QUERY_STRING_UNESCAPED	The query string sent with the request, decoded with all shell characters escaped using the backslash character.
DATE_LOCAL	The current date according to the server's clock.
OTHER DIRECTIVES: 
<!--#echo var="variable_name"--> (CAN BE ANY ENVIRONMENT VARIABLE DEFINED IN SERVER.)
#include directive to insert the contents of a text file directly into a document.
<!--#include file="weather.txt"-->
<!--#include virtual="/reports/weather.txt"-->
<!--#fsize file="visitor.log"-->
The #exec directive inserts the output of an external program into the page.
To insert the output from the who command into your Web page, include the following directive in your page:
<!--#exec cmd="/usr/bin/who"-->

The #config directive doesn't insert content into your Web page, but rather specifies the format that other directives use for their output.
<P><!--#config timefmt="%r on %A, %B %e"-->
This is an example of a configured date:<BR>
<!--#flastmod file="config.shtml"--></P>

Timefmt Parameter Codes:
%a	Mon	Abbreviated day of the week
%A	Monday	Day of the week
%b, %h	Aug	Abbreviated month name
%B	August	Month name
%d	01	Day
%D	08/01/97	Numerical date
%e	1	Day without the leading zero
%H	18	Hour (in 24-hour format)
%I	07	Hour (in 12-hour format)
%j	365	Day of the year
%m	08	Month number
%M	55	Minutes
%p	AM	AM or PM
%r	08:17:59 AM	12-hour time string
%S	31	Seconds
%T	18:25:31	24-hour time
%U, %W	26	Week of the year
%w	7	Numerical day of the week (starts on Sunday)
%y	97	Two-digit year
%Y	2000	Four-digit year
%Z	EDT	Time zone








PART FOUR: USING SERVER SIDE INCLUDES

#INCLUDE
Instead of including identical blocks of HTML code in every page on the site (or even in most of them), it's a lot easier to use the same #include directive in every page to link to one block of code.
you're only going to see a single HTML document here, but you can use the#include directive in any number of documents on your site to link to the included file.
 
INCLUDED.HTML:	(CAN ALSO INCLUDE IMAGES, LINKS)
<HR WIDTH=70%> <P ALIGN=CENTER>
<B><A HREF="home.html">home</A> |
<A HREF="toc.html">table of contents</A> |
<A HREF="search.html">search</A></B>
<P ALIGN=CENTER>
All contents of this site are copyright© 1998.
 




USING #EXEC CMD (EMPLOYING UNIX COMMANDS INTO WEB PAGES:
 
Another: <!--#exec cmd=”/bin/usr/who”--> (TO LIST WHO)
<!--#printenv --> THIS PRINTS ALL THE ENVIRONMENT VARIABLES ONTO THE SCREEN
<!--#set var="color" value="blue" --> THIS ASSIGNS A VALUE TO A VARIABLE

IF DIRECTIVES:
#if	The #if directive tests to see whether a condition is true, and if it is, the HTML following the XSSI directive is displayed.
#elif	The #elif directive is only executed if the previous if directive was false. If so, the elif directive is executed as though it were a normalif directive .
#else	The HTML following an #else directive is displayed if the previous if(or #elif) directive was false.
#endif	The #endif directive indicates the end of an if statement (or a group of #if, #elif, and #else directives).

EG  (backslashes are used in the first two directives to escape the internal quotation marks so that they're not interpreted as ending the expression)
<!--#if expr="$color = \"blue\""-->
<P>The color is blue.</P>
<!--#elif expr="$color = \"red\""-->
<P>The color is red.</P>
<!--#else-->
<P>I don't know what the color is.</P>
<!--#endif-->
EG: TEST CONDITIONS AND COMPARISONS
(string)	Returns true if string exists.
string1 = string2	Returns true if the two strings are identical.
string1 != string2	Returns true if the two strings are not identical.
string1 < string2	Returns true if the first string is smaller than the second one.
string1 <= string2	Returns true if string1 is smaller than or identical to string2.
string1 > string2	Returns true if string1 is larger than string2.
string1 >= string2	Returns true if string1 is identical to or larger than string2.


LOGICAL EXPRESSIONS
Expression	Tests
!string	! is the NOT operator. It reverses the truth of the condition. So (!string) returns true if string doesn't exist. Or, !(string1 = string2) returns the same result as string1 != string2.
(string1) && (string2)	&& is the AND operator. Both of the two conditions being tested must be true for the entire expression to be true. In this example, both string1 and string2 would have to exist for the expression to be true.
(string1) || (string2)	|| is the OR operator. If one or both of the expressions evaluate as being true, the entire expression is true. In the example, if eitherstring1 or string2 exists, it returns true.

ANOTHER EXAMPLE
<!--#if expr="\"$DOCUMENT_NAME\" = \"index.html\""-->
This is the root directory of the Web server.
<!--#else-->
This is not the root directory of the Web server.
<!--#endif-->

CREATING AN ONLINE SURVEY

<HTML>
<HEAD>
<TITLE>Web Site User Survey</TITLE>
</HEAD>
<BODY>
<FORM ACTION="/cgi-bin/dosurvey.cgi" METHOD=post>
<TABLE BORDER=0>
<TR>
  <TD ALIGN="right">User name:</TD>
  <TD><INPUT TYPE="text" SIZE=40 MAXSIZE=60 NAME="user_name"></TD>
</TR>
<TR>
  <TD ALIGN="right">Email address:</TD>
  <TD><INPUT TYPE="text" SIZE=40 MAXSIZE=60 NAME="email_address"></TD>
</TR>
<TR>
  <TD ALIGN="right">Telephone number:</TD>
  <TD><INPUT TYPE="text" SIZE=13 MAXSIZE=13 NAME="tel_number"></TD>
</TR>
<TR>
  <TD ALIGN="right">Favorite color:</TD>
  <TD><SELECT NAME="fav_color">
      <OPTION VALUE="red">Red
      <OPTION VALUE="green">Green
      <OPTION VALUE="blue">Blue
      </SELECT></TD>
</TR>
<TR>
  <TD ALIGN="right">Interests:</TD>
  <TD><INPUT TYPE="checkbox" NAME="bicycles" VALUE="yes">Bicycles<BR>
      <INPUT TYPE="checkbox" NAME="cereal" VALUE="yes">Breakfast cereal<BR>
      <INPUT TYPE="checkbox" NAME="pomo" VALUE="yes">Postmodern architecture<BR>
  </TD>
</TR>
<TR>
  <TD><BR></TD>
  <TD><INPUT TYPE="SUBMIT" VALUE="Submit survey"></TD>
</TR>
</TABLE>
</FORM>
</BODY>
</HTML>

THE ENCODED DATA WOULD THEN BE SENT TO SERVER IN THIS FORM: 

POST /cgi-bin/dosurvey.pl HTTP/1.0
Content-type: application/x-www-form-urlencoded

user_name=CGI+Developer&email_address=dev2@mycorp.com
&tel_number=713.555.1212&fav_color=green&bicycles=yes&cereal=yes

NEXT, THE SERVER …
Because you're using the POST method for submitting this form, the program is going to gather the data from STDIN using this code.

SO PERL CODE BEGINS:
$content_length = $ENV{'CONTENT_LENGTH'};
read (STDIN, $posted_information, $content_length);
Scalar variables can contain a single value, like a number or a string of characters. In this case, $content_length contains the number of characters in the input, and$posted_information is the string of characters in the encoded data.
THEN, DECODING: 
$posted_information =~ s/%([\dA-Fa-f][\dA-Fa-f])/pack ("C", hex ($1))/eg;
$posted_information =~ s/\+/ /g;
You're going to take care of this with a couple of lines of Perl. While this program will decode the encoded information, you don't ordinarily have to do this. There are CGI libraries for most languages that will take care of this grunt work for you.
The first line of Perl code looks for a string that contains a percent sign and two hexadecimal numbers. When characters are encoded using URL encoding, they are translated to their hexadecimal value.
	The "C" argument from the pack command indicates that the encoded hexadecimal value should be converted to an unsigned character, or, in other words, back to the ASCII character that it originally was.
	The second line searches the string for the + sign. Anywhere it appears, a space is inserted instead.
NEXT, FORMAT INTO ARRAYS:
@fields = split (/&/, $posted_information);
Array variables contain more than one scalar value and are prepended with an @ sign. In the code shown here, the split function searches through the form data for the & character. Each time it finds one, it puts the characters up to that point into the next element of the @fields array. If the form data were
user_name=CGI+Developer&email_address=dev2@mycorp.com&
tel_number=713.555.1212&fav_color=green&bicycles=yes&cereal=yes
then the @fields array would be
("user_name=CGI+Developer", "email_address=dev2@mycorp.com",
"tel_number=713.555.1212", "fav_color=green", "bicycles=yes, " "cereal=yes")
NEXT, ASSIGNING ARRAYS TO BE VARIABLES:
@fields = split (/&/, $posted_information);

($label, $user_name) = split (/=/, $fields[0]);
($label, $email_address) = split (/=/, $fields[1]);
($label, $tel_number) = split (/=/, $fields[2]);
($label, $fav_color) = split (/=/, $fields[3]);




NEXT, CHECKBOX DATA IS RESOLVED: 
($bicycles, $cereal, $pomo) = (0, 0, 0);

foreach $value (@fields) {
    if ($value =~ /bicycles/) {
        $bicycles = 1;
    }
    elsif ($value =~ /cereal/) {
        $cereal = 1;
    }
    elsif ($value =~ /pomo/) {
        $pomo = 1;
    }
}
NEXT, VALIDATION BEGINNING WITH E-MAIL
@check_email = split (//, $email_address);
foreach $letter (@check_email) {
    if ($letter eq "@") {
        $good_email = 1;
        last;  THE LAST BREAKS OUT OF LOOP
    }
}
The current element of the array is assigned to the variable that's specified; in this case,$letter. These loops make it easy to evaluate every element in an array individually.
	A foreach loop is executed one time for each element in the array in parentheses.
In the example, it is executed once for each member of the @check_email array.
VALIDATION OF TELEPHONE
@check_tel_number = split (//, $tel_number);
$digits = 0;
foreach $number (@check_tel_number) {
    if ($number =~ /\d/) {
        $digits++;
    }
}

if ($digits == 10) {
    $good_tel_number = 1;
}
The code that does this is a foreachloop that examines each character the user has entered in the Telephone Number field and counts the number of characters that are digits between 0 and 9.
RESPONSE TO USER, FIRST PART IS COMMON DATA
Before the program decides whether to send a new form (or acknowledge that the data is correct and store it on disk), it sends the header data that's common to both alternatives.
print "Content-type: text/html", "\n\n";
print "<HTML>\n<HEAD>\n";
SECOND PART IS CHECKING GOOD DATA
if (!$good_email | !$good_tel_number) {
SO, IF EITHER IS INVALID, HERE’S THE CODE TO BE SENT BACK:
print "<TITLE>Invalid Data</TITLE>\n<BODY>\n";
    print "<H2>Invalid data</H2>\n";
    print "<P>You entered invalid data in the form, please correct \n";
    print "the data in the fields with red labels. </P>\n";
    print "<FORM ACTION=\"dosurvey.cgi\" METHOD=post>\n";
    print "<TABLE BORDER=0>\n<TR>\n<TD ALIGN=RIGHT>User name:</TD>\n";
    print "<TD><INPUT TYPE=\"text\" SIZE=40 MAXSIZE=60 NAME=\"user_name\" VALUE=\"$user_name\"></TD>\n</TR>\n";
    print "<TR>\n";
    if (!$good_email) {
        print "<TD ALIGN=right><FONT COLOR=#FF0000><B>Email address:</B></FONT></TD>\n";
    }
    else {
        print "<TD ALIGN=right>Email address:</TD>\n";
    }
    print "<TD><INPUT TYPE=\"text\" SIZE=40 MAXSIZE=60 NAME=\"email_address\" VALUE=\"$email_address\"></TD>\n</TR>\n";
    if (!$good_tel_number) {
        print "<TR>\n<TD ALIGN=right><FONT COLOR=#FF0000><B>Telephone number:</B></FONT></TD>\n";
    }
    else {
        print "<TR>\n<TD ALIGN=right>Telephone number:</TD>\n";
    }
    print "<TD><INPUT TYPE=\"text\" SIZE=13 MAXSIZE=13 NAME=\"tel_number\" VALUE=\"$tel_number\"></TD>\n</TR>\n";
    print "<TR>\n<TD ALIGN=right>Favorite color:</TD>\n";
    print "<TD><SELECT NAME=\"fav_color\">\n";
    if ($fav_color eq "red") {
        print "<OPTION VALUE=\"red\" SELECTED>Red\n<OPTION VALUE=\"blue\">Blue\n<OPTION VALUE=\"green\">Green\n</SELECT>\n";
    }
    elsif ($fav_color eq "blue") {
        print "<OPTION VALUE=\"red\">Red\n<OPTION VALUE=\"blue\" SELECTED>\n<OPTION VALUE=\"green\">Green\n</SELECT>\n";
    }
    elsif ($fav_color eq "green") {
        print "<OPTION VALUE=\"red\">Red\n<OPTION VALUE=\"blue\">Blue\n<OPTION VALUE=\"green\" SELECTED>Green\n</SELECT>\n";
    }
    print "<TR>\n<TD ALIGN=\"right\">Interests:</TD>\n";
    print "<TD><INPUT TYPE=\"checkbox\" NAME=\"bicycles\" VALUE=\"yes\" ";
    if ($bicycles == 1) {
        print "CHECKED";
    }
    print ">Bicycles<BR>\n<INPUT TYPE=\"checkbox\" NAME=\"cereal\" VALUE=\"yes\" ";
    if ($cereal == 1) {
        print "CHECKED";
    }
    print ">Breakfast cereal<BR>\n<INPUT TYPE=\"checkbox\" NAME=\"pomo\" VALUE=\"yes\" ";
    if ($pomo == 1) {
        print "CHECKED";
    }
    print ">Postmodern architecture<BR></TD>\n</TR>\n";
    print "<TR>\n<TD><BR></TD>\n<TD><INPUT TYPE=\"SUBMIT\" VALUE=\"Submit survey\"></TD>\n</TR>\n";
    print "</TABLE>\n</FORM>\n";
IF BOTH ARE VALID, THEN: 
else {
    print "<TITLE>Thank you</TITLE>\n<BODY>\n";
    print "<P>Thanks for filling out the form!</P>\n";
    open (OUTPUT, ">> /tmp/surveyrecord.txt");
    print OUTPUT $user_name, ":", $email_address, ":", $tel_number, ":", $fav_color, ":", $bicycles, $cereal, $pomo, "\n";
    close (OUTPUT);
}


CODE FOR ENTIRE CGI/PERL PROGRAM: 

#!/usr/bin/perl

$content_length = $ENV{'CONTENT_LENGTH'};
read (STDIN, $posted_information, $content_length);

$posted_information =~ s/%([\dA-Fa-f][\dA-Fa-f])/pack ("C", hex ($1))/eg;
$posted_information =~ s/\+/ /g;

@fields = split (/&/, $posted_information);

 ($label, $user_name) = split (/=/, $fields[0]);
($label, $email_address) = split (/=/, $fields[1]);
($label, $tel_number) = split (/=/, $fields[2]);
($label, $fav_color) = split (/=/, $fields[3]);

 ($bicycles, $cereal, $pomo) = (0, 0, 0);

foreach $value (@fields) {
    if ($value =~ /bicycles/) {
        $bicycles = 1;
    }
    elsif ($value =~ /cereal/) {
        $cereal = 1;
    }
    elsif ($value =~ /pomo/) {
        $pomo = 1;
    }
}

@check_email = split (//, $email_address);
foreach $letter (@check_email) {
    if ($letter eq "@") {
        $good_email = 1;
        last;
    }
}

@check_tel_number = split (//, $tel_number);
$digits = 0;
foreach $number (@check_tel_number) {
    if ($number =~ /\d/) {
        $digits++;
    }
}

if ($digits == 10) {
    $good_tel_number = 1;
}

print "Content-type: text/html", "\n\n";
print "<HTML>\n<HEAD>\n";

if (!$good_email | !$good_tel_number) {
    print "<TITLE>Invalid Data</TITLE>\n<BODY>\n";
    print "<H2>Invalid data</H2>\n";
    print "<P>You entered invalid data in the form, please correct \n";
    print "the data in the fields with red labels. </P>\n";
    print "<FORM ACTION=\"dosurvey.cgi\" METHOD=post>\n";
    print "<TABLE BORDER=0>\n<TR>\n<TD ALIGN=RIGHT>User name:</TD>\n";
    print "<TD><INPUT TYPE=\"text\" SIZE=40 MAXSIZE=60 NAME=\"user_name\" VALUE=\"$user_name\"></TD>\n</TR>\n";
    print "<TR>\n";
    if (!$good_email) {
        print "<TD ALIGN=right><FONT COLOR=#FF0000><B>Email address:</B></FONT></TD>\n";
    }
    else {
        print "<TD ALIGN=right>Email address:</TD>\n";
    }
    print "<TD><INPUT TYPE=\"text\" SIZE=40 MAXSIZE=60 NAME=\"email_address\" VALUE=\"$email_address\"></TD>\n</TR>\n";
    if (!$good_tel_number) {
        print "<TR>\n<TD ALIGN=right><FONT COLOR=#FF0000><B>Telephone number:</B></FONT></TD>\n";
    }
    else {
        print "<TR>\n<TD ALIGN=right>Telephone number:</TD>\n";
    }
    print "<TD><INPUT TYPE=\"text\" SIZE=13 MAXSIZE=13 NAME=\"tel_number\" VALUE=\"$tel_number\"></TD>\n</TR>\n";
    print "<TR>\n<TD ALIGN=right>Favorite color:</TD>\n";
    print "<TD><SELECT NAME=\"fav_color\">\n";

    if ($fav_color eq "red") {
        print "<OPTION VALUE=\"red\" SELECTED>Red\n<OPTION VALUE=\"blue\">Blue\n<OPTION VALUE=\"green\">Green\n</SELECT>\n";
    }
    elsif ($fav_color eq "blue") {
        print "<OPTION VALUE=\"red\">Red\n<OPTION VALUE=\"blue\" SELECTED>\n<OPTION VALUE=\"green\">Green\n</SELECT>\n";
    }
    elsif ($fav_color eq "green") {
        print "<OPTION VALUE=\"red\">Red\n<OPTION VALUE=\"blue\">Blue\n<OPTION VALUE=\"green\" SELECTED>Green\n</SELECT>\n";
    }
    print "<TR>\n<TD ALIGN=\"right\">Interests:</TD>\n";
    print "<TD><INPUT TYPE=\"checkbox\" NAME=\"bicycles\" VALUE=\"yes\" ";
    if ($bicycles == 1) {
        print "CHECKED";
    }
    print ">Bicycles<BR>\n<INPUT TYPE=\"checkbox\" NAME=\"cereal\" VALUE=\"yes\" ";
    if ($cereal == 1) {
        print "CHECKED";
    }
    print ">Breakfast cereal<BR>\n<INPUT TYPE=\"checkbox\" NAME=\"pomo\" VALUE=\"yes\" ";
    if ($pomo == 1) {
        print "CHECKED";
    }
    print ">Postmodern architecture<BR></TD>\n</TR>\n";
    print "<TR>\n<TD><BR></TD>\n<TD><INPUT TYPE=\"SUBMIT\" VALUE=\"Submit survey\"></TD>\n</TR>\n";
    print "</TABLE>\n</FORM>\n";
}
else {
    print "<TITLE>Thank you</TITLE>\n<BODY>\n";
    print "<P>Thanks for filling out the form!</P>\n";
    open (OUTPUT, ">> /tmp/surveyrecord.txt");
    print OUTPUT $user_name, ":", $email_address, ":", $tel_number, ":", $fav_color, ":", $bicycles, $cereal, $pomo, "\n";
    close (OUTPUT);
}

print "</BODY>\n</HTML>";

NEW PROGRAM SCENARIO that translates a text file into an html, graphic template for website.
#!/usr/bin/perl      This invokes Perl interpreter and sends header information:
print "Content-type: text/html", "\n\n";
print "<HTML>\n<HEAD>\n<TITLE>The Daily Misleader</TITLE>\n</HEAD>\n";
print "<BODY>\n<H1>The Daily Misleader</H1>\n<BLOCKQUOTE>\n";
NOW, THE TRANSLATER:
$first_line = 1;
$story = $ENV{'PATH_TRANSLATED'};
if ($story =~ /\.\./) {
  print ("<P>Paths that include .. are a security risk.</P> \n");
}
else {
  if (open (INPUT, "< $story")) {
THIS PART CONVERTS FROM TEXT TO HTML:

  while (<INPUT>) {
      chop;
      if ($first_line) {
        print "<H1>", $_, "</H1>\n";
        $first_line=0;
      }
      elsif ($_ eq "") {
        print "<P>\n";
      }
      else {
        print $_, "\n";
      }
    }

<A HREF="/cgi-bin/showstry.cgi?chick.txt">. THIS IS THELINK THAT LEADS TO THE TEXT STORY. 
Read a story about <A HREF="/cgi-bin/showstry.cgi/chick.txt">
Chicken Little</A>.

