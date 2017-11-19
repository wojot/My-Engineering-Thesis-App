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

class AdminCategoryController extends Controller
{

    /**
     * @Route("admin/categories", name="categories")
     */
    public function categoriesAction(Request $request)
    {
        $categories = $this->getDoctrine()->getRepository('ShopBundle:Category')
            ->findAll();

        $category = new Category();

        $form = $this->createFormBuilder($category)
            ->add('name', TextType::class, array('label' => 'Nazwa kategorii'))
            ->add('description', TextareaType::class, array('label' => 'Opis kategorii', 'attr' => array('rows' => 6)))
            ->add('save', SubmitType::class, array('label' => 'Dodaj kategorię'))
            ->getForm();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $category = $form->getData();

            $em = $this->getDoctrine()->getManager();
            $em->persist($category);
            $em->flush();
            $this->addFlash(
                'success',
                'Dodano kategorię o nazwie: ' . $category->getName()
            );
            return $this->redirectToRoute('categories');
        }

        return $this->render('Admin/categories.html.twig', array(
            'form' => $form->createView(),
            'categories' => $categories));
    }

    /**
     * @Route("admin/category/edit/{id}", name="category_edit")
     */
    public function categoryEditAction($id, Request $request)
    {
        $category = $this->getDoctrine()->getRepository('ShopBundle:Category')
            ->find($id);


        $form = $this->createFormBuilder($category)
            ->add('name', TextType::class, array('label' => 'Edytuj nazwę kategorii'))
            ->add('description', TextareaType::class, array('label' => 'Edytuj opis kategorii', 'attr' => array('rows' => 6)))
            ->add('save', SubmitType::class, array('label' => 'Edytuj kategorię'))
            ->getForm();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $category = $form->getData();

            $em = $this->getDoctrine()->getManager();
            $em->persist($category);
            $em->flush();
            $this->addFlash(
                'success',
                'Edytowano kategorię o nazwie: ' . $category->getName()
            );
            return $this->redirectToRoute('categories');
        }

        return $this->render('Admin/category_edit.html.twig', array('form' => $form->createView(), 'category' => $category));
    }

    /**
     * @Route("admin/category/delete/{id}", name="category_delete")
     */
    public function categoryDeleteAction($id)
    {
        $category = $this->getDoctrine()->getRepository('ShopBundle:Category')
            ->find($id);

        foreach ($category->getProducts() as $product) {
            $product->setCategory(null);
        }

        $em = $this->getDoctrine()->getEntityManager();
        $em->remove($category);
        $em->flush();

        $this->addFlash(
            'success',
            'Usunięto kategorię o id: ' . $id
        );

        return $this->redirectToRoute('categories');

    }
}
