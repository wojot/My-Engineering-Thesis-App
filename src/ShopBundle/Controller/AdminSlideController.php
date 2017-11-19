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

class AdminSlideController extends Controller
{
    /**
     * @Route("admin/slides", name="slides")
     */
    public function slidesAction(Request $request)
    {
        $slide = New Slide();

        $form = $this->createFormBuilder()
            ->add('image', FileType::class, array('label' => 'Zdjęcie slajdu'))
//            ->add('position', IntegerType::class, array('label' => 'Pozycja'))
            ->add('save', SubmitType::class, array('label' => 'Dodaj slajd'))
            ->getForm();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $data = $form->getData();

            $repository = $this->getDoctrine()
                ->getRepository('ShopBundle:Slide');
            $query = $repository->createQueryBuilder('s')
                ->select('MAX(s.position)')
                ->setMaxResults(1)
                ->getQuery();
            $max_position = $query->getResult();

            $slide->setPosition(intval($max_position[0][1]) + 1);
            $image = $data['image'];
            $image_name = md5(uniqid()) . $image->guessExtension();
            $slide->setImage($image_name);
            $image->move($this->getParameter('images'), $image_name);

            $em = $this->getDoctrine()->getManager();
            $em->persist($slide);
            $em->flush();

            $this->addFlash(
                'success',
                'Dodano nowy slajd');

            return $this->redirectToRoute('slides');
        }

        $repository = $this->getDoctrine()->getRepository('ShopBundle:Slide');
        $query = $repository->createQueryBuilder('s')
            ->orderBy('s.position', 'DESC')
            ->getQuery();

        $slides = $query->getResult();

        return $this->render('Admin/slides.html.twig', array('form' => $form->createView(), 'slides' => $slides));
    }

    /**
     * @Route("admin/slide/delete/{id}", name="slide_delete")
     */
    public function slideDeleteAction($id)
    {
        $slide = $this->getDoctrine()->getRepository('ShopBundle:Slide')
            ->find($id);

        $em = $this->getDoctrine()->getEntityManager();
        $em->remove($slide);
        $em->flush();

        $this->addFlash(
            'success',
            'Usunięto slajd o id: ' . $id
        );

        $this->setPositions();

        return $this->redirectToRoute('slides');

    }

    /**
     * @Route("admin/slide/position_up/{id}", name="slide_up")
     */
    public function slidePositionUpAction($id)
    {
        $current_slide = $this->getDoctrine()->getRepository('ShopBundle:Slide')
            ->find($id);

        $current_slide_position = $current_slide->getPosition();

        $repository = $this->getDoctrine()
            ->getRepository('ShopBundle:Slide');

        $query = $repository->createQueryBuilder('s')
            ->where('s.position >= :position')
            ->setParameter('position', $current_slide->getPosition())
            ->orderBy('s.position', 'ASC')
            ->getQuery();

        $slides = $query->getResult();


        foreach ($slides as $slide) {
            if ($slide->getPosition() == $current_slide_position && $current_slide->getId() == $id) {
                $slide->setPosition($slide->getPosition() + 1);
                $em = $this->getDoctrine()->getEntityManager();
                $em->persist($slide);
                $em->flush();
            } elseif ($slide->getPosition() - 1 == $current_slide_position) {
                $slide->setPosition($slide->getPosition() - 1);
                $em = $this->getDoctrine()->getEntityManager();
                $em->persist($slide);
                $em->flush();

            }

        }
        $this->setPositions();

        $this->addFlash(
            'success',
            'Zmieniono pozycję slajdu o id: ' . $id
        );

        return $this->redirectToRoute('slides');
    }

    /**
     * @Route("admin/slide/position_down/{id}", name="slide_down")
     */
    public function slidePositionDownAction($id)
    {
        $current_slide = $this->getDoctrine()->getRepository('ShopBundle:Slide')
            ->find($id);

        $current_slide_position = $current_slide->getPosition();

        $repository = $this->getDoctrine()
            ->getRepository('ShopBundle:Slide');

        $query = $repository->createQueryBuilder('s')
            ->where('s.position <= :position')
            ->setParameter('position', $current_slide->getPosition())
            ->orderBy('s.position', 'ASC')
            ->getQuery();

        $slides = $query->getResult();


        foreach ($slides as $slide) {
            if ($slide->getPosition() == $current_slide_position && $current_slide->getId() == $id) {
                $slide->setPosition($slide->getPosition() - 1);
                $em = $this->getDoctrine()->getEntityManager();
                $em->persist($slide);
                $em->flush();
            } elseif ($slide->getPosition() - 1 == $current_slide_position) {
                $slide->setPosition($slide->getPosition() + 1);
                $em = $this->getDoctrine()->getEntityManager();
                $em->persist($slide);
                $em->flush();

            }

        }
        $this->setPositions();

        $this->addFlash(
            'success',
            'Zmieniono pozycję slajdu o id: ' . $id
        );

        return $this->redirectToRoute('slides');
    }


    public function setPositions()
    {
        $repository = $this->getDoctrine()
            ->getRepository('ShopBundle:Slide');

        $query = $repository->createQueryBuilder('s')
            ->orderBy('s.position', 'ASC')
            ->getQuery();

        $slides = $query->getResult();

        for ($i = 1; $i <= count($slides); $i++) {
            $slides[$i - 1]->setPosition($i);

            $em = $this->getDoctrine()->getManager();
            $em->persist($slides[$i - 1]);
            $em->flush();
        }
    }
}
