<?php
/*
########################################################################
W3C� SOFTWARE NOTICE AND LICENSE
http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231
This work (and included software, documentation such as READMEs, or other related items) is being 
provided by the copyright holders under the following license. By obtaining, using and/or copying 
this work, you (the licensee) agree that you have read, understood, and will comply with the following 
terms and conditions.

Permission to copy, modify, and distribute this software and its documentation, with or without modification, 
for any purpose and without fee or royalty is hereby granted, provided that you include the following on 
ALL copies of the software and documentation or portions thereof, including modifications:

    1.The full text of this NOTICE in a location viewable to users of the redistributed or derivative work.

    2.Any pre-existing intellectual property disclaimers, notices, or terms and conditions. If none exist, 
    the W3C Software Short Notice should be included (hypertext is preferred, text is permitted) within the 
    body of any redistributed or derivative code.

    3.Notice of any changes or modifications to the files, including the date changes were made. (We recommend 
    you provide URIs to the location from which the code is derived.)

THIS SOFTWARE AND DOCUMENTATION IS PROVIDED "AS IS," AND COPYRIGHT HOLDERS MAKE NO REPRESENTATIONS OR WARRANTIES, 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO, WARRANTIES OF MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR 
PURPOSE OR THAT THE USE OF THE SOFTWARE OR DOCUMENTATION WILL NOT INFRINGE ANY THIRD PARTY PATENTS, COPYRIGHTS, 
TRADEMARKS OR OTHER RIGHTS.

COPYRIGHT HOLDERS WILL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF 
ANY USE OF THE SOFTWARE OR DOCUMENTATION.

The name and trademarks of copyright holders may NOT be used in advertising or publicity pertaining to the 
software without specific, written prior permission. Title to copyright in this software and any associated 
documentation will at all times remain with copyright holders.

Copyright 2007, Michael Schrenk

THIS SCRIPT IS FOR DEMONSTRATION PURPOSES ONLY! 
    It is not suitable for any use other than demonstrating 
    the concepts presented in Webbots, Spiders and Screen Scrapers. 
########################################################################
*/?>



<?php
// Download the target file
$target = "http://www.schrenk.com/nostarch/webbots/hello_world.html";
$downloaded_page_array = file($target);

print_r($downloaded_page_array);

// Echo contents of file
for($xx=0; $xx<count($downloaded_page_array); $xx++)
    echo $downloaded_page_array[$xx];
?>
