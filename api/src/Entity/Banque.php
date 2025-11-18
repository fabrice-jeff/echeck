<?php

namespace App\Entity;

use App\Repository\BanqueRepository;use App\Utils\TraitClasses\EntityTimestampableTrait;use App\Utils\TraitClasses\EntityUserOperation;use App\Utils\TraitClasses\EntityValidateBy;use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: BanqueRepository::class)]
class Banque
{
    use EntityUserOperation;
    use EntityTimestampableTrait;
    use EntityValidateBy;
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $libelle = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getLibelle(): ?string
    {
        return $this->libelle;
    }

    public function setLibelle(string $libelle): static
    {
        $this->libelle = $libelle;
        return $this;
    }
}
