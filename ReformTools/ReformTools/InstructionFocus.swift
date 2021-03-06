//
//  InstructionFocus.swift
//  ReformTools
//
//  Created by Laszlo Korte on 17.08.15.
//  Copyright © 2015 Laszlo Korte. All rights reserved.
//

import ReformCore

public final class InstructionFocus {
    public var current : InstructionNode?
    
    public init() {}

    public func isCurrent(_ node : Evaluatable) -> Bool {
        return current === node
    }
}
