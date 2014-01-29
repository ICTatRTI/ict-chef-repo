
<?php

//SMTP needs accurate times, and the PHP time zone MUST be set
//This should be done in your php.ini, but this is how to do it if you don't have access to that
date_default_timezone_set('Etc/UTC');

require 'vendor/autoload.php';



$message = get_include_contents('template.php');

//Create a new PHPMailer instance
$mail = new PHPMailer();
$mail->isSMTP();
//Enable SMTP debugging 0 = off (for production use),  1 = client messages,  2 = client and server messages
$mail->SMTPDebug = 2;
$mail->Debugoutput = 'html';
$mail->Host = 'smtp.gmail.com';
$mail->Port = 587;
$mail->SMTPSecure = 'tls';
$mail->SMTPAuth = true;

//Get Gmail credentials from environment
$mail->Username = get_cfg_var('mail.user');
$mail->Password = get_cfg_var('mail.password');
$mail->setFrom('cict.rti@gmail.com', 'ICT@RTI');
$mail->addReplyTo('no-reply@rti.org', 'Please do not reply');
$mail->addAddress('apreston@rti.org', 'Adam Preston');
$mail->Subject = 'Seguridad Inalambrica: monthly usage reports for '. get_cfg_var('municipality.name');
$mail->msgHTML($message);
//Replace the plain text body with one created manually
$mail->AltBody = 'Seguridad Inalambrica: monthly usage reports for '. get_cfg_var('municipality.name');
//Attach an image file

//send the message, check for errors
if (!$mail->send()) {
    echo "Mailer Error: " . $mail->ErrorInfo;
} else {
    echo "Message sent!";
}


function get_include_contents($filename) {
    if (is_file($filename)) {
        ob_start();
        include $filename;
        return ob_get_clean();
    }
    return false;
}

?>