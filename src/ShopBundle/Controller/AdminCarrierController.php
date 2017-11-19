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

class AdminCarrierController extends Controller
{

    /**
     * @Route("admin/carriers", name="carriers")
     */
    public function carriersAction(Request $request)
    {
        $carrier = new Carrier();
        $form = $this->createformBuilder($carrier)
            ->add('name', TextType::class, array('label' => 'Nazwa przewoźnika'))
            ->add('delivery_time', IntegerType::class, array('label' => 'Czas Przesyłki (dni)'))
            ->add('cost', NumberType::class, array('label' => 'Koszt przesyłki'))
            ->add('max_weight', NumberType::class, array('label' => 'Maksymalna waga przesyłki (kg)'))
            ->add('active', CheckboxType::class, array(
                'label' => 'Dostępny',
                'required' => false,
                'attr' => array('checked' => true)
            ))
            ->add('save', SubmitType::class, array('label' => 'Dodaj przewoźnika'))
            ->getForm();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $carrier = $form->getData();

            $em = $this->getDoctrine()->getManager();
            $em->persist($carrier);
            $em->flush();

            $this->addFlash(
                'success',
                'Dodano przewoźnika o nazwie ' . $carrier->getName()
            );

            return $this->redirectToRoute('carriers');
        }

        $carriers = $this->getDoctrine()->getRepository('ShopBundle:Carrier')
            ->findAll();

        return $this->render('Admin/carriers.html.twig', array(
            'form' => $form->createView(),
            'carriers' => $carriers));

    }


    /**
     * @Route("admin/carrier/edit/{id}", name="carrier_edit")
     */
    public function carrierEditAction($id, Request $request)
    {
        $carrier = $this->getDoctrine()->getRepository('ShopBundle:Carrier')
            ->find($id);

        $activeState = $carrier->getActive();

        $form = $this->createFormBuilder($carrier)
            ->add('name', TextType::class, array('label' => 'Nazwa przewoźnika'))
            ->add('delivery_time', IntegerType::class, array('label' => 'Czas Przesyłki (dni)'))
            ->add('cost', NumberType::class, array('label' => 'Koszt przesyłki'))
            ->add('max_weight', NumberType::class, array('label' => 'Maksymalna waga przesyłki (kg)'))
            ->add('active', CheckboxType::class, array(
                'label' => 'Dostępny',
                'required' => false,
                'attr' => array('checked' => $activeState)))
            ->add('save', SubmitType::class, array('label' => 'Edytuj przewoźnka'))
            ->getForm();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $carrier = $form->getData();

            $em = $this->getDoctrine()->getManager();
            $em->persist($carrier);
            $em->flush();
            $this->addFlash(
                'success',
                'Edytowano przewoźnika o nazwie: ' . $carrier->getName()
            );
            return $this->redirectToRoute('carriers');
        }

        return $this->render('Admin/carrier_edit.html.twig', array('form' => $form->createView(), 'carrier' => $carrier));
    }

    /**
     * @Route("admin/carrier/delete/{id}", name="carrier_delete")
     */
    public function carrierDeleteAction($id)
    {
        $carrier = $this->getDoctrine()->getRepository('ShopBundle:Carrier')
            ->find($id);

        $em = $this->getDoctrine()->getEntityManager();
        $em->remove($carrier);
        $em->flush();

        $this->addFlash(
            'success',
            'Usunięto przewoźnika o id: ' . $id
        );

        return $this->redirectToRoute('carriers');

    }
}
