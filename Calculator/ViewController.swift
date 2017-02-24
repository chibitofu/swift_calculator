//
//  ViewController.swift
//  Calculator
//
//  Created by Erin Moon on 2/22/17.
//  Copyright © 2017 Erin Moon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsTyping = false

    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if userIsTyping {
           
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
            
        } else {
            
            display.text = digit
            userIsTyping = true
            
        }
        
    }
    
    var displayValue : Double {
        
        get {
            
            return Double(display.text!)!
            
        }
        
        set {
            
           display.text = String(newValue)
            
        }
        
    }
    
    private var brain: calculatorBrain = calculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
        
    }
    
    

}

