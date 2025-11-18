<?php
namespace App\Services\Mail;

use App\Entity\Acteur;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Component\Mailer\MailerInterface;

class MailService implements IMailService{

    public function __construct(
        private MailerInterface $mailer
    ) {
       
    }
    public function send(Acteur $acteur): void
    {
        $email = (new TemplatedEmail())
            ->from('mariejosep705@gmail.com')
            ->to($acteur->getEmail())
            ->subject('Valider votre compte')
            ->htmlTemplate('mails/account_creation.html.twig')
            ->context([
                'name' => $acteur->getPrenoms(),  
                'code' => $acteur->getUser()->getCodeVerification(),
            ])     
        ;
        $this->mailer->send($email);
    }
    
}