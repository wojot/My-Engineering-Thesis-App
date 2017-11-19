<?php
namespace ShopBundle\Form;

//use FOS\UserBundle\Util\LegacyFormHelper;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;

class ProfileType extends AbstractType
{

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name', TextType::class, array('label' => 'form.name', 'translation_domain' => 'FOSUserBundle'))
            ->add('surname', TextType::class, array('label' => 'form.surname', 'translation_domain' => 'FOSUserBundle'))
            ->add('postcode', TextType::class, array('label' => 'form.postcode', 'translation_domain' => 'FOSUserBundle'))
            ->add('city', TextType::class, array('label' => 'form.city', 'translation_domain' => 'FOSUserBundle'))
            ->add('street', TextType::class, array('label' => 'form.street', 'translation_domain' => 'FOSUserBundle'))
            ->add('tel', TextType::class, array('label' => 'form.tel', 'translation_domain' => 'FOSUserBundle'));
    }

    public function getParent()
    {
        return 'FOS\UserBundle\Form\Type\ProfileFormType';
    }

    public function getBlockPrefix()
    {
        return 'fos_user_profile_edit';
    }

//    // For Symfony 2.x
//    public function getName()
//    {
//        return $this->getBlockPrefix();
//    }
}