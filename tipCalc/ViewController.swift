//
//  ViewController.swift
//  tipCalc
//
//  Created by Nathan Ireland on 8/22/19.
//  Copyright © 2019 Nathan Ireland. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var numberInGroupPicker: UIPickerView!
    @IBOutlet weak var numberLabel: UILabel!
  
    
    var selectedPick = 0
    var result = 0.0
    
    var itemsPicker = ["0","1", "2", "3", "4", "5"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return itemsPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemsPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPick = row
        calculateTip(0)
    }

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        totalLabel.text = "0.00"
        tipLabel.text = "0.00"
        
        self.numberInGroupPicker.delegate = self
        self.numberInGroupPicker.dataSource = self

    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @IBAction func calculateTip(_ sender: Any) {
        //Get Bill amount
        let bill = Double(billField.text!) ?? 0
        
        //cal tip and total
        let tipPercentages = [0.15, 0.18, 0.2]
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        //update tip and total
        
        if(selectedPick == 0){
            tipLabel.text = String(format: "%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
        }else{
            print(selectedPick + 1)
            tipLabel.text = String(format: "%.2f", tip)
            result =  total /  Double(selectedPick + 1)
            totalLabel.text = String(format: "%.2f", result)
    }
  }
}

