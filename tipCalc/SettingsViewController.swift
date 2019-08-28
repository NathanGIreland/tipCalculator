//
//  SettingsViewController.swift
//  tipCalc
//
//  Created by Nathan Ireland on 8/27/19.
//  Copyright © 2019 Nathan Ireland. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var currencySegmentController: UISegmentedControl!
    var ViewController:ViewController?
    
    var currencyChoice = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currencyChoice = 0;
        self.title = "TIP CALCULATOR"

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func currencySegment(_ sender: Any) {
        currencyChoice = currencySegmentController.selectedSegmentIndex
        ViewController?.onUserAction(currency: currencyChoice)
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
