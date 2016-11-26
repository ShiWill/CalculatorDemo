//
//  ViewController.swift
//  Calculator
//
//  Created by Will on 2016/11/24.
//  Copyright © 2016年 Will. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var screenLabel: UILabel!
    var isInputing: Bool = false
    var operandArr: NSMutableArray = []
    var operation: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        screenLabel.text = "0"
        screenLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clear(_ sender: UIButton) {
        operation = ""
        isInputing = false
        screenLabel.text = "0"
        operandArr.removeAllObjects()
    }
    
    @IBAction func enterNumber(_ sender: UIButton) {
        let number = sender.titleLabel?.text!

        if isInputing {
            if screenLabel.text == "0" {
                if number == "." {
                    screenLabel.text = "0\(number!)"
                } else {
                    screenLabel.text = "\(number!)"
                }
            } else {
                screenLabel.text = screenLabel.text! + "\(number!)"
            }
        } else {
            isInputing = true
            if number == "." {
                screenLabel.text = "0\(number!)"
            } else {
                screenLabel.text = "\(number!)"
            }
        }
    }
    
    @IBAction func operation(_ sender: UIButton) {
        isInputing = false
        operandArr.add(screenLabel.text!)
        if operandArr.count >= 2 { showResult(isEqual: false) }
        operation = (sender.titleLabel?.text!)!
    }
    
    @IBAction func negate(_ sender: UIButton) {
        let nDouble: Double = Double(screenLabel.text!)!
        var nResult: Double = 0.0
        if nDouble > 0 {
            nResult = 0 - nDouble
        } else if nDouble < 0 {
            nResult = abs(nDouble)
        }
        
        let nNumber: NSNumber = nResult as NSNumber
        screenLabel.text = nNumber.stringValue
    }
    
    @IBAction func pecent(_ sender: UIButton) {
        let nDouble: Double = Double(screenLabel.text!)!
        let nNumber: NSNumber = nDouble/100 as NSNumber
        screenLabel.text = nNumber.stringValue
    }
    
    @IBAction func deleteNum(_ sender: UIButton) {
        if isInputing {
            let origin: String = screenLabel.text!
            let endIndex = origin.index(origin.startIndex, offsetBy: origin.characters.count-1)
            screenLabel.text = origin.substring(to: endIndex)
        }
    }
    
    @IBAction func equal(_ sender: UIButton) {
        isInputing = false
        
        if operation == "" { return }
        
        operandArr.add(screenLabel.text!)
        if operandArr.count == 1 {
            operandArr.add(screenLabel.text!)
        }
        
        showResult(isEqual: true)
    }
    
    func showResult(isEqual: Bool) {
        let rDouble: Double = calculateResult(operation: operation, operandArr: operandArr)
        let rNumber: NSNumber = rDouble as NSNumber
        let result: String = rNumber.stringValue
        
        operandArr.removeAllObjects()
        screenLabel.text = result
        
        if !isEqual { operandArr.add(result) }
    }
    
    func calculateResult(operation: String, operandArr: NSMutableArray) -> Double {
        let firstNum: Double = Double(operandArr[0] as! String)!
        let secondNum: Double = Double(operandArr[1] as! String)!
        var result: Double = 0
        
        switch operation {
        case "+":   result = (firstNum + secondNum)
        case "-":   result = (firstNum - secondNum)
        case "×":   result = (firstNum * secondNum)
        case "÷":   result = (firstNum / secondNum)
        default:    break
        }
        
        return result
    }
}

