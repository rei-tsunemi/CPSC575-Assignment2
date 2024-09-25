//
//  ViewController.swift
//  CPSC575-Assignment2
//  Team Momenta
//  Created by
//      Rei Tsunemi - 30121202
//      Emir Avci   - 
//  Date: 2024-09-25
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // Name field
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    // Number field
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    // SliderField
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValueLabel: UILabel!
    // Outlets for the switches
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    // Outlets for switches and button
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var doSomethingButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameTextField.delegate = self
        
        // set the initial value of the slider label
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50  // Default value
        sliderValueLabel.text = " \(Int(slider.value))"
        
        // Initially, show the switches and hide the button
        switch1.isHidden = false
        switch2.isHidden = false
        doSomethingButton.isHidden = true

    }

    // Dismiss keyboard and handle empty name field
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // Check if the name field is empty
        if let name = textField.text, name.isEmpty {
            nameLabel.text = "Name field has been cleared."
        } else {
            nameLabel.text = "Hello, \(textField.text ?? "")!"
        }
        
        return true
    }
    
    // IBAction for the Set Number button
    @IBAction func setNumberButtonTapped(_ sender: UIButton) {
        numberTextField.resignFirstResponder()
        
        // Check if the number field is empty
        if let number = numberTextField.text, number.isEmpty {
            numberLabel.text = "Number field has been cleared."
        } else {
            numberLabel.text = "The entered number is: \(numberTextField.text ?? "")"
        }
    }
    
    // IBAction triggered when the slider moves
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let sliderValue = Int(sender.value)  // Convert to Int for whole number display
        sliderValueLabel.text = "\(sliderValue)"
    }
    
    // IBAction to synchronize switch states
    @IBAction func switchToggled(_ sender: UISwitch) {
        let switchState = sender.isOn
        // Update both switches to the same state
        switch1.setOn(switchState, animated: true)
        switch2.setOn(switchState, animated: true)
    }
    
    // IBAction for UISegmentedControl to toggle views
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 { // "Switches" selected
            switch1.isHidden = false
            switch2.isHidden = false
            doSomethingButton.isHidden = true
        } else if sender.selectedSegmentIndex == 1 { // "Button" selected
            switch1.isHidden = true
            switch2.isHidden = true
            doSomethingButton.isHidden = false
        }
    }

    // IBAction for "Do Something" button to show an alert
    @IBAction func doSomethingButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Something was done.", message: "Everything's fine. You can breathe easy now and continue.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

}

