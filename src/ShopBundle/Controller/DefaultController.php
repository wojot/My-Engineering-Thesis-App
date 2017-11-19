<?php

namespace ShopBundle\Controller;

use Ivory\CKEditorBundle\Form\Type\CKEditorType;
use Leafo\ScssPhp\Node\Number;
use ShopBundle\Entity\Comment;
use ShopBundle\Entity\Orders;
use ShopBundle\Entity\OrdersProducts;
use ShopBundle\Entity\Product;
use ShopBundle\Entity\User;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\RepeatedType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\Security\Core\User\UserInterface;
use Doctrine\ORM\Tools\Pagination\Paginator;

class DefaultController extends Controller
{
//    /**
//     * @Route("/", name="home")
//     */
//    public function indexAction(Request $request)
//    {
//        return $this->redirectToRoute('shop');
//        return $this->render('default/index.html.twig');
//    }

    /**
     * @Route("/", name="shop")
     */
    public function shopAction(Request $request)
    {
        $pageSize = 6;
        $pagesCount = 1;

        if ($request->get('page') != null) {
            $currentPage = $request->get('page');
        } else {
            $currentPage = 1;
        }

        $categories = $this->getDoctrine()->getRepository('ShopBundle:Category')
            ->findAll();

        $requested_category = $request->get('category');
        $repository = $this->getDoctrine()->getRepository('ShopBundle:Product');

        if ($requested_category != null) {
            foreach ($categories as $category) {
                if ($category->getName() == $requested_category) {

                    $query = $repository->createQueryBuilder('p')
                        ->where('p.category = :category AND p.active = 1 AND p.deleted = 0')
                        ->setParameter('category', $category)
                        ->orderBy('p.id', 'DESC');
                }
            }
            if ($requested_category == 'wszystkie') {
                $query = $repository->createQueryBuilder('p')
                    ->where('p.active = 1 AND p.deleted = 0')
                    ->orderBy('p.id', 'DESC');
            }
        } else {
            $query = $repository->createQueryBuilder('p')
                ->where('p.active = 1 AND p.deleted = 0')
                ->orderBy('p.id', 'DESC');

        }

        $paginator = new Paginator($query);

        $totalItems = count($paginator);
        $pagesCount = ceil($totalItems / $pageSize);

        $paginator
            ->getQuery()
            ->setFirstResult($pageSize * ($currentPage - 1))// set the offset
            ->setMaxResults($pageSize); // set the limit

        $products = $paginator;

        return $this->render('default/shop.html.twig', array('products' => $products, 'categories' => $categories,
            'requested_category' => $requested_category, 'pages' => $pagesCount));
    }

    public function banerAction()
    {
        $repository = $this->getDoctrine()
            ->getRepository('ShopBundle:Slide');

        $query = $repository->createQueryBuilder('s')
            ->orderBy('s.position', 'DESC')
            ->getQuery();

        $slides = $query->getResult();

        return $this->render('Admin/baner.html.twig', array('slides' => $slides));
    }

    /**
     * @Route("shop/product/{id}", name="product_details")
     */
    public function productDetailsAction($id, Request $request)
    {
        $product = $this->getDoctrine()->getRepository('ShopBundle:Product')
            ->find($id);

        $form = $this->createFormBuilder()
            ->add('amount', IntegerType::class, array('label' => 'Sztuk', 'attr' => array('min' => 1, 'value' => 1)))
            ->add('save', SubmitType::class, array('label' => 'Dodaj do koszyka'))
            ->getForm();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $amount = $form->getData();
            return $this->redirect($this->generateUrl('order', array('id' => $id, 'amount' => $amount['amount'])));
        }


        $comment_form = $this->createFormBuilder()
            ->add('content', CKEditorType::class, array('label' => 'Treść', 'config' => array('toolbar' => 'basic')))
            ->add('save', SubmitType::class, array('label' => 'Dodaj komentarz'))
            ->getForm();

        $comment_form->handleRequest($request);

        if ($comment_form->isValid() && $comment_form->isSubmitted()) {
            $data = $comment_form->getData();
            $user = $this->get('security.token_storage')->getToken()->getUser();

            $comment = new Comment();
            $comment->setContent($data['content']);
            $comment->setDate(new \DateTime(date('d.m.Y, H:i:s')));
            $comment->setProduct($product);
            $comment->setUser($user);

            $em = $this->getDoctrine()->getManager();
            $em->persist($comment);
            $em->flush();

            $this->addFlash('success', 'Dodano nowy komentarz.');

            return $this->redirectToRoute('product_details', array('id' => $product->getId()));
        }

