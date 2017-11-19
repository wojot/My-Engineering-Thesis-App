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

class AdminProductController extends Controller
{
    /**
     * @Route("admin/all_orders", name="all_orders")
     */
    public function allOrdersAction(Request $request)
    {
        $repository = $this->getDoctrine()
            ->getRepository('ShopBundle:Orders');

        $query = $repository->createQueryBuilder('o')
            ->orderBy('o.date', 'DESC')
            ->getQuery();

        $orders = $query->getResult();

        $current_user = $request->query->get('user');

        return $this->render('admin/all_orders.html.twig', array('orders' => $orders, 'current_user' => $current_user));
    }

    /**
     * @Route("admin/product/new", name="product_new")
     */
    public function productNewAction(Request $request)
    {
        $categories = $this->getDoctrine()
            ->getRepository('ShopBundle:Category')
            ->findAll();

        foreach ($categories as $cat) {
            $categoriesArray[$cat->getName()] = $cat;
        }

        $form = $this->createFormBuilder()
            ->setAction($this->generateUrl('product_new'))
            ->setMethod('POST')
            ->add('name', TextType::class, array('label' => 'Nazwa produktu'))
            ->add('description', CKEditorType::class, array('label' => 'Opis'))
            ->add('price', NumberType::class, array('label' => 'Cena'))
            ->add('width', NumberType::class, array('label' => 'Szerokość (cm)'))
            ->add('height', NumberType::class, array('label' => 'Wysokość (cm)'))
            ->add('depth', NumberType::class, array('label' => 'Głębokość (cm)'))
            ->add('weight', IntegerType::class, array('label' => 'Waga (kg)'))
            ->add('category', ChoiceType::class, array('choices' => $categoriesArray, 'label' => 'Kategoria'))
            ->add('active', CheckboxType::class, array(
                'label' => 'Dostępny',
                'required' => false,
                'attr' => array('checked' => true)
            ))
            ->add('images', FileType::class, array('label' => 'Dodaj zdjęcia', 'multiple' => true))
            ->add('save', SubmitType::class, array('label' => 'Dodaj produkt'))
            ->getForm();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $data = $form->getData();

            $product = new Product();
            $product->setName($data['name']);
            $product->setDescription($data['description']);
            $product->setPrice($data['price']);
            $product->setActive($data['active']);
            $product->setWidth($data['width']);
            $product->setHeight($data['height']);
            $product->setDepth($data['depth']);
            $product->setWeight($data['weight']);
            $product->setCategory($data['category']);

            $emp = $this->getDoctrine()->getManager();
            $emp->persist($product);
            $emp->flush();

            foreach ($data['images'] as $image) {
                $current_image = new Image();
                $image_name = md5(uniqid()) . '.' . $image->guessExtension();

                $current_image->setImage($image_name);
                $current_image->setProduct($product);

                $image->move($this->getParameter('images'), $image_name);
                $em = $this->getDoctrine()->getManager();
                $em->persist($current_image);
                $em->flush();
            }

            $this->addFlash(
                'success',
                'Dodano produkt o nazwie: ' . $product->getName()
            );
            return $this->redirectToRoute('products');
        }


