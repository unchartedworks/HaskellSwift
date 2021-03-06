//
//  Num.swift
//  HaskellSwift
//
//  Created by Liang on 31/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation

//MARK: negate :: a -> a
public func negate<A: SignedNumeric & Comparable>(_ x: A) -> A {
    return -x
}

//MARK: abs :: a -> a
//It's a standard function and it's implemented already.

//MARK: signum :: a -> a
public func signum<A: SignedNumeric & Comparable>(_ x: A) -> A {
    if x > 0 {
        return 1 as! A
    } else if x < 0 {
        return -1 as! A
    } else {
        return 0 as! A
    }
}