        $repository = $this->getDoctrine()->getRepository('ShopBundle:Comment');
        $query = $repository->createQueryBuilder('c')
            ->where('c.product = :product')
            ->setParameter('product', $product)
            ->orderBy('c.date', 'DESC')
            ->getQuery();

        $comments = $query->getResult();

        return $this->render('default/product_details.html.twig',
            array('product' => $product, 'form' => $form->createView(), 'comment_form' => $comment_form->createView(), 'comments' => $comments));
    }

    /**
     * @Route("/page/{titleRewrited}", name="page")
     */
    public function pageAction($titleRewrited)
    {
        $repository = $this->getDoctrine()
            ->getRepository('ShopBundle:StaticPage');

        $query = $repository->createQueryBuilder('s')
            ->where('s.titleRewrited = :title')
            ->setParameter('title', $titleRewrited)
            ->getQuery();

        $current_page = $query->getResult();

        if ($current_page != null) {
            return $this->render('default/static_page.html.twig', array('page' => $current_page[0]));
        } else {
            throw $this->createNotFoundException();
        }
    }

    public function pagesAction()
    {
        $pages = $this->getDoctrine()->getRepository('ShopBundle:StaticPage')
            ->findAll();

        $uri = $_SERVER['REQUEST_URI'];
        return $this->render('default/static_pages.html.twig', array('pages' => $pages, 'uri' => $uri));
    }

    /**
     * @Route("/order/{id}/{amount}", name="order")
     */
    public function orderAction($id, $amount, Request $request)
    {

        if (!empty($request->getSession()->get('products'))) {
            $products_array = $request->getSession()->get('products');
        }
        $products_array[] = array('id' => $id, 'amount' => $amount);
        $request->getSession()->set('products', $products_array);
//        dump($request->getSession()->get('products'));
//        return new Response();

        $product = $this->getDoctrine()->getRepository('ShopBundle:Product')
            ->find($id);
        $this->addFlash('success', 'Pomyślnie dodano ' . $amount . 'sztuk produktu ' . $product->getName() . ' do koszyka.');

        return $this->redirectToRoute('cart');

    }

    /**
     * @Route("/cart/delete/{id}", name="cart_delete")
     */
    public function cartDeleteAction($id, Request $request)
    {
        $products_array = $request->getSession()->get('products');

        unset($products_array[$id]);
        $request->getSession()->set('products', $products_array);

        $this->addFlash('danger', 'Usunięto produkt z koszyka.');

        return $this->redirectToRoute('cart');
    }

    /**
     * @Route("/cart", name="cart")
     */
    public function cartAction(Request $request, UserInterface $user = null)
    {


        $carriers = $this->getDoctrine()->getRepository('ShopBundle:Carrier')
            ->findAll();

        $carriers_choices = array();

        foreach ($carriers as $c) {
            if ($c->getActive()) {
                $carriers_choices[$c->getName() . ', koszt ' . $c->getCost() . 'zł, czas dostarczenia ' . $c->getDeliveryTime() . ' dni.'] = $c;
            }
        }

        $form = $this->createFormBuilder()
            ->add('carrier', ChoiceType::class,
                array('label' => 'Sposób dostarczenia produktów', 'choices' => $carriers_choices))
            ->add('notice', TextareaType::class, array('label' => 'Uwagi do zamówienia', 'required' => false))
            ->add('save', SubmitType::class, array('label' => 'Potwierdź zakupy', 'attr' => array('class' => 'btn btn-success btn-block')))
            ->getForm();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            if (!$this->get('security.authorization_checker')->isGranted('IS_AUTHENTICATED_FULLY')) {
                return $this->redirectToRoute('fos_user_security_login');
            } else {
                $user = $this->get('security.token_storage')->getToken()->getUser();

                $data = $form->getData();
                $order = new Orders();
                $order->setDate(new \DateTime(date("Y-m-d H:i:s")));
                $order->setNotice($data['notice']);
                $order->setCarrier($data['carrier']);
                $order->setUser($user);
                $em = $this->getDoctrine()->getManager();
                $em->persist($order);
                $em->flush();

                $products = $request->getSession()->get('products');

                foreach ($products as $product) {
                    $product_from_db = $this->getDoctrine()->getRepository('ShopBundle:Product')
                        ->find($product['id']);

                    $orders_products = new OrdersProducts();
                    $orders_products->setOrder($order);
                    $orders_products->setAmount(intval($product['amount']));
                    $orders_products->setProduct($product_from_db);
                    $em = $this->getDoctrine()->getManager();
                    $em->persist($orders_products);
                    $em->flush();
                }

                $request->getSession()->remove('products');

                return $this->redirectToRoute('order_confirmation', array('id' => $order->getId()));
            }
        }

        $products = $this->getDoctrine()->getRepository('ShopBundle:Product')
            ->findAll();

        return $this->render('default/cart.html.twig', array('products' => $products, 'form' => $form->createView()));

    }


    /**
     * @Route("/orders", name="my_orders")
     */
    public function myOrdersAction(Request $request, UserInterface $user)
    {
        $user = $this->get('security.token_storage')->getToken()->getUser();

        $repository = $this->getDoctrine()
            ->getRepository('ShopBundle:Orders');

        $query = $repository->createQueryBuilder('o')
            ->where('o.user = :user')
            ->setParameter('user', $user)
            ->orderBy('o.date', 'DESC')
            ->getQuery();

        $orders = $query->getResult();

        return $this->render('default/my_orders.html.twig', array('orders' => $orders));
    }

    /**
     * @Route("/order_confirmation/{id}", name="order_confirmation")
     */
    public function orderConfirmationAction($id, Request $request, UserInterface $user)
    {
        $user = $this->get('security.token_storage')->getToken()->getUser();

        $repository = $this->getDoctrine()
            ->getRepository('ShopBundle:Orders');

        $query = $repository->createQueryBuilder('o')
            ->where('o.user = :user AND o.id = :id')
            ->setParameters(array('user' => $user, 'id' => $id))
            ->orderBy('o.date', 'DESC')
            ->getQuery();

        $order = $query->getResult();

        $bank = $this->getDoctrine()->getRepository('ShopBundle:Bank')
            ->find(1);

        return $this->render('default/order_confirmation.html.twig', array('order' => $order, 'bank' => $bank));
    }


    public function searchFormAction(Request $request)
    {
        $form = $this->createFormBuilder()
            ->setAction($this->generateUrl('search'))
            ->setMethod('GET')
            ->add('search', TextType::class, array('attr' => array('placeholder' => 'Wpisz nazwę lub atrybut', 'class' => 'form-control')))
            ->add('save', SubmitType::class, array('label' => 'Wyszukaj', 'attr' => array('class' => 'btn btn-default')))
            ->getForm();

        $form->handleRequest($request);

        return $this->render('default/search.html.twig', array('form' => $form->createView()));
    }

    /**
     * @Route("/search", name="search")
     */
    public function searchAction(Request $request)
    {
        $form = $request->query->get('form');

        $repository = $this->getDoctrine()->getRepository('ShopBundle:Product');
        $query = $repository->createQueryBuilder('p')
            ->where('p.description LIKE :name OR p.name LIKE :name')
            ->setParameter('name', '%' . $form['search'] . '%')
            ->getQuery();

        $result = $query->getResult();

        if (empty($result)) {
            foreach (explode(' ', $form['search']) as $ch) {
                if (intval($ch) != 0) {
                    $ch = intval($ch);
                }
                $search_elements[] = $ch;
            }

            foreach ($search_elements as $element) {
                if (is_numeric($element)) {
                    $query = $repository->createQueryBuilder('p')
                        ->where('p.price = :integer OR p.width = :integer OR p.height = :integer OR p.depth = :integer OR p.weight = :integer')
                        ->setParameter('integer', $element)
                        ->getQuery();
                } else {
                    $query = $repository->createQueryBuilder('p')
                        ->where('p.description LIKE :name OR p.name LIKE :name')
                        ->setParameter('name', '%' . $element . '%')
                        ->getQuery();
                }
                $result[$element] = $query->getResult();
            }
        }

        return $this->render('default/search_result.html.twig', array('result' => $result));
    }

}
