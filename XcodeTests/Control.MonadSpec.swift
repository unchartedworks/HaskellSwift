//
//  Control.MonadSpec.swift
//  HaskellSwift
//
//  Created by Liang on 24/09/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation
//import XCTest
import Quick.QuickSpec
import Nimble
@testable import HaskellSwift

class ControlMonadSpec: QuickSpec {
    override func spec() {
        let square: Int -> [Int]           = { (x: Int) -> [Int] in
            return [x*x]
        }
        
        let isEven: Int -> [Bool]           = { (x: Int) -> [Bool] in
            let r = x % 2 == 0
            return [r]
        }
        
        let name = { (x: Int) -> String? in
            return x % 2 == 0 ? "even" : nil
        }
        
        let len = { (x: String) -> Int? in
            return x.characters.count
        }
        
        describe(">>>= and >=> , >>>") {
            it("Array") {
                let xs : [Int]  = [1, 2, 3]
                let ys          = [false, true, false]
                let zs : [Int]  = [1, 3, 5]
                
                let bs          = xs >>>= square
                let r0          = bs >>>= isEven
                expect(r0).to(equal(ys))
                
                let f           = square >=> isEven
                let r1          = xs >>>= f
                expect(r1).to(equal(ys))

                let r2          = xs >>>= square >>>= isEven
                expect(r2).to(equal(ys))

                let trueOrEmpty = { (x: Bool) -> [Bool] in return x ? [x] : [] }
                let r3          = xs >>>= square >>>= isEven >>>= trueOrEmpty >>> [100]
                expect(r3).to(equal([100]))

                let r4          = zs >>>= square >>>= isEven >>>= trueOrEmpty >>> [100]
                expect(r4).to(equal([]))
            }

            it("Maybe") {
                let a           = 2
                let c           = 4
                
                let b           = a >>>= name
                let r0          = b >>>= len
                expect(r0).to(equal(c))
                
                let f           = name >=> len
                let r1          = f(a)
                expect(r1).to(equal(c))

                let r2          = a >>>= name >>>= len
                expect(r2).to(equal(c))

                let r3          = 3 >>>= name >>>= len >>> "even"
                expect(r3).to(beNil())

                let r4          = 2 >>>= name >>>= len >>> "even"
                expect(r4).to(equal("even"))
            }
        }
        
        describe("=<<< and <=<, <<<") {
            it("Array") {
                let xs : [Int]  = [1, 2, 3]
                let ys          = [false, true, false]
                let zs : [Int]  = [1, 3, 5]
                
                let bs          = square =<<< xs
                let r0          = isEven =<<< bs
                expect(r0).to(equal(ys))
                
                let f           = isEven <=< square
                let r1          = f =<<< xs
                expect(r1).to(equal(ys))
                
                let r2          = isEven =<<< square =<<< xs
                expect(r2).to(equal(ys))
                
                let trueOrEmpty = { (x: Bool) -> [Bool] in return x ? [x] : [] }
                let r3          = [false] <<< trueOrEmpty =<<< isEven =<<< square =<<< xs
                expect(r3).to(equal([true]))

                let r4          = [false] <<< trueOrEmpty =<<< isEven =<<< square =<<< zs
                expect(r4).to(equal([false]))
            }
            
            it("Maybe") {
                let a           = 2
                let c           = 4
                
                let b           = name =<<< a
                let r0          = len =<<< b
                expect(r0).to(equal(c))
                
                let f           = len <=< name
                let r1          = f =<<< a
                expect(r1).to(equal(c))
                
                let r2          = len =<<< name =<<< a
                expect(r2).to(equal(c))

                let r3          = "even" <<< len =<<< name =<<< 3
                expect(r3).to(beNil())

                let r4          = "even" <<< len =<<< name =<<< 2
                expect(r4).to(equal("even"))
            }
        }

        describe("pure/return") {
            it("Array") {
                let xs: [Int] = pure(3)
                expect(xs).to(equal([3]))
            }

            it("Maybe") {
                let x: Int? = pure(3)
                expect(x).to(equal(3))
            }
        }
    }
}
