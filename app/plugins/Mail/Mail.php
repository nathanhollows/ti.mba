<?php
namespace App\Plugins\Mail;

use Phalcon\Di\Injectable;
use Swift_Message as Message;
use Swift_SmtpTransport as Smtp;
use Phalcon\Mvc\View;

/**
 * App\Mail\Mail
 * Sends e-mails based on pre-defined templates
 */
class Mail extends Injectable
{

    protected $transport;

    protected $directSmtp = true;

    /**
     * Applies a template to be used in the e-mail
     *
     * @param string $template
     * @param array $params
     */
    public function getTemplate($template, $params)
    {
        $this->view->start();
        $this->view->setTemplateBefore('none');
        $this->view->setRenderLevel(View::LEVEL_LAYOUT);
        foreach ($params as $key=> $value) {
            $this->view->setVar($key, $value);
        }
        $this->view->render('email', $template, $params);
        $this->view->finish();
        return $this->view->getContent();

    }

    /**
     * Sends e-mails via AmazonSES based on predefined templates
     *
     * @param array $to
     * @param string $subject
     * @param string $template
     * @param array $params
     */
    public function send($to, $subject, $template, $params)
    {

        // Settings
        $mailSettings = $this->config->mail;

        $template = $this->getTemplate($template, $params);

        // Create the message
        $message = Message::newInstance()
            ->setSubject($subject)
            ->setTo($to)
            ->setFrom(array(
                $mailSettings->fromEmail => $mailSettings->fromName
            ))
            ->setBody($template, 'text/html');

        if ($this->directSmtp) {

            if (!$this->transport) {
                $this->transport = Smtp::newInstance(
                    $mailSettings->smtp->server,
                    $mailSettings->smtp->port,
                    $mailSettings->smtp->security
                )
                ->setUsername($mailSettings->smtp->username)
                ->setPassword($mailSettings->smtp->password);
            }

            // Create the Mailer using your created Transport
            $mailer = \Swift_Mailer::newInstance($this->transport);

            return $mailer->send($message);
        } else {
            return 'Error';
        }
    }
}