        return $this->render('Admin/product_new.html.twig', array(
            'form' => $form->createView()));
    }


    /**
     * @Route("admin/products", name="products")
     */
    public function productsAction(Request $request)
    {
        $repository = $this->getDoctrine()->getRepository('ShopBundle:Product');
        $query = $repository->createQueryBuilder('p')
            ->orderBy('p.id', 'DESC')
            ->getQuery();

        $products = $query->getResult();

        return $this->render('Admin/products.html.twig', array(
            'products' => $products));
    }

    /**
     * @Route("admin/product/edit/{id}", name="product_edit")
     */
    public function editProductAction($id, Request $request)
    {
        $categories = $this->getDoctrine()
            ->getRepository('ShopBundle:Category')
            ->findAll();

        foreach ($categories as $cat) {
            $categoriesArray[$cat->getName()] = $cat;

        }

        $product = $this->getDoctrine()->getRepository('ShopBundle:Product')
            ->find($id);

        $activeState = $product->getActive();

        $form = $this->createFormBuilder($product)
            ->setAction($this->generateUrl('product_edit', array('id' => $id)))
            ->setMethod('POST')
            ->add('name', TextType::class, array('label' => 'Nazwa produktu'))
            ->add('description', CKEditorType::class, array('label' => 'Opis'))
            ->add('price', NumberType::class, array('label' => 'Cena'))
            ->add('width', NumberType::class, array('label' => 'Szerokość (cm)'))
            ->add('height', NumberType::class, array('label' => 'Wysokość (cm)'))
            ->add('depth', NumberType::class, array('label' => 'Głębokość (cm)'))
            ->add('weight', IntegerType::class, array('label' => 'Waga (kg)'))
            ->add('category', ChoiceType::class, array('choices' => $categoriesArray, 'label' => 'Kategoria'))
            ->add('active', CheckboxType::class, array(
                'label' => 'Dostępny',
                'required' => false,
                'attr' => array('checked' => $activeState)
            ))
//            ->add('images', FileType::class, array('label' => 'Dodaj zdjęcia', 'multiple' => true))
            ->add('save', SubmitType::class, array('label' => 'Edytuj produkt'))
            ->getForm();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $data = $form->getData();

            $product->setName($data->getName());
            $product->setDescription($data->getDescription());
            $product->setPrice($data->getPrice());
            $product->setActive($data->getActive());
            $product->setWidth($data->getWidth());
            $product->setHeight($data->getHeight());
            $product->setDepth($data->getDepth());
            $product->setWeight($data->getWeight());
            $product->setCategory($data->getCategory());

            $emp = $this->getDoctrine()->getManager();
            $emp->persist($product);
            $emp->flush();

            $this->addFlash(
                'success',
                'Edytowano produkt o id: ' . $product->getId()
            );
            return $this->redirectToRoute('product_edit', array('id' => $product->getId()));
        }

        return $this->render('Admin/product_edit.html.twig', array(
            'form' => $form->createView(),
            'product' => $product));
    }


    /**
     * @Route("admin/product/edit_photos/{id}", name="product_photos_edit")
     */
    public function editProductPhotosAction($id, Request $request)
    {
        $product = $this->getDoctrine()->getRepository('ShopBundle:Product')
            ->find($id);

        $images = $product->getImages()->getValues();

//        dump($images);
//        return new Response();

        $form = $this->createFormBuilder()
            ->setAction($this->generateUrl('product_photos_edit', array('id' => $id)))
            ->setMethod('POST')
            ->add('images', FileType::class, array('label' => 'Dodaj zdjęcia', 'multiple' => true))
            ->add('save2', SubmitType::class, array('label' => 'Dodaj zdjęcia'))
            ->getForm();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $photo_data = $form->getData();

            foreach ($photo_data['images'] as $image) {
                $current_image = new Image();
                $image_name = md5(uniqid()) . '.' . $image->guessExtension();

                $current_image->setImage($image_name);
                $current_image->setProduct($product);

                $image->move($this->getParameter('images'), $image_name);
                $em = $this->getDoctrine()->getManager();
                $em->persist($current_image);
                $em->flush();
            }

            $this->addFlash(
                'success',
                'Edytowano zdjęcia produktu o id: ' . $product->getId()
            );
            return $this->redirectToRoute('product_photos_edit', array('id' => $product->getId()));
        }

        return $this->render('Admin/product_photos_edit.html.twig', array(
            'form' => $form->createView(),
            'product' => $product,
            'images' => $images));
    }

    /**
     * @Route("admin/product/delete_photo/{id_product}/{id_photo}", name="delete_photo")
     */
    public function deletePhotoAction($id_photo, $id_product, Request $request)
    {
        $product = $this->getDoctrine()->getRepository('ShopBundle:Product')
            ->find($id_product);

        $image = $this->getDoctrine()->getRepository('ShopBundle:Image')
            ->find($id_photo);

        $em = $this->getDoctrine()->getManager();
        $product->removeImage($image);
        $em->persist($product);
        $em->remove($image);
        $em->flush();

        $this->addFlash(
            'success',
            'Usunięto zdjęcie o id: ' . $id_photo
        );

        return $this->redirectToRoute('product_photos_edit', array('id' => $id_product));
    }

    /**
     **
     * @Route("admin/product/delete_product/{id}", name="delete_product")
     */
    public function deleteProductAction($id, Request $request)
    {
        $product = $this->getDoctrine()->getRepository('ShopBundle:Product')
            ->find($id);

        foreach ($product->getImages() as $image) {
            $em = $this->getDoctrine()->getManager();
            $em->remove($image);
            $em->flush();
        }

        $product->setDeleted(1);
        $product->setActive(0);

        $em = $this->getDoctrine()->getManager();
        $em->persist($product);
        $em->flush();

        $this->addFlash(
            'success',
            'Usunięto produkt o id: ' . $id
        );

        return $this->redirectToRoute('products');
    }
}
