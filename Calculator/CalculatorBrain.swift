//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Erin Moon on 2/24/17.
//  Copyright © 2017 Erin Moon. All rights reserved.
//

import Foundation

struct calculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "√" : Operation.unaryOperation(sqrt),
        "x" : Operation.binaryOperation({ $0 * $1 }),
        "=" : Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBindingOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
                break
            case .equals:
                break
            }
        }
    }
    
    private mutating func performPendingBinaryOepration() {
        if pendingBindingOperation != nil && accumulator != nil {
            accumulator = pendingBindingOperation!.perform(with: accumulator!)
            pendingBindingOperation = nil
        }
    }
    
    private var pendingBindingOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
}
