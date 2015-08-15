//
//  Solver.swift
//  ExpressionEngine
//
//  Created by Laszlo Korte on 07.08.15.
//  Copyright © 2015 Laszlo Korte. All rights reserved.
//

class Solver {
    let dataSet : WritableDataSet
    
    init(dataSet: WritableDataSet) {
        self.dataSet = dataSet
    }
    
    func evaluate(sheet : Sheet)
    {
    
        dataSet.clear();

        for defValue in sheet.sortedDefinitions {
            let id = defValue.id
            
            switch defValue.value {
            case .Array(_):
                fatalError()
            case .Expr(let expr):
                let result = expr.eval(dataSet)
                switch result {
                case .Success(let value):
                    dataSet.put(id, value: value)
                case .Fail(let error):
                    dataSet.put(id, value: Value.IntValue(value: 0))
                    dataSet.markError(id, error: error)
                }
            case .Primitive(let value):
                dataSet.put(id, value: value)
            default:
                break
            }
        }
    
    }
}

public class WritableDataSet : DataSet {
    var data : [ReferenceId:Value] = [ReferenceId:Value]()
    var errors: [ReferenceId:EvaluationError] = [ReferenceId:EvaluationError]()
    
    public init() {
    }
    
    public func lookUp(id: ReferenceId) -> Value? {
        return data[id]
    }
    
    public func getError(id: ReferenceId) -> EvaluationError? {
        return errors[id]
    }
    
    func put(id: ReferenceId, value: Value) {
        data[id] = value
    }
    
    func markError(id: ReferenceId, error: EvaluationError) {
        errors[id] = error
    }
    
    func clear() {
        errors.removeAll()
        data.removeAll()
    }
}