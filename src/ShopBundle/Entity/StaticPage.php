<?php

namespace ShopBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * StaticPage
 *
 * @ORM\Table(name="static")
 * @ORM\Entity(repositoryClass="ShopBundle\Repository\StaticRepository")
 */
class StaticPage
{
    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var string
     *
     * @ORM\Column(name="title", type="string", length=255)
     */
    private $title;

    /**
     * @var string
     *
     * @ORM\Column(name="titleRewrited", type="string", length=255, unique=true)
     */
    private $titleRewrited;

    /**
     * @var string
     *
     * @ORM\Column(name="content", type="string", length=1024)
     */
    private $content;


    /**
     * Get id
     *
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set title
     *
     * @param string $title
     *
     * @return Static
     */
    public function setTitle($title)
    {
        $this->title = $title;

        return $this;
    }

    /**
     * Get title
     *
     * @return string
     */
    public function getTitle()
    {
        return $this->title;
    }

    /**
     * Set titleRewrited
     *
     * @param string $titleRewrited
     *
     * @return Static
     */
    public function setTitleRewrited($titleRewrited)
    {
        $this->titleRewrited = $titleRewrited;

        return $this;
    }

    /**
     * Get titleRewrited
     *
     * @return string
     */
    public function getTitleRewrited()
    {
        return $this->titleRewrited;
    }

    /**
     * Set content
     *
     * @param string $content
     *
     * @return Static
     */
    public function setContent($content)
    {
        $this->content = $content;

        return $this;
    }

    /**
     * Get content
     *
     * @return string
     */
    public function getContent()
    {
        return $this->content;
    }
}
