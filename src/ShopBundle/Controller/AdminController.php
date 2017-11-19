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

//use Symfony\Component\VarDumper;


class AdminController extends Controller
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
     * @Route("admin/users", name="users")
     */
    public function usersAction(Request $request)
    {
        $current_user = $request->query->get('user');

        $repository = $this->getDoctrine()->getRepository('ShopBundle:user');
        $users = $repository->findAll();


        return $this->render('Admin/users.html.twig', array('users' => $users, 'current_user' => $current_user));
    }

    /**
     * @Route("admin/bank_transfer", name="bank_transfer")
     */
    public function bankTransferAction(Request $request)
    {
        $bank = $this->getDoctrine()->getRepository('ShopBundle:Bank')
            ->find(1);

        $form = $this->createFormBuilder($bank)
            ->add('bankName', TextType::class, array('label' => 'Nazwa banku'))
            ->add('ownerName', TextType::class, array('label' => 'Nazwa właściciela'))
            ->add('IBAN', TextType::class, array('label' => 'Numer konta bankowego IBAN'))
            ->add('save', SubmitType::class, array('label' => 'Edytuj dane bankowe'))
            ->getForm();

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $bank = $form->getData();

            $em = $this->getDoctrine()->getManager();
            $em->persist($bank);
            $em->flush();

            $this->addFlash('success', 'Edytowano dane bankowe.');
            return $this->redirectToRoute('bank_transfer');
        }
        return $this->render('Admin/bank_transfer.html.twig', array('form' => $form->createView()));
    }


}
