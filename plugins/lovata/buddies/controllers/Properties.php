<?php namespace Lovata\Buddies\Controllers;

use BackendMenu;
use Backend\Classes\Controller;

/**
 * Class Properties
 * @package Lovata\Buddies\Controllers
 * @author Andrey Kharanenka, a.khoronenko@lovata.com, LOVATA Group
 */
class Properties extends Controller
{
    public $implement = [
        'Backend.Behaviors.ListController',
        'Backend.Behaviors.FormController',
        'Backend.Behaviors.ReorderController',
    ];

    public $listConfig = 'config_list.yaml';
    public $formConfig = 'config_form.yaml';
    public $reorderConfig = 'config_reorder.yaml';

    /**
     * Properties constructor.
     */
    public function __construct()
    {
        parent::__construct();
        BackendMenu::setContext('Lovata.Buddies', 'main-menu-buddies', 'side-menu-buddies-property');
    }
}