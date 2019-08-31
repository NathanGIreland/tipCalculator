//
//  SettingsViewController.swift
//  tipCalc
//
//  Created by Nathan Ireland on 8/27/19.
//  Copyright © 2019 Nathan Ireland. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var currencySegmentController: UISegmentedControl!
    
    //Declaration of UserDefaults
    let defaults = UserDefaults.standard
    
    //Static variables needed for settingsViewController functions
    var ViewController:ViewController?
    var currencyChoice = 0
    
    //Function makes sure important values are loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        restoreValues()
        self.currencyChoice = 0;
        self.title = "TIP CALCULATOR"
    }
    
    //Prepares values that are needed for the viewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backVC = segue.destination as! ViewController //backVC is a reference to ViewController
        
        //Update Currency
        backVC.currency = currencySegmentController.selectedSegmentIndex
        saveValues()
        backVC.calculateTip(0)
        backVC.saveValues()
    }
    
    //Fuction to save userDefaults such as the currency selected
    func saveValues(){
    defaults.set(currencySegmentController.selectedSegmentIndex, forKey: "currencySeg")
        
        defaults.synchronize()
    }
 
    //Fuction to restore userDefaults such as currency selection

    func restoreValues(){
        currencySegmentController.selectedSegmentIndex = defaults.integer(forKey: "currencySeg")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
