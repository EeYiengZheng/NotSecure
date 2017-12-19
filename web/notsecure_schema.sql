-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for notsecure_eezheng
CREATE DATABASE IF NOT EXISTS `notsecure_eezheng` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `notsecure_eezheng`;

-- Dumping structure for table notsecure_eezheng.blogs
CREATE TABLE IF NOT EXISTS `blogs` (
  `blog_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `author` varchar(64) NOT NULL,
  `title` varchar(256) NOT NULL DEFAULT 'My blog',
  `content` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`blog_id`),
  KEY `FK_blogs_users` (`author`),
  FULLTEXT KEY `articles` (`title`,`content`),
  CONSTRAINT `FK_blogs_users` FOREIGN KEY (`author`) REFERENCES `users` (`username`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- Dumping data for table notsecure_eezheng.blogs: ~4 rows (approximately)
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
INSERT INTO `blogs` (`blog_id`, `author`, `title`, `content`, `created`, `updated`) VALUES
	(1, 'admin', 'Privacy Policy', '# Privacy Policy\r\n\r\nLast updated: 2017-12-18\r\n\r\n### Introduction\r\n\r\nThis page informs you of our policies regarding the collection, use and disclosure of Personal Information we receive from users of the Site.\r\n\r\nWe use your Personal Information only for providing and improving the Site. By using the Site, you agree to the collection and use of information in accordance with this policy.\r\n\r\n### Information Collection And Use\r\n\r\nWe will not request personally identifiable information that can be used to contact or identify you, *unless given by your own free will*. All information requested include a username, a password and a display name (pen name, not required to be your real name), and of which can contain any combinations of characters. Your password in its plain form is stored, but instead the *hash* of the password is stored. \r\n\r\nAll your articles are sent to, stored and retrieved from our web server. Your blog articles are public by default, and can be access by anyone with the direct URL. You can update and delete your own blogs, but you may not alter the title of the blog after creating the blog for the first time. \r\n\r\n### Technology Dependencies\r\n\r\nOur website require the use of a modern web browser (Mozilla Firefox, Google Chrome) with Javascript enabled. Some functionalities may break if scripts are disabled. \r\n\r\n### Log Data\r\n\r\nLike many site operators, we collect information that your browser sends whenever you visit our site.\r\n\r\nThis Log Data may include information such as your computer&amp;apos;s Internet Protocol (&amp;quot;IP&amp;quot;) address, browser type, browser version, the pages of our Site that you visit, the time and date of your visit, the time spent on those pages and other statistics.\r\n\r\nIn addition, we may use third party services such as Google ReCaptcha that sends your browser information to be inspected. For more information, go to [Google ReCAPTCHA website](https://www.google.com/recaptcha/intro).\r\n\r\n### Communications\r\n\r\nWe may contact you for any purposes. Please do not accept requests made by those claiming to be from our website. \r\n\r\n### Cookies\r\n\r\nCookies are files with small amount of data, which may include an anonymous unique identifier. Cookies are sent to your browser from a web site and stored on your computer&amp;apos;s hard drive.\r\n\r\nLike many sites, we use &amp;quot;cookies&amp;quot; to collect information. You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent. Our cookies use the default settings, and will expire after 30 minutes of inactivity OR when you quit your web browser.\r\n\r\n### Security\r\n\r\nThe security of your Personal Information is important to us, but remember that no method of transmission over the Internet, or method of electronic storage, is 100% secure. While we strive to use commercially acceptable means to protect your Personal Information, we cannot guarantee its absolute security. Your password is encrypted with SHA-256 algorithm, and is *salted*.\r\n\r\n### Changes To This Privacy Policy\r\n\r\nThis Privacy Policy is effective as of 2017-12-18 and will remain in effect except with respect to any changes in its provisions in the future, which will be in effect immediately after being posted on this page.\r\n\r\nWe reserve the right to update or change our Privacy Policy at any time and you should check this Privacy Policy periodically. Your continued use of the Service after we post any modifications to the Privacy Policy on this page will constitute your acknowledgment of the modifications and your consent to abide and be bound by the modified Privacy Policy.\r\n\r\n### Contact Information\r\n\r\nIf you have any questions about this Privacy Policy, please contact Ee Yieng Zheng at [eeyieng.zheng@sjsu.edu](eeyieng.zheng@sjsu.edu)', '2017-12-18 16:03:56', '2017-12-18 16:53:56'),
	(2, 'admin', 'hello', 'world!', '2017-12-17 18:31:16', '2017-12-17 23:09:17'),
	(29, 'admin', 'Markdown Example', 'An h1 header\r\n============\r\n\r\n\r\nParagraphs are separated by a blank line.\r\n\r\n2nd paragraph. *Italic*, **bold**, and `monospace`. Itemized lists\r\nlook like:\r\n\r\n  * this one\r\n  * that one\r\n  * the other one\r\n\r\nNote that --- not considering the asterisk --- the actual text\r\ncontent starts at 4-columns in.\r\n\r\n&amp;gt; Block quotes are\r\n&amp;gt; written like so.\r\n&amp;gt;\r\n&amp;gt; They can span multiple paragraphs,\r\n&amp;gt; if you like.\r\n\r\nUse 3 dashes for an em-dash. Use 2 dashes for ranges (ex., &amp;quot;it&amp;apos;s all\r\nin chapters 12--14&amp;quot;). Three dots ... will be converted to an ellipsis.\r\nUnicode is supported. &amp;#9786;\r\n\r\n\r\n\r\nAn h2 header\r\n------------\r\n\r\nHere&amp;apos;s a numbered list:\r\n\r\n 1. first item\r\n 2. second item\r\n 3. third item\r\n\r\nNote again how the actual text starts at 4 columns in (4 characters\r\nfrom the left side). Here&amp;apos;s a code sample:\r\n\r\n    # Let me re-iterate ...\r\n    for i in 1 .. 10 { do-something(i) }\r\n\r\nAs you probably guessed, indented 4 spaces. By the way, instead of\r\nindenting the block, you can use delimited blocks, if you like:\r\n\r\n~~~\r\ndefine foobar() {\r\n    print &amp;quot;Welcome to flavor country!&amp;quot;;\r\n}\r\n~~~\r\n\r\n(which makes copying &amp; pasting easier). You can optionally mark the\r\ndelimited block for Pandoc to syntax highlight it:\r\n\r\n~~~python\r\nimport time\r\n# Quick, count to ten!\r\nfor i in range(10):\r\n    # (but not *too* quick)\r\n    time.sleep(0.5)\r\n    print i\r\n~~~\r\n\r\n\r\n\r\n### An h3 header ###\r\n\r\nNow a nested list:\r\n\r\n 1. First, get these ingredients:\r\n\r\n      * carrots\r\n      * celery\r\n      * lentils\r\n\r\n 2. Boil some water.\r\n\r\n 3. Dump everything in the pot and follow\r\n    this algorithm:\r\n\r\n        find wooden spoon\r\n        uncover pot\r\n        stir\r\n        cover pot\r\n        balance wooden spoon precariously on pot handle\r\n        wait 10 minutes\r\n        goto first step (or shut off burner when done)\r\n\r\n    Do not bump wooden spoon or it will fall.\r\n\r\nNotice again how text always lines up on 4-space indents (including\r\nthat last line which continues item 3 above).\r\n\r\nHere&amp;apos;s a link to [a website](http://foo.bar), to a [local\r\ndoc](local-doc.html), and to a [section heading in the current\r\ndoc](#an-h2-header). Here&amp;apos;s a footnote [^1].\r\n\r\n[^1]: Footnote text goes here.\r\n\r\nTables can look like this:\r\n\r\nsize  material      color\r\n----  ------------  ------------\r\n9     leather       brown\r\n10    hemp canvas   natural\r\n11    glass         transparent\r\n\r\nTable: Shoes, their sizes, and what they&amp;apos;re made of\r\n\r\n(The above is the caption for the table.) Pandoc also supports\r\nmulti-line tables:\r\n\r\n--------  -----------------------\r\nkeyword   text\r\n--------  -----------------------\r\nred       Sunsets, apples, and\r\n          other red or reddish\r\n          things.\r\n\r\ngreen     Leaves, grass, frogs\r\n          and other things it&amp;apos;s\r\n          not easy being.\r\n--------  -----------------------\r\n\r\nA horizontal rule follows.\r\n\r\n***\r\n\r\nHere&amp;apos;s a definition list:\r\n\r\napples\r\n  : Good for making applesauce.\r\noranges\r\n  : Citrus!\r\ntomatoes\r\n  : There&amp;apos;s no &amp;quot;e&amp;quot; in tomatoe.\r\n\r\nAgain, text is indented 4 spaces. (Put a blank line between each\r\nterm/definition pair to spread things out more.)\r\n\r\nHere&amp;apos;s a &amp;quot;line block&amp;quot;:\r\n\r\n| Line one\r\n|   Line too\r\n| Line tree\r\n\r\nand images can be specified like so:\r\n\r\n![example image](example-image.jpg &amp;quot;An exemplary image&amp;quot;)\r\n\r\nInline math equations go in like so: $\\omega = d\\phi / dt$. Display\r\nmath should get its own line and be put in in double-dollarsigns:\r\n\r\n$$I = \\int \\rho R^{2} dV$$\r\n\r\nAnd note that you can backslash-escape any punctuation characters\r\nwhich you wish to be displayed literally, ex.: \\`foo\\`, \\*bar\\*, etc.', '2017-12-17 22:28:05', '2017-12-18 14:27:25'),
	(31, 'genericuser', 'What&amp;apos;s this you just said to me?', 'My good friend,\r\n\r\nI&amp;apos;ll have you know I graduated top of my class in conflict resolution, and I&amp;apos;ve been involved in numerous friendly discussions, and I have over 300 confirmed friends. \r\n\r\nI am trained in polite discussions and I&amp;apos;m the top mediator in the entire neighborhood. \r\nYou are worth more to me than just another target. \r\n\r\nI hope we will come to have a friendship never before seen on this Earth. \r\n\r\nDon&amp;apos;t you think you might be hurting someone&amp;apos;s feelings saying that over the internet? \r\n\r\nThink about it, my friend. \r\n\r\nAs we speak I am contacting my good friends across the USA and your P.O. box is being traced right now so you better prepare for the greeting cards, friend. \r\n\r\nThe greeting cards that help you with your hate. \r\n\r\nYou should look forward to it, friend. I can be anywhere, anytime for you, and I can calm you in over seven hundred ways, and that&amp;apos;s just with my chess set. \r\n\r\nNot only am I extensively trained in conflict resolution, but I have access to the entire group of my friends and I will use them to their full extent to start our new friendship.\r\n\r\nIf only you could have known what kindness and love your little comment was about to bring you, maybe you would have reached out sooner. \r\n\r\nBut you couldn&amp;apos;t, you didn&amp;apos;t, and now we get to start a new friendship, you unique person. \r\n\r\nI will give you gifts and you might have a hard time keeping up. \r\n\r\nYou&amp;apos;re finally living, friend.', '2017-12-18 16:18:47', '2017-12-18 16:18:47'),
	(32, 'eeyiengzheng', 'Behind the Scene Tour', '# The Creation of NotSecure \r\nThis blogging software was made for San Jose State University, Computer Science 166 Information Security. The purpose is to demonstrate my knowledge of course material by putting what I&amp;apos;ve learn to use. [The source code resides in Github](https://github.com/EeYiengZheng/NotSecure)\r\n\r\n#### Technology\r\n1. [AWS](https://aws.amazon.com/): XAMPP is running on a web computer instance on Amazon Web Services EC2 server. \r\n2. [XAMPP](https://www.apachefriends.org/index.html): XAMPP three-tier stack is used to deploy the source code to the web. \r\n	2. Java: the Java programming language is used to write the logic of the software.\r\n	3. JSP: Java Server Pages technology is used to display HTML.\r\n	4. MySQL: database used to store data.\r\n	5. Tomcat: Server technology for hosting web pages.\r\n3. Supporting libraries\r\n	4. [Bootstrap 4](https://getbootstrap.com/): Bootstrap CSS and Javascript library is imported and used on all pages\r\n		5. This website uses HTML5. Not tested for compatibility with all versions of HTML.\r\n	5. [Font Awesome](http://fontawesome.io/): a library of scalable symbols and glyphs. \r\n	4. Javascript: Javascript is used on the majority of pages.\r\n		5. [Minimal JSON](https://github.com/ralfstx/minimal-json): used to parse JSON result given by Google ReCAPTCHA. \r\n		6. [SimpleMDE](https://github.com/sparksuite/simplemde-markdown-editor): a Markdown text editor.  \r\n	5. jQuery: a mix of jQuery and vanilla \r\n		6. Ajax: used for sending POST requests to the server without refreshing the current page.\r\n	7. Java Classes\r\n		7. [Java HtmlManipulator](http://zs.freeshell.org/): used to convert HTML entities to unicode characters and vice versa.\r\n		8. [Verify ReCAPTCHA](https://www.journaldev.com/7133/how-to-integrate-google-recaptcha-in-java-web-application): Used to verify ReCAPTCHA response.\r\n\r\n### Implementation\r\n![](http://puu.sh/yJnpB/00ee2f6b27.png)\r\n\r\n##### Database:\r\n\r\nBlogs:\r\n![](http://puu.sh/yJnOq/bf12d501b6.png)\r\n\r\nUsers:\r\n![](http://puu.sh/yJnQC/1e71a3eba8.png)\r\n\r\nPasswords are hashed, like so\r\n![](http://puu.sh/yJnVW/105eef0ace.png)\r\nThe n is a enum word for differentiating a normal user from an admin. Is admin? y for yes, n for no.\r\n\r\n##### Registration:\r\nSource: register.jsp and register_action.jsp\r\nUses Ajax to submit form. Gets login screen back as respond. \r\nInputs are checked for illegal characters using HTML5 built-in functions.\r\n```\r\nfunction onSubmit(token) {\r\n    $.ajax({\r\n        url: &amp;apos;&amp;lt;c:url value=&amp;quot;/account/register_action&amp;quot;/&amp;gt;&amp;apos;,\r\n        type: &amp;apos;POST&amp;apos;,\r\n        dataType: &amp;apos;html&amp;apos;,\r\n        data: $(&amp;quot;#reg_form&amp;quot;).serialize(),\r\n        success: function (respond) {\r\n            console.log(&amp;quot;ajax success&amp;quot;);\r\n            console.log(&amp;quot;register_action triggered&amp;quot;);\r\n            $(&amp;quot;html&amp;quot;).html(respond);\r\n        },\r\n        error: function (xhr, ajaxOptions, thrownError) {\r\n            console.log(xhr.status);\r\n            console.log(thrownError);\r\n            $(&amp;quot;#err-msg&amp;quot;).text(&amp;quot;Failed to contact server. &amp;quot; + thrownError + &amp;quot; :&amp;quot; + xhr.status);\r\n        }\r\n    });\r\n}\r\n```\r\nSubmitted form is sent to Register_action.jsp to get POST parameters checked. Then a user is created in the database.\r\n```\r\nPreparedStatement stmt = conn.prepareStatement(query);\r\nstmt.setString(1, uname);\r\n    ...\r\n    ...\r\nint ret = stmt.executeUpdate();\r\nif (ret == 1) {\r\n    System.out.println(&amp;quot;Registered: &amp;quot; + uname);\r\n```\r\n\r\n##### Login:\r\nSource: login.jsp and login_action.jsp\r\nUsername is retrieve, then check in the database for existence. If user exist, hash and salt the provided password and compare with the user of the same username.', '2017-12-18 17:26:04', '2017-12-18 18:02:45');
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;

-- Dumping structure for function notsecure_eezheng.str_random_lipsum
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `str_random_lipsum`(p_max_words SMALLINT
                                 ,p_min_words SMALLINT
                                 ,p_start_with_lipsum TINYINT(1)
                                 ) RETURNS varchar(10000) CHARSET utf8
    NO SQL
BEGIN
    /**
    * String function. Returns a random Lorum Ipsum string of nn words
    * <br>
    * %author Ronald Speelman
    * %version 1.0
    * Example usage:
    * SELECT str_random_lipsum(5,NULL,NULL) AS fiveWordsExactly;
    * SELECT str_random_lipsum(10,5,0) AS five-tenWords;
    * SELECT str_random_lipsum(50,10,1) AS startWithLorumIpsum;
    * See more complex examples and a description on www.moinne.com/blog/ronald
    *
    * %param p_max_words         Number: the maximum amount of words, if no
    *                                    min_words are provided this will be the
    *                                    exaxt amount of words in the result
    *                                    Default = 50
    * %param p_min_words         Number: the minimum amount of words in the
    *                                    result, By providing the parameter, you provide a range
    *                                    Default = 0
    * %param p_start_with_lipsum Boolean:if "1" the string will start with
    *                                    'Lorum ipsum dolor sit amet.', Default = 0
    * %return String
    */

        DECLARE v_max_words SMALLINT DEFAULT 50;
        DECLARE v_random_item SMALLINT DEFAULT 0;
        DECLARE v_random_word VARCHAR(25) DEFAULT '';
        DECLARE v_start_with_lipsum TINYINT DEFAULT 0;
        DECLARE v_result VARCHAR(10000) DEFAULT '';
        DECLARE v_iter INT DEFAULT 1;
        DECLARE v_text_lipsum VARCHAR(1500) DEFAULT 'a ac accumsan ad adipiscing aenean aliquam aliquet amet ante aptent arcu at auctor augue bibendum blandit class commodo condimentum congue consectetuer consequat conubia convallis cras cubilia cum curabitur curae; cursus dapibus diam dictum dignissim dis dolor donec dui duis egestas eget eleifend elementum elit enim erat eros est et etiam eu euismod facilisi facilisis fames faucibus felis fermentum feugiat fringilla fusce gravida habitant hendrerit hymenaeos iaculis id imperdiet in inceptos integer interdum ipsum justo lacinia lacus laoreet lectus leo libero ligula litora lobortis lorem luctus maecenas magna magnis malesuada massa mattis mauris metus mi molestie mollis montes morbi mus nam nascetur natoque nec neque netus nibh nisi nisl non nonummy nostra nulla nullam nunc odio orci ornare parturient pede pellentesque penatibus per pharetra phasellus placerat porta porttitor posuere praesent pretium primis proin pulvinar purus quam quis quisque rhoncus ridiculus risus rutrum sagittis sapien scelerisque sed sem semper senectus sit sociis sociosqu sodales sollicitudin suscipit suspendisse taciti tellus tempor tempus tincidunt torquent tortor tristique turpis ullamcorper ultrices ultricies urna ut varius vehicula vel velit venenatis vestibulum vitae vivamus viverra volutpat vulputate';
        DECLARE v_text_lipsum_wordcount INT DEFAULT 180;
        DECLARE v_sentence_wordcount INT DEFAULT 0;
        DECLARE v_sentence_start BOOLEAN DEFAULT 1;
        DECLARE v_sentence_end BOOLEAN DEFAULT 0;
        DECLARE v_sentence_lenght TINYINT DEFAULT 9;

        SET v_max_words := COALESCE(p_max_words, v_max_words);
        SET v_start_with_lipsum := COALESCE(p_start_with_lipsum , v_start_with_lipsum);

        IF p_min_words IS NOT NULL THEN
            SET v_max_words := FLOOR(p_min_words + (RAND() * (v_max_words - p_min_words)));
        END IF;

        IF v_max_words < v_sentence_lenght THEN
            SET v_sentence_lenght := v_max_words;
        END IF;

        IF p_start_with_lipsum = 1 THEN
            SET v_result := CONCAT(v_result,'Lorem ipsum dolor sit amet.');
            SET v_max_words := v_max_words - 5;
        END IF;

        WHILE v_iter <= v_max_words DO
            SET v_random_item := FLOOR(1 + (RAND() * v_text_lipsum_wordcount));
            SET v_random_word := REPLACE(SUBSTRING(SUBSTRING_INDEX(v_text_lipsum, ' ' ,v_random_item),
                                           CHAR_LENGTH(SUBSTRING_INDEX(v_text_lipsum,' ', v_random_item -1)) + 1),
                                           ' ', '');

            SET v_sentence_wordcount := v_sentence_wordcount + 1;
            IF v_sentence_wordcount = v_sentence_lenght THEN
                SET v_sentence_end := 1 ;
            END IF;

            IF v_sentence_start = 1 THEN
                SET v_random_word := CONCAT(UPPER(SUBSTRING(v_random_word, 1, 1))
                                            ,LOWER(SUBSTRING(v_random_word FROM 2)));
                SET v_sentence_start := 0 ;
            END IF;

            IF v_sentence_end = 1 THEN
                IF v_iter <> v_max_words THEN
                    SET v_random_word := CONCAT(v_random_word, '.');
                END IF;
                SET v_sentence_lenght := FLOOR(9 + (RAND() * 7));
                SET v_sentence_end := 0 ;
                SET v_sentence_start := 1 ;
                SET v_sentence_wordcount := 0 ;
            END IF;

            SET v_result := CONCAT(v_result,' ', v_random_word);
            SET v_iter := v_iter + 1;
        END WHILE;

        RETURN TRIM(CONCAT(v_result,'.'));
END//
DELIMITER ;

-- Dumping structure for table notsecure_eezheng.users
CREATE TABLE IF NOT EXISTS `users` (
  `username` varchar(64) NOT NULL,
  `password` char(64) NOT NULL,
  `display_name` varchar(32) NOT NULL,
  `salt` varchar(16) NOT NULL,
  `admin` enum('y','n') NOT NULL DEFAULT 'n',
  `csrf_token` char(128) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table notsecure_eezheng.users: ~3 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`username`, `password`, `display_name`, `salt`, `admin`, `csrf_token`) VALUES
	('admin', '25dc0ad3556c4fff56fabf80a2e217fb9c84b130424cf936b097e9842bdbcfca', 'the_admin', 'a4292aa50f6d8f3b', 'y', 'fae477529ceb7db869fdca98acd672c3f25df07fc09b80656abde8d28782ae14ffd9a0dd1dd54995192a916f91e45d9d9aaedf4ddecf5533599e87847f39869a'),
	('eeyiengzheng', '3c63b8b5e75a1c63001228206c1800d2911c69b8a88c31c99e5c9f3629791209', 'Ee_Yieng_Zheng', '935fbab67fd7d297', 'y', 'f1cfcf32d3daeb966c50bde1f9904e67222b5a760ffe7b139217460341faf5f825ea8ff01257af6224e94791d46aed52642bf7f10e14762a089787edb83c6708'),
	('genericuser', '4b73f8d62390ab9c3479ec73bda24e399c68c02664fc317651ad8ed69d97563e', 'A_Generic_User', '4c327fc5ceb023a5', 'n', '32619e8a2605c02a4c5b024953e06274b623d5cf4fdfbdc87bee19965e489524ba1a9d9c656e22881c69960ac426d67165a1ba80cf4e22b3ddbbd8dbb59e3a5e');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
