//
//  ViewController.swift
//  tipCalc
//
//  Created by Nathan Ireland on 8/22/19.
//  Copyright © 2019 Nathan Ireland. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //IBOutlets
    @IBOutlet weak var tipCurrUpdateLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalMoneyIconLabel: UILabel!
    @IBOutlet weak var tipMoneyIconLabel: UILabel!
    @IBOutlet weak var numberInGroupPicker: UIPickerView!
    @IBOutlet weak var numberLabel: UILabel!
    
    let color1 = UIColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    
    //Declaration of UserDefaults
    let defaults = UserDefaults.standard
    
    //Static variables needed for viewController functions
    var currency = 0;
    var toConversion = 0;
    var selectedPick = 0
    var result = 0.0
    
    
    //Prepares values that are needed for the settingsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nvc = segue.destination as! SettingsViewController
        
        nvc.title = "TIP CALCULATOR"
        
    }
    
    //Unwind Seque to change view controller from settings to main
    @IBAction func unwind(_ sender: UIStoryboardSegue) {
        saveValues()
    }
    
    //Array of the values that go into the picker
    var itemsPicker = ["0","1", "2", "3", "4", "5"]
    
    //Function below set the amount of columns in the UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    //Function below set the amount of rows in the UIPickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return itemsPicker.count
    }
    
    //Function below set the values of the UIPickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemsPicker[row]
    }
    
    //Function below updates values based on what the user chose in the UIPickerView
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPick = row
        calculateTip(0)
    }

    
    
    
    
    //Function makes sure important values are loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        totalLabel.text = "0.00"
        tipLabel.text = "0.00"
        

        
        self.numberInGroupPicker.delegate = self
        self.numberInGroupPicker.dataSource = self
        self.numberInGroupPicker.setValue(color1, forKey: "textColor")
        
        restoreValues()
        calculateTip(0)

    }

    
    //Function calculates tip & and updates labels
    @IBAction func calculateTip(_ sender: Any) {
        saveValues()
        //Get Bill amount
        var bill = Double(billField.text!) ?? 0
        
        //Cal tip and total
        let tipPercentages = [0.15, 0.18, 0.2]
        let currencyConversion = [1.0, 0.81, 0.90, 105.80, 1.33]
        let currencyIcons = ["$", "€", "£", "¥", "CAD"]
        
        toConversion = self.currency
        
        bill = bill * currencyConversion[toConversion]
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
    
        
        if(toConversion > -1 && toConversion < 4){ //If toConversion is between -1 & 5 changes currency label based array
            tipMoneyIconLabel.text = currencyIcons[toConversion]
            totalMoneyIconLabel.text = currencyIcons[toConversion]
            numberLabel.text = "Total"
            tipCurrUpdateLabel.text = "Total"
        }else{ //Changes tip and total lable if to CAD if toConversion is 5
            tipMoneyIconLabel.text = currencyIcons[0]
            totalMoneyIconLabel.text = currencyIcons[0]
            numberLabel.text = "Total (\(currencyIcons[toConversion]))"
            tipCurrUpdateLabel.text = "Total (\(currencyIcons[toConversion]))"
        }
        
        //Update tip and total
        
        if(selectedPick == 0){ //If picker is set to zero, tip calculate for one person
            tipLabel.text = String(format: "%.2f", tip)
            totalLabel.text = String(format: "%.2f", total)
        }else{ //If picker is set to more than zero, tip calculate for addtional people
            tipLabel.text = String(format: "%.2f", tip)
            result =  total /  Double(selectedPick + 1)
            totalLabel.text = String(format: "%.2f", result)
    }
  }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    //Function to save userDefaults such as the default tip and currency
    func saveValues(){
        defaults.set(tipControl.selectedSegmentIndex, forKey: "defaultTip")
        
        defaults.set(self.currency, forKey: "currencyChoice")
        
        defaults.synchronize()
    }
    
    //Function to restore userDefaults such as the default tip and currency
    func restoreValues(){
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTip")
        
        self.currency = defaults.integer(forKey: "currencyChoice")
    }
}

