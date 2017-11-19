<?php

namespace ShopBundle\Controller;

use ShopBundle\Entity\Bank;
use ShopBundle\Entity\Carrier;
use ShopBundle\Entity\Category;
use ShopBundle\Entity\Image;
use ShopBundle\Entity\Product;
use ShopBundle\Entity\Slide;
use ShopBundle\Entity\StaticPage;
use ShopBundle\ShopBundle;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\File\File;
use Ivory\CKEditorBundle\Form\Type\CKEditorType;

class AdminStaticPagesController extends Controller
{

    /**
     * @Route("admin/staticPages", name="static_pages")
     */
    public function staticPagesAction(Request $request)
    {
        $static_page = new StaticPage();

        $form = $this->createFormBuilder()
            ->add('title', TextType::class, array('label' => 'Tytuł strony'))
            ->add('content', CKEditorType::class, array('label' => 'Treść'))
            ->add('save', SubmitType::class, array('label' => 'Dodaj stronę statyczną'))
            ->getForm();

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $data = $form->getData();

            $static_page->setTitle($data['title']);
            $static_page->setTitleRewrited(strtolower(preg_replace('(\s)', '${1}-', $data['title'])));
            $static_page->setContent($data['content']);

            $em = $this->getDoctrine()->getManager();
            $em->persist($static_page);
            $em->flush();

            $this->addFlash('success', 'Dodano nową stronę statyczną');
            return $this->redirectToRoute('static_pages');
        }

        $pages = $this->getDoctrine()->getRepository('ShopBundle:StaticPage')
            ->findAll();

        return $this->render('Admin/static_pages.html.twig', array('form' => $form->createView(), 'pages' => $pages));
    }

    /**
     * @Route("admin/staticPages/{id}", name="static_pages_edit")
     */
    public function staticPagesEditAction($id, Request $request)
    {
        $static_page = $this->getDoctrine()->getRepository('ShopBundle:StaticPage')
            ->find($id);

        $form = $this->createFormBuilder($static_page)
            ->add('title', TextType::class, array('label' => 'Tytuł strony'))
            ->add('titleRewrited', TextType::class, array('label' => 'Przyjazny link'))
            ->add('content', CKEditorType::class, array('label' => 'Treść'))
            ->add('save', SubmitType::class, array('label' => 'Edytuj stronę statyczną'))
            ->getForm();

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $data = $form->getData();

            $static_page->setTitle($data->getTitle());
            $static_page->setTitleRewrited(strtolower(preg_replace('(\s)', '${1}-', $data->getTitleRewrited())));
            $static_page->setContent($data->getContent());

            $em = $this->getDoctrine()->getManager();
            $em->persist($static_page);
            $em->flush();

            $this->addFlash('success', 'Edytowano nową stronę statyczną ' . $static_page->getTitle());
            return $this->redirectToRoute('static_pages');
        }
        return $this->render('Admin/static_pages_edit.html.twig', array('form' => $form->createView(), 'page' => $static_page));
    }

    /**
     * @Route("admin/staticPages/delete/{id}", name="static_pages_delete")
     */
    public function staticPagesDeleteAction($id)
    {
        $page = $this->getDoctrine()->getRepository('ShopBundle:StaticPage')
            ->find($id);

        $em = $this->getDoctrine()->getEntityManager();
        $em->remove($page);
        $em->flush();

        $this->addFlash(
            'success',
            'Usunięto stronę statyczną o id: ' . $id
        );

        return $this->redirectToRoute('static_pages');

    }
}
