//
//  HaskellSwiftTests.swift
//  HaskellSwiftTests
//
//  Created by Liang on 14/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Quick
import Nimble
//import SwiftCheck
@testable import HaskellSwift

class DataList0Spec: QuickSpec {
    override func spec() {
        let files           = ["README.md", "Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]
        
        describe("..") {
            it ("A->B->C|Int Array") {
                let process : ([Int]) -> Int = last .. reverse
                let ints            = [1,2,3,4,5]
                expect(process(ints)).to(equal(1))
            }
            
            it("A->B->C|String Array") {
                let process : ([String])->String = last .. initx .. reverse
                let words           = ["Very", "Good", "Person"]
                let result          = process(words)
                expect(result).to(equal("Good"))
            }
            
            it("A->B->C|String") {
                let fs              = head .. reverse  .. reverse
                let result          = fs("ABC")
                expect(result).to(equal("A"))
            }
            
            it("A->B->C?") {
                let f0 : (Int) -> Int = { x in x + 1 }
                let f1 : (Int) -> Int? = { x in x % 2 == 0 ? .some(x + 1) : nil }
                let fs               = f1 .. f0
                expect(fs(0)).to(beNil())
                expect(fs(1)).to(equal(.some(3)))
            }
            
            it("A->B?->C") {
                let f0 : (Int) -> Int? = { x in .some(x) }
                let f1 : (Int?) -> Int = { x in x! + 1 }
                let fs               = f1 .. f0
                expect(fs(1)).to(equal(2))
            }
            
            it("A->B?->C?") {
                let f0 : (Int) -> Int? = { x in .some(x+1) }
                let f1 : (Int?) -> Int? = { x in .some(x! + 1) }
                let fs               = f1 .. f0
                expect(fs(1)).to(equal(3))
            }
            
            it("A?->B->C") {
                let f0 : (Int?) -> Int = { x in x ?? -1 }
                let f1 : (Int) -> Int  = { x in x + 1 }
                let fs               = f1 .. f0
                expect(fs(1)).to(equal(2))
                expect(fs(nil)).to(equal(0))
            }
            
            it("A?->B->C?") {
                let f0 : (Int?) -> Int = { x in x ?? -1 }
                let f1 : (Int) -> Int? = { x in .some(x + 1) }
                let fs               = f1 .. f0
                expect(fs(1)).to(equal(2))
                expect(fs(nil)).to(equal(.some(0)))
            }
            
//            it("A?->B?->C?") {
//                let f0 : Int? -> Int? = { x in x ?? .Some(-1) }
//                let f1 : Int? -> Int? = { x in .Some(x! + 1) }
//                let fs                = f1 .. f0
//                expect(fs(2)).to(equal(.Some(3)))
//                expect(fs(1)).to(equal(.Some(2)))
//                expect(fs(nil)).to(equal(0))
//            }
        }
        
        describe("not") {
            it("Bool") {
                expect(not(true)).to(beFalse())
                expect(not(false)).to(beTrue())
            }
        }
        
        describe("++") {
            it("Int Array") {
                let list1           = [1, 2, 3]
                let list2           = [4, 5, 6]
                let result          = list1 ++ list2
                expect(result).to(equal([1, 2, 3, 4, 5, 6]))
            }
            
            it("String Array") {
                let list1           = ["Hello"]
                let list2           = ["world", "Haskell!"]
                let result          = list1 ++ list2
                expect(result).to(equal(["Hello", "world", "Haskell!"]))
            }
            
            it("String") {
                let list1           = "Hello"
                let list2           = "world"
                let result          = list1 ++ list2
                expect(result).to(equal("Helloworld"))
            }
        }
        
        describe("head") {
            it("Int Array") {
                expect(head([1])).to(equal(1))
                expect(head([1,2,3])).to(equal(1))
            }
            
            it("String Array") {
                let result0 = head(["World"])
                expect(result0).to(equal("World"))
                let result1 = head(files)
                expect(result1).to(equal("README.md"))
            }
            
            it("String") {
                let result = head("World")
                expect(result).to(equal("W"))
                expect(head("W")).to(equal("W"))
            }
        }
        
        describe("last") {
            it("Int Array") {
                let result0 = last([1])
                expect(result0).to(equal(1))
                let result1 = last([1,2,3])
                expect(result1).to(equal(3))
            }
            
            it("String Array") {
                let result0 = last(["World"])
                expect(result0).to(equal("World"))
                expect(last(files)).to(equal(files[files.count - 1]))
            }
            
            it("String") {
                let result = last("World")
                expect(result).to(equal("d"))
                expect(last("W")).to(equal("W"))
            }
        }
        
        describe("tail") {
            it("Int Array") {
                expect(tail([1])).to(equal([Int]()))
                expect(tail([1,2,3])).to(equal([2,3]))
            }
            
            it("String Array") {
                expect(tail(["World"])).to(equal([String]()))
                let expectedFiles = Array(files[1..<(files.count)])
                expect(tail(files)).to(equal(expectedFiles))
            }
            
            it("String") {
                let result = tail("World")
                expect(result).to(equal("orld"))
                expect(tail("W")).to(equal(""))
            }
        }
        
        describe("initx") {
            it("Int Array") {
                expect(initx([1])).to(equal([Int]()))
                expect(initx([1,2])).to(equal([1]))
            }
            
            it("String Array") {
                expect(initx(["World"])).to(equal([String]()))
                expect(initx(files)).to(equal(Array(files[0..<(files.count - 1)])))
            }
            
            it("String") {
                expect(initx("1")).to(equal(String()))
                expect(initx("WHO")).to(equal("WH"))
            }
        }
        
        describe("uncons") {
            it("Int Array") {
                expect(uncons([Int]())).to(beNil())
                
                let t0 = uncons([1])
                expect(t0!.0).to(equal(1))
                expect(t0!.1).to(equal([]))
                
                let t1 = uncons([1,2])
                expect(t1!.0).to(equal(1))
                expect(t1!.1).to(equal([2]))
            }
            
            it("String Array") {
                expect(uncons([String]())).to(beNil())
                let t0 = uncons(["World"])
                expect(t0!.0).to(equal("World"))
                expect(t0!.1).to(equal([String]()))
                
            }
            
            it("String") {
                expect(uncons(String())).to(beNil())
                
                let t0 = uncons("a")
                expect(t0!.0).to(equal("a"))
                expect(t0!.1).to(equal(""))
                
                let t1 = uncons("ab")
                expect(t1!.0).to(equal("a"))
                expect(t1!.1).to(equal("b" as String))
            }
        }
        
        describe("null") {
            it("Int Array") {
                expect(null([1])).to(beFalse())
                expect(null([Int]())).to(beTrue())
            }
            
            it("String Array") {
                expect(null(["World"])).to(beFalse())
                expect(null([String]())).to(beTrue())
                expect(null(files)).to(beFalse())
            }
            
            it("String") {
                expect(null("World")).to(beFalse())
                expect(null("")).to(beTrue())
            }
        }
        
        describe("length") {
            it("Int Array") {
                expect(length([1])).to(equal(1))
                expect(length([1,2])).to(equal(2))
            }
            
            it("String Array") {
                expect(length(["World"])).to(equal(1))
                expect(length(files)).to(equal(files.count))
            }
            
            it("String") {
                expect(length("World")).to(equal(5))
                expect(length("")).to(equal(0))
            }
        }
    }
}

class DataList1Spec: QuickSpec {
    override func spec() {
        let files           = ["README.md", "Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]
        
        describe("map") {
            it("String Array") {
                let uppercaseFiles  = ["README.MD", "HASKELL.SWIFT", "HASKELLTESTS.SWIFT", "HASKELLSWIFT.SWIFT"]
                
                let toUppercase     = { (x: String) in x.uppercased() }
                let toUppercases    = { xs in map(toUppercase, xs) }
                let uppercases      = toUppercases(files)
                expect(uppercases).to(equal(uppercaseFiles))
            }
            
            it("Int Array 1") {
                let countLength     = { (x: String) in x.count }
                let countLengths     = { xs in map(countLength, xs) }
                let lengths         = countLengths(files)
                expect(lengths).to(equal(files.map({ (x: String) in x.count })))
            }
            
            it("Int Array 2") {
                let countLength     = { (x: String) in x.count }
                let countLengths     = { xs in map(countLength, xs) }
                let lengths         = countLengths(files)
                expect(lengths).to(equal(files.map({ (x: String) in x.count })))
            }
            
            it("String - String") {
                let toUppercases    = { xs in map(toUpper, xs) }
                let uppercaseString = toUppercases("haskell")
                expect(uppercaseString).to(equal("HASKELL"))
            }
            
            it("String - UInt32 Array") {
                let toUppercase     = { (x: Character) -> UInt32 in
                    let scalars = String(toUpper(x)).unicodeScalars
                    return scalars[scalars.startIndex].value
                }
                let toUppercases    = { (xs : String) -> [UInt32] in map(toUppercase, xs) }
                let uppercaseString = toUppercases("haskell")
                expect(uppercaseString).to(equal([72,65,83,75,69,76,76]))
            }
            
            it("String - Bool Array") {
                let isUppercase     = { (x: Character) -> Bool in return ("A"..."Z").contains(x) }
                let checkUppercases = { (xs: String) -> [Bool] in map(isUppercase, xs) }
                let uppercases      = checkUppercases("Haskell")
                let expectedResults = [true, false, false, false, false, false, false]
                expect(uppercases).to(equal(expectedResults))
            }

            it("Collection") {
                let ds = ["firstname" : "tom", "lastname" : "sawyer", "age" : 10]
                let r0 = map(fst, ds)
                expect(r0) == ["firstname", "lastname", "age"]
            }
        }
        
        describe("reverse") {
            it("Int Array") {
                expect(reverse([3])).to(equal([3]))
                expect(reverse([1,2])).to(equal([2,1]))
            }
            
            it("String Array") {
                let reversedFiles = ["HaskellSwift.swift","HaskellTests.swift","Haskell.swift","README.md"]
                expect(reverse(["Hello"])).to(equal(["Hello"]))
                expect(reverse(files)).to(equal(reversedFiles))
            }
            
            it("String") {
                expect(reverse("World")).to(equal("dlroW"))
                expect(reverse("")).to(equal(""))
            }
        }
        
        describe("intersperse") {
            it("Int Array") {
                expect(intersperse(1, [])).to(equal([]))
                expect(intersperse(1, [3])).to(equal([3]))
                expect(intersperse(10, [1,2,3])).to(equal([1,10,2,10,3]))
            }
            
            it("String Array"){
                let list = ["File", "Edit", "View"]
                expect(intersperse(".", [])).to(equal([]))
                expect(intersperse("+", ["Fine"])).to(equal(["Fine"]))
                expect(intersperse(".", list)).to(equal(["File",".","Edit",".","View"]))
            }
            
            it("String") {
                expect(intersperse("+", "")).to(equal(""))
                expect(intersperse("+", "A")).to(equal("A"))
                expect(intersperse("+", "ABC")).to(equal("A+B+C"))
            }
        }
        
        describe("intercalate") {
            it("String Array"){
                let list = ["File", "Edit", "View"]
                expect(intercalate(".", [])).to(equal(""))
                expect(intercalate("+", ["Fine"])).to(equal("Fine"))
                expect(intercalate(".", list)).to(equal("File.Edit.View"))
            }
        }
        
        describe("transpose") {
            it("Int Array") {
                expect(transpose([[1,2,3],[4,5,6],[7,8,9]])).to(equal([[1,4,7],[2,5,8],[3,6,9]]))
                expect(transpose([[1],[4,5],[7,8,9]])).to(equal([[1,4,7],[5,8],[9]]))
            }
            
            it("String Array"){
                let list = ["ABCD","abcd"]
                expect(transpose(list)).to(equal(["Aa","Bb","Cc","Dd"]))
            }
        }
        
        describe("subsequences") {
            it("Int Array") {
                var emptySequence = [[Int]]()
                emptySequence.append([Int]())
                expect(subsequences([Int]())).to(equal(emptySequence))
                
                expect(subsequences([1,2,3])).to(equal([[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]))
            }
            
            it("String Array"){
                var emptySequence = [[String]]()
                emptySequence.append([String]())
                expect(subsequences([String]())).to(equal(emptySequence))
                
                let list = ["ABCD","abcd"]
                expect(subsequences(list)).to(equal([[],["ABCD"],["abcd"],["ABCD","abcd"]]))
            }
            
            it("String") {
                var emptySequence = [String]()
                emptySequence.append(String())
                expect(subsequences(String())).to(equal(emptySequence))
                
                let list         = "ABCD"
                let expectedList = ["","A","B","AB","C","AC","BC","ABC","D","AD","BD","ABD","CD","ACD","BCD","ABCD"]
                expect(subsequences(list)).to(equal(expectedList))
            }
        }
        
        describe("permutations") {
            it("Int Array") {
                var emptySequence = [[Int]]()
                emptySequence.append([Int]())
                expect(permutations([Int]())).to(equal(emptySequence))
                
                expect(permutations([1,2,3])).to(equal([[1,2,3], [2,1,3], [2,3,1], [1,3,2], [3,1,2], [3,2,1]]))
            }
            
            it("String Array"){
                var emptySequence = [[String]]()
                emptySequence.append([String]())
                expect(permutations([String]())).to(equal(emptySequence))
                
                let list = ["IT", "IS", "BAD"]
                expect(permutations(list)).to(equal([["IT","IS","BAD"], ["IS","IT","BAD"], ["IS","BAD","IT"], ["IT","BAD","IS"], ["BAD","IT","IS"], ["BAD","IS","IT"]]))
            }
            
            it("String") {
                expect(permutations(String())).to(equal([""]))
                expect(permutations("abc")).to(equal(["abc", "bac", "bca", "acb", "cab", "cba"]))
            }
        }
    }
}

class DataList2Spec: QuickSpec {
    override func spec() {
//        describe("foldl") {
//            it("Int Array") {
//                let adds     = { (x: Int,y: Int) in x+y }
//                expect(foldl(adds, 0, [1, 2, 3])).to(equal(6))
//                
//                let product = {(x: Int, y: Int) in x*y}
//                expect(foldl(product, 1, [1,2,3,4,5])).to(equal(120))
//            }
//            
//            it("String Array") {
//                let letters : [String] = ["W", "o", "r", "l", "d"]
//                let adds = { (x: String, y: String) in x + y }
//                let result = foldl(adds, "", letters)
//                expect(result).to(equal("World"))
//            }
//            
//            it("String") {
//                let insert = { (x: String, y: Character) in String(y) + x }
//                expect(foldl(insert, "", "World")).to(equal("dlroW"))
//            }
//        }
        
        describe("foldl1") {
            it("Int Array") {
                let adds     = { (x: Int,y: Int) in x+y }
                expect(foldl1(adds, [1, 2, 3])).to(equal(6))
                
                let product = {(x: Int, y: Int) in x*y}
                expect(foldl1(product, [1,2,3,4,5])).to(equal(120))
            }
            
            it("String Array") {
                let letters : [String] = ["W", "o", "r", "l", "d"]
                let adds = { (x: String, y: String) in x + y }
                let result = foldl1(adds, letters)
                expect(result).to(equal("World"))
            }
            
            it("String") {
                let insert = { (x: String, y: Character) in String(y) + x }
                expect(foldl1(insert, "World")).to(equal("dlroW"))
            }
        }
        
        describe("foldr") {
            it("Int Array") {
                let adds     = { (a: Int,b: Int) in a+b }
                expect(foldr(adds, 0, [1, 2, 3])).to(equal(6))
                
                let multiply = {(a: Int, b: Int) in a*b}
                expect(foldr(multiply, 1, [1,2,3,4,5])).to(equal(120))
            }
            
            it("String Array") {
                let letters : [String] = ["W", "o", "r", "l", "d"]
                let adds = { (a: String, b: String) in b + a }
                let result = foldr(adds, "", letters)
                expect(result).to(equal("dlroW"))
            }
            
            it("String") {
                let insert = { (a: Character, b: String) in String(a) + b }
                expect(foldr(insert, "", "World")).to(equal("World"))
            }
        }
        
        describe("foldr1") {
            it("Int Array") {
                let adds     = { (a: Int,b: Int) in a+b }
                expect(foldr1(adds, [1, 2, 3])).to(equal(6))
                
                let multiply = {(a: Int, b: Int) in a*b}
                expect(foldr1(multiply, [1,2,3,4,5])).to(equal(120))
            }
            
            it("String Array") {
                let letters : [String] = ["W", "o", "r", "l", "d"]
                let adds = { (a: String, b: String) in b + a }
                let result = foldr1(adds, letters)
                expect(result).to(equal("dlroW"))
            }
            
            it("String") {
                let insert = { (a: Character, b: String) in String(a) + b }
                expect(foldr1(insert, "World")).to(equal("World"))
            }
        }
        
//        describe("reduce") {
//            it("Int Array") {
//                let adds             = { (initial: String, x: Int) -> String in initial + String(x) }
//                let result          = reduce(adds, "", [1,2,3,4])
//                expect(result).to(equal("1234"))
//            }
//            
//            it("String Array 1") {
//                let adds             = { (initial: String, x: String) -> String in initial + x }
//                let concat          = { xs in reduce(adds, "", xs) }
//                let result          = concat(["Hello", "World", "!"])
//                expect(result).to(equal("HelloWorld!"))
//            }
//            
//            it("String Array 2") {
//                let adds             = { (initial: String, x: String) -> String in initial + x }
//                let concat          = { (xs : [String]) in reduce(adds, "", xs) }
//                let result          = concat(["C", "a", "t", "!"] )
//                expect(result).to(equal("Cat!"))
//            }
//            
//            it("String") {
//                let adds             = { (initial: String, x: Character) -> String in initial + String(x) }
//                let xs : [Character] = ["C", "a", "t", "!"]
//                let result           = reduce(adds, "", xs)
//                expect(result).to(equal("Cat!"))
//            }
//        }
        
    }
}

class DataList3Spec: QuickSpec {
    override func spec() {
        describe("concat") {
            it("Int Arrays Array") {
                var ints = [[1, 2, 3], [4, 5, 6]]
                expect(concat(ints)).to(equal([1, 2, 3, 4, 5, 6]))
                ints = [[Int]]()
                expect(concat(ints)).to(equal([[Int]]()))
            }
            
            it("String Arrays Array") {
                let strings = [["a", "b", "c"], ["d", "e", "f"]]
                expect(concat(strings)).to(equal(["a", "b", "c", "d", "e", "f"]))
            }
            
            it("String Arrays") {
                let strings = ["Hello", "World"]
                expect(concat(strings)).to(equal("HelloWorld"))
                let emptyString = [String]()
                expect(concat(emptyString)).to(equal(String()))
            }
            
            it("Character Array") {
                let strings = ["H", "e", "l", "l", "o"]
                expect(concat(strings)).to(equal("Hello"))
                let emptyString = [Character]()
                expect(concat(emptyString)).to(equal(String()))
            }
        }
        
        describe("concatMap") {
            it("Int Arrays Array") {
                let ints = [1, 2]
                expect(concatMap({x in [x, x*x]}, ints)).to(equal([1, 1, 2, 4]))
            }
            
            it("String Arrays Array") {
                let strings = ["a", "b"]
                expect(concatMap( {x in [x + "0", x + "1", x + "2"]}, strings)).to(equal(["a0", "a1", "a2", "b0", "b1", "b2"]))
            }
            
            it("String Arrays") {
                let strings = ["Hello", "World"]
                let f       = { (s: String) in  [s.uppercased(), "1"] }
                let r0      = concatMap(f, strings)
                expect(r0).to(equal(["HELLO", "1", "WORLD", "1"]))
                
                let emptyString = [String]()
                expect(concat(emptyString)).to(equal(String()))
            }
            
            it("Character Array") {
                let chars : [Character] = ["H", "e", "l", "l", "o"]
                let f       = { (x: Character) in String(x) + "1" }
                let r0      = concatMap(f, chars)
                expect(r0).to(equal("H1e1l1l1o1"))
                
                let emptyString = [Character]()
                expect(concat(emptyString)).to(equal(String()))
            }
        }
        
        describe("and") {
            it("Bool Array") {
                expect(and([false, false])).to(beFalse())
                expect(and([true, false])).to(beFalse())
                expect(and([true, true])).to(beTrue())
                expect(and([false, true])).to(beFalse())
            }
        }
        
        describe("or") {
            it("Bool Array") {
                expect(or([true,true])).to(beTrue())
                expect(or([false,true])).to(beTrue())
                expect(or([false,false])).to(beFalse())
                expect(or([true, false])).to(beTrue())
            }
        }
        
        describe("any") {
            it("Int Array") {
                let ints = [1,3,7]
                expect(any({ x in x < 10}, ints)).to(beTrue())
                expect(any({ x in x > 10}, ints)).to(beFalse())
            }
            
            it("String Array") {
                let words = ["Hello", "World"]
                expect(any({ x in head(x) == "H"}, words)).to(beTrue())
                expect(any({ x in last(x) == "t"}, words)).to(beFalse())
            }
            
            it("String") {
                let word = "Hello"
                expect(any({ x in x == "H"}, word)).to(beTrue())
                expect(any({ x in x == "t"}, word)).to(beFalse())
            }
        }
        
        describe("all") {
            it("Int Array") {
                let ints = [1,3,7]
                expect(all({ x in x < 10}, ints)).to(beTrue())
                expect(all({ x in x > 10}, ints)).to(beFalse())
                expect(all({ x in x > 10}, [Int]())).to(beTrue())
            }
            
            it("String Array") {
                let words = ["Hello", "World"]
                expect(all({ x in head(x) < "z"}, words)).to(beTrue())
                expect(all({ x in last(x) < "a"}, words)).to(beFalse())
                expect(all({ x in last(x) < "a"}, [String]())).to(beTrue())
            }
            
            it("String") {
                let word = "Hello"
                expect(all({ x in x < "z"}, word)).to(beTrue())
                expect(all({ x in x == "t"}, word)).to(beFalse())
                expect(all({ x in x == "t"}, "")).to(beTrue())
            }
        }
        
        describe("sum") {
            it("CGFloat Array") {
                let list : [CGFloat] = [1.0, 2.0, 3.0]
                let result = sum(list)
                expect(result) == 6.0
                expect(sum([CGFloat]())).to(equal(0.0))
            }
            
            it("Double Array") {
                let list : [Double] = [1.1, 2.2, 3.3]
                let result          = sum(list)
                expect(result).to(beCloseTo(6.6))
                expect(sum([Double]())).to(equal(0.0))
            }
            
            it("Float Array") {
                let list : [Float]  = [1.1, 2.2, 3.3]
                let result          = sum(list)
                expect(result).to(beCloseTo(Float(6.6)))
                expect(sum([Float]())).to(equal(0.0))
            }
            
            it("Int Array") {
                let list : [Int]    = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(Int(6)))
                expect(sum([Int]())).to(equal(0))
            }
            
            it("Int16 Array") {
                let list : [Int16]  = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(Int16(6)))
                expect(sum([Int16]())).to(equal(0))
            }
            
            it("Int32 Array") {
                let list : [Int32]  = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(Int32(6)))
                expect(sum([Int32]())).to(equal(0))
            }
            
            it("Int64 Array") {
                let list : [Int64]  = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(Int64(6)))
                expect(sum([Int64]())).to(equal(0))
            }
            
            it("Int8 Array") {
                let list : [Int8]   = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(Int8(6)))
                expect(sum([Int8]())).to(equal(0))
            }
            
            it("UInt Array") {
                let list : [UInt]   = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(UInt(6)))
                expect(sum([UInt]())).to(equal(0))
            }
            
            it("UInt16 Array") {
                let list : [UInt16] = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(UInt16(6)))
                expect(sum([UInt16]())).to(equal(0))
            }
            
            it("UInt32 Array") {
                let list : [UInt32] = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(UInt32(6)))
                expect(sum([UInt32]())).to(equal(0))
            }
            
            it("UInt64 Array") {
                let list : [UInt64] = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(UInt64(6)))
                expect(sum([UInt64]())).to(equal(0))
            }
            
            it("UInt8 Array") {
                let list : [UInt8]  = [1, 2, 3]
                let result          = sum(list)
                expect(result).to(equal(UInt8(6)))
                expect(sum([UInt8]())).to(equal(0))
            }
        }
        
        describe("product") {
            it("CGFloat Array") {
                let list : [CGFloat] = [1.0, 2.0, 3.0]
                let result = product(list)
                expect(result) == 6.0
                expect(product([CGFloat]())) == 1.0
            }
            
            it("Double Array") {
                let list : [Double] = [1.1, 2.2, 3.3]
                let result          = product(list)
                expect(result).to(beCloseTo(7.986000000000001))
                expect(product([Double]())).to(equal(1.0))
            }
            
            it("Float Array") {
                let list : [Float]  = [1.1, 2.2, 3.3]
                let result          = product(list)
                expect(result).to(beCloseTo(Float(7.986000000000001)))
                expect(product([Float]())).to(equal(1.0))
            }
            
            it("Int Array") {
                let list : [Int]    = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(Int(24)))
                expect(product([Int]())).to(equal(1))
            }
            
            it("Int16 Array") {
                let list : [Int16]  = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(Int16(24)))
                expect(product([Int16]())).to(equal(1))
            }
            
            it("Int32 Array") {
                let list : [Int32]  = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(Int32(24)))
                expect(product([Int32]())).to(equal(1))
            }
            
            it("Int64 Array") {
                let list : [Int64]  = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(Int64(24)))
                expect(product([Int64]())).to(equal(1))
            }
            
            it("Int8 Array") {
                let list : [Int8]   = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(Int8(24)))
                expect(product([Int8]())).to(equal(1))
            }
            
            it("UInt Array") {
                let list : [UInt]   = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(UInt(24)))
                expect(product([UInt]())).to(equal(1))
            }
            
            it("UInt16 Array") {
                let list : [UInt16] = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(UInt16(24)))
                expect(product([UInt16]())).to(equal(1))
            }
            
            it("UInt32 Array") {
                let list : [UInt32] = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(UInt32(24)))
                expect(product([UInt32]())).to(equal(1))
            }
            
            it("UInt64 Array") {
                let list : [UInt64] = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(UInt64(24)))
                expect(product([UInt64]())).to(equal(1))
            }
            
            it("UInt8 Array") {
                let list : [UInt8]  = [1, 2, 3, 4]
                let result          = product(list)
                expect(result).to(equal(UInt8(24)))
                expect(product([UInt8]())).to(equal(1))
            }
        }
        
        describe("maximum") {
            it("CGFloat Array") {
                let list : [CGFloat] = [1.0, 2.0, 3.0]
                let result           = maximum(list)
                expect(result) == 3.0
            }
            
            it("Double Array") {
                let list : [Double] = [1.1, 2.2, 3.3]
                let result          = maximum(list)
                expect(result) == 3.3
            }
            
            it("Float Array") {
                let list : [Float]  = [1.1, 2.2, 3.3]
                let result          = maximum(list)
                expect(result).to(beCloseTo(3.3))
            }
            
            it("Int Array") {
                let list : [Int]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("Int16 Array") {
                let list : [Int16]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("Int32 Array") {
                let list : [Int32]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("Int64 Array") {
                let list : [Int64]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("Int8 Array") {
                let list : [Int8]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("UInt Array") {
                let list : [UInt]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("UInt16 Array") {
                let list : [UInt16]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("UInt32 Array") {
                let list : [UInt32]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("UInt64 Array") {
                let list : [UInt64]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
            
            it("UInt8 Array") {
                let list : [UInt8]    = [1, 2, 3]
                let result          = maximum(list)
                expect(result).to(equal(3))
            }
        }
        
        describe("minimum") {
            it("CGFloat Array") {
                let list : [CGFloat] = [4.4, 2.2, 3.3]
                let result           = minimum(list)
                expect(result) == 2.2
            }
            
            it("Double Array") {
                let list : [Double] = [4.4, 2.2, 3.3]
                let result          = minimum(list)
                expect(result).to(beCloseTo(2.2))
            }
            
            it("Float Array") {
                let list : [Float]  = [4.4, 2.2, 3.3]
                let result          = minimum(list)
                expect(result).to(beCloseTo(2.2))
            }
            
            it("Int Array") {
                let list : [Int]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("Int16 Array") {
                let list : [Int16]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("Int32 Array") {
                let list : [Int32]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("Int64 Array") {
                let list : [Int64]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("Int8 Array") {
                let list : [Int8]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("UInt Array") {
                let list : [UInt]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("UInt16 Array") {
                let list : [UInt16]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("UInt32 Array") {
                let list : [UInt32]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("UInt64 Array") {
                let list : [UInt64]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
            
            it("UInt8 Array") {
                let list : [UInt8]    = [5, 2, 3]
                let result          = minimum(list)
                expect(result).to(equal(2))
            }
        }
        
        describe("scanl") {
            it("Int Array") {
                let adds     = { (x: Int,y: Int) in x+y }
                expect(scanl(adds, 0, [1, 2, 3])).to(equal([1, 3, 6]))
                
                let product = {(x: Int, y: Int) in x*y}
                expect(scanl(product, 1, [1,2,3,4,5])).to(equal([1, 2, 6, 24, 120]))
            }
            
            it("String Array") {
                let letters : [String] = ["W", "o", "r", "l", "d"]
                let adds    = { (x: String, y: String) in x + y }
                let result  = scanl(adds, "", letters)
                expect(result).to(equal(["W", "Wo", "Wor", "Worl", "World"]))
            }
            
            it("String") {
                let insert = { (x: String, y: Character) in String(y) + x }
                expect(scanl(insert, "", "World")).to(equal(["W", "oW", "roW", "lroW", "dlroW"]))
            }
        }
        
        describe("scanl1") {
            it("Int Array") {
                let adds     = { (x: Int,y: Int) -> Int in x+y }
                expect(scanl1(adds, [1, 2, 3])).to(equal([1, 3, 6]))
                
                let product = {(x: Int, y: Int) -> Int in x*y}
                expect(scanl1(product, [1,2,3,4,5])).to(equal([1, 2, 6, 24, 120]))
            }
            
            it("String Array") {
                let letters : [String] = ["W", "o", "r", "l", "d"]
                let adds    = { (x: String, y: String) in x + y }
                let result  = scanl1(adds, letters)
                expect(result).to(equal(["W", "Wo", "Wor", "Worl", "World"]))
            }
            
            it("String") {
                let insert = { (x: String, y: Character) in String(y) + x }
                expect(scanl1(insert, "World")).to(equal(["W", "oW", "roW", "lroW", "dlroW"]))
            }
        }
        
        describe("scanr") {
            it("Int Array") {
                let adds     = { (x: Int,y: Int) in x+y }
                expect(scanr(adds, 0, [1, 2, 3])).to(equal([3, 5, 6]))
                
                let product = {(x: Int, y: Int) in x*y}
                expect(scanr(product, 1, [1,2,3,4,5])).to(equal([5, 20, 60, 120, 120]))
            }
            
            it("String Array") {
                let letters : [String] = ["W", "o", "r", "l", "d"]
                let adds    = { (x: String, y: String) in x + y }
                let result  = scanr(adds, "", letters)
                expect(result).to(equal(["d", "ld", "rld", "orld", "World"]))
            }
            
            it("String") {
                let insert = { (x: Character, y: String) in String(x) + y }
                expect(scanr(insert, "", "World")).to(equal(["d", "ld", "rld", "orld", "World"]))
            }
        }
        
        describe("scanr1") {
            it("Int Array") {
                let adds     = { (x: Int,y: Int) in x+y }
                expect(scanr1(adds, [1, 2, 3])).to(equal([3, 5, 6]))
                
                let product = {(x: Int, y: Int) in x*y}
                expect(scanr1(product, [1,2,3,4,5])).to(equal([5, 20, 60, 120, 120]))
            }
            
            it("String Array") {
                let letters : [String] = ["W", "o", "r", "l", "d"]
                let adds    = { (x: String, y: String) in x + y }
                let result  = scanr1(adds, letters)
                expect(result).to(equal(["d", "ld", "rld", "orld", "World"]))
            }
            
            it("String") {
                //Very tricky
                //let insert = { (x: Character, y: String) in String(x) + y } //Wrong
                let insert = { (x: Character, y: String) -> String in String(x) + y } //Correct
                expect(scanr1(insert, "World")).to(equal(["d", "ld", "rld", "orld", "World"]))
            }
        }
        
    }
}

class DataList4Spec: QuickSpec {
    override func spec() {
        describe("replicate") {
            it("Int Array") {
                let ints = replicate(100, 123)
                expect(filter( { x in x == 123 }, ints).count).to(equal(100))
            }
            
            it("String Array") {
                let strings = replicate(100, "Good")
                expect(filter( { x in x == "Good" }, strings).count).to(equal(100))
            }
        }
        
        describe("unfoldr") {
            it("Int Array") {
                let ints = unfoldr({ (b: Int) -> (Int, Int)? in
                    if b < 1 {
                        return nil
                    } else {
                        return (b, b - 1)
                    }
                    }, 10)
                expect(ints).to(equal([10,9,8,7,6,5,4,3,2,1]))
            }
            
            it("String Array") {
                let strings = unfoldr({(b: String) -> (String, String)? in
                    if length(b) == 0 {
                        return nil
                    } else {
                        return (b, tail(b))
                    }
                    }, "Good")
                expect(strings).to(equal(["Good", "ood", "od", "d"]))
            }
            
            it("String") {
                var i = 0
                let string = unfoldr({(b: Character) -> (String, Character)? in
                    i += 1
                    if i > 4 {
                        return nil
                    } else {
                        return (String(b), b)
                    }
                    }, "A")
                expect(string).to(equal(["A", "A", "A", "A"]))
            }
        }
    }
}

class DataList5Spec: QuickSpec {
    override func spec() {
        let files           = ["README.md", "Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]
        
        describe("take") {
            it("Int Array") {
                let ints = [1, 2, 3]
                expect(take(0, ints)).to(equal([Int]()))
                expect(take(0, [Int]())).to(equal([Int]()))
                expect(take(1, ints)).to(equal([1]))
                expect(take(5, ints)).to(equal(ints))
            }
            
            it("String Array") {
                expect(take(0, files)).to(equal([String]()))
                expect(take(0, [String]())).to(equal([String]()))
                expect(take(1, files)).to(equal([files[0]]))
                expect(take(10, files)).to(equal(files))
            }
            
            it("String") {
                let str = "World"
                expect(take(0, files)).to(equal([String]()))
                expect(take(0, [String]())).to(equal([String]()))
                expect(take(1, str)).to(equal("W"))
                expect(take(3, str)).to(equal("Wor"))
                expect(take(10, str)).to(equal(str))
            }
        }
        
        describe("drop") {
            it("Int Array") {
                let ints = [1, 2, 3]
                expect(drop(0, ints)).to(equal(ints))
                expect(drop(0, [Int]())).to(equal([Int]()))
                expect(drop(1, ints)).to(equal([2, 3]))
                expect(drop(10, ints)).to(equal([Int]()))
            }
            
            it("String Array") {
                expect(drop(0, files)).to(equal(files))
                expect(drop(0, [String]())).to(equal([String]()))
                let expectedResult = Array(files[1..<(files.count)])
                expect(drop(1, files)).to(equal(expectedResult))
                expect(drop(files.count + 1, files)).to(equal([String]()))
            }
            
            it("String") {
                expect(drop(0, "Hello World")).to(equal("Hello World"))
                expect(drop(0, [String]())).to(equal([String]()))
                expect(drop(1, "World")).to(equal("orld"))
                expect(drop(10, "World")).to(equal(""))
            }
        }
        
        describe("splitAt") {
            it("Int Array") {
                let ints = [1, 2, 3]
                let (list1, list2) = splitAt(2, ints)
                expect(list1).to(equal([1, 2]))
                expect(list2).to(equal([3]))
            }
            
            it("String Array") {
                let list = ["Is", "it", "OK"]
                let (list1, list2) = splitAt(2, list)
                expect(list1).to(equal(["Is", "it"]))
                expect(list2).to(equal(["OK"]))
            }
            
            it("String") {
                let list = "Hello World"
                let (list1, list2) = splitAt(5, list)
                expect(list1).to(equal("Hello"))
                expect(list2).to(equal(" World"))
            }
        }
        
        describe("takeWhile") {
            it("Int Array") {
                let ints = [1, 2, 3]
                let result = takeWhile( { $0 > 2} , ints)
                expect(result).to(equal([Int]()))
            }
            
            it("String Array") {
                let list = ["Is", "it", "OK"]
                let result = takeWhile({ x in head(x) == "I"}, list)
                expect(result).to(equal(["Is"]))
            }
            
            it("String") {
                let list = "Hello World"
                let result = takeWhile({ x in x < "Z"}, list)
                expect(result).to(equal("H"))
            }
        }
        
        describe("dropWhile") {
            it("Int Array") {
                let ints = [1, 2, 3]
                let result = dropWhile( { $0 < 3} , ints)
                expect(result).to(equal([3]))
            }
            
            it("String Array") {
                let list = ["Is", "it", "OK"]
                let result = dropWhile({ x in head(x) == "I" || head(x) == "i" }, list)
                expect(result).to(equal(["OK"]))
            }
            
            it("String") {
                let list = "Hello World"
                let result = dropWhile({ x in x < "Z"}, list)
                expect(result).to(equal("ello World"))
            }
        }
        
        describe("span") {
            it("Int Array") {
                let ints            = [1, 2, 3]
                let (list1, list2)  = span( { $0 < 2} , ints)
                expect(list1).to(equal([1]))
                expect(list2).to(equal([2, 3]))
            }
            
            it("String Array") {
                let list    = ["Is", "it", "OK"]
                let (list1, list2)  = span({ x in head(x) == "I" || head(x) == "i" }, list)
                expect(list1).to(equal(["Is", "it"]))
                expect(list2).to(equal(["OK"]))
            }
            
            it("String") {
                let list = "Hello World"
                let (list1, list2) = span({ x in x < "Z"}, list)
                expect(list1).to(equal("H"))
                expect(list2).to(equal("ello World"))
            }
        }
        
        describe("breakx") {
            it("Int Array") {
                let ints            = [1, 2, 3]
                let (list1, list2)  = breakx( { $0 > 2} , ints)
                expect(list1).to(equal([1, 2]))
                expect(list2).to(equal([3]))
            }
            
            it("String Array") {
                let list    = ["Is", "it", "OK"]
                let (list1, list2)  = breakx({ x in head(x) == "i" }, list)
                expect(list1).to(equal(["Is"]))
                expect(list2).to(equal(["it", "OK"]))
            }
            
            it("String") {
                let list = "Hello World"
                let (list1, list2) = breakx({ x in x == " " }, list)
                expect(list1).to(equal("Hello"))
                expect(list2).to(equal(" World"))
            }
        }
        
        describe("stripPrefix") {
            it("Int Array") {
                let list1           = [1, 1]
                let list2           = [1, 1, 2, 3, 3, 5, 5]
                expect(stripPrefix([9,1], list2)).to(beNil())
                expect(stripPrefix(list1, list2)).to(equal([2, 3, 3, 5, 5]))
            }
            
            it("String Array") {
                let list1           = ["foo"]
                let list2           = ["foo", "bar"]
                expect(stripPrefix(["bar"], list2)).to(beNil())
                expect(stripPrefix(list1, list2)).to(equal(["bar"]))
            }
            
            it("String") {
                let list1           = "foo"
                let list2           = "foobar"
                expect(stripPrefix("bar", list2)).to(beNil())
                expect(stripPrefix(list1, list2)).to(equal("bar"))
            }
        }
        
        describe("group") {
            it("Int Array") {
                let ints            = [1, 1, 2, 3, 3, 5, 5]
                let result          = group(ints)
                expect(result).to(equal([[1,1],[2],[3,3],[5,5]]))
            }
            
            it("String Array") {
                let list    = ["Apple", "Pie", "Pie"]
                let result  = group(list)
                expect(result).to(equal([["Apple"], ["Pie", "Pie"]]))
            }
            
            it("String") {
                let list = "Hello World"
                let result = group(list)
                expect(result).to(equal(["H","e","ll","o"," ","W","o","r","l","d"]))
            }
        }
        
        describe("inits") {
            it("Int Array") {
                let ints            = [1, 1, 2, 3, 3, 5, 5]
                let result          = inits(ints)
                let expectedResult  = [[],[1],[1,1],[1,1,2],[1,1,2,3],[1,1,2,3,3],[1,1,2,3,3,5],[1,1,2,3,3,5,5]]
                expect(result).to(equal(expectedResult))
            }
            
            it("String Array") {
                let list    = ["Apple", "Pie", "Pie"]
                let result  = inits(list)
                let expectedResult = [[],["Apple"],["Apple","Pie"],["Apple","Pie","Pie"]]
                expect(result).to(equal(expectedResult))
            }
            
            it("String") {
                let list = "Hello World"
                let result = inits(list)
                let expectedResult = ["","H","He","Hel","Hell","Hello","Hello ","Hello W","Hello Wo","Hello Wor","Hello Worl","Hello World"]
                expect(result).to(equal(expectedResult))
            }
        }
        
        describe("tails") {
            it("Int Array") {
                let ints            = [1, 1, 2, 3, 3, 5, 5]
                let result          = tails(ints)
                let expectedResult  = [[1,1,2,3,3,5,5],[1,2,3,3,5,5],[2,3,3,5,5],[3,3,5,5],[3,5,5],[5,5],[5],[]]
                expect(result).to(equal(expectedResult))
            }
            
            it("String Array") {
                let list    = ["Apple", "Pie", "Pie"]
                let result  = tails(list)
                expect(result).to(equal([["Apple","Pie","Pie"],["Pie","Pie"],["Pie"],[]]))
            }
            
            it("String") {
                let list = "Hello World"
                let result = tails(list)
                expect(result).to(equal(["Hello World","ello World","llo World","lo World","o World"," World","World","orld","rld","ld","d",""]))
            }
        }
    }
}

class DataList6Spec: QuickSpec {
    override func spec() {
        let files           = ["README.md", "Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]
        
        describe("isPrefixOf") {
            it("Int Array") {
                let list1            = [1, 1, 2]
                let list2            = [1, 1, 2, 3, 3, 5, 5]
                let list3            = [1, 5]
                expect(isPrefixOf(list1, list2)).to(beTrue())
                expect(isPrefixOf(list1, list3)).to(beFalse())
            }
            
            it("String Array") {
                let list1            = ["Hello"]
                let list2            = ["Hello", "World"]
                let list3            = ["World", "Hello"]
                expect(isPrefixOf(list1, list2)).to(beTrue())
                expect(isPrefixOf(list1, list3)).to(beFalse())
            }
            
            it("String") {
                let list1            = "Hello"
                let list2            = "Hello World"
                let list3            = "World"
                expect(isPrefixOf(list1, list2)).to(beTrue())
                expect(isPrefixOf(list1, list3)).to(beFalse())
            }
        }
        
        describe("isSuffixOf") {
            it("Int Array") {
                let list1            = [3, 5, 5]
                let list2            = [1, 1, 2, 3, 3, 5, 5]
                let list3            = [1, 5]
                expect(isSuffixOf(list1, list2)).to(beTrue())
                expect(isSuffixOf(list1, list3)).to(beFalse())
            }
            
            it("String Array") {
                let list1            = ["Hello"]
                let list2            = ["World", "Hello"]
                let list3            = ["Hello", "World"]
                expect(isSuffixOf(list1, list2)).to(beTrue())
                expect(isSuffixOf(list1, list3)).to(beFalse())
            }
            
            it("String") {
                let list1            = "World"
                let list2            = "Hello World"
                let list3            = "Hello"
                expect(isSuffixOf(list1, list2)).to(beTrue())
                expect(isSuffixOf(list1, list3)).to(beFalse())
            }
        }
        
        describe("isInfixOf") {
            it("Int Array") {
                let list1            = [2, 3, 3]
                let list2            = [1, 1, 2, 3, 3, 5, 5]
                let list3            = [1, 5]
                expect(isInfixOf(list1, list2)).to(beTrue())
                expect(isInfixOf(list1, list3)).to(beFalse())
            }
            
            it("String Array") {
                let list1            = ["Hello"]
                let list2            = ["World", "Hello"]
                let list3            = ["Hello", "World"]
                let list4            = ["Hello!", "World"]
                expect(isInfixOf(list1, list2)).to(beTrue())
                expect(isInfixOf(list1, list3)).to(beTrue())
                expect(isInfixOf(list1, list4)).to(beFalse())
            }
            
            it("String") {
                let list1            = "World"
                let list2            = "Hello World!"
                let list3            = "Hello"
                expect(isInfixOf(list1, list2)).to(beTrue())
                expect(isInfixOf(list1, list3)).to(beFalse())
            }
        }
        
        describe("isSubsequenceOf") {
            it("Int Array") {
                let list1            = [2, 3, 3]
                let list2            = [1, 1, 2, 3, 3, 5, 5]
                let list3            = [1, 5]
                expect(isSubsequenceOf(list1, list2)).to(beTrue())
                expect(isSubsequenceOf(list1, list3)).to(beFalse())
                expect(isSubsequenceOf(list1, list1)).to(beTrue())
            }
            
            it("String Array") {
                let list1            = ["Hello"]
                let list2            = ["World", "Hello"]
                let list3            = ["Hello", "World"]
                let list4            = ["Hello!", "World"]
                expect(isSubsequenceOf(list1, list2)).to(beTrue())
                expect(isSubsequenceOf(list1, list3)).to(beTrue())
                expect(isSubsequenceOf(list1, list4)).to(beFalse())
                expect(isSubsequenceOf(list1, list1)).to(beTrue())
            }
            
            it("String") {
                let list1            = "World"
                let list2            = "Hello World!"
                let list3            = "Hello"
                expect(isSubsequenceOf(list1, list2)).to(beTrue())
                expect(isSubsequenceOf(list1, list3)).to(beFalse())
                expect(isSubsequenceOf(list1, list1)).to(beTrue())
            }
        }
        
        describe("elem") {
            it("Int Array") {
                let list            = [2, 3, 3]
                expect(elem(3, list)).to(beTrue())
                expect(elem(5, list)).to(beFalse())
            }
            
            it("String Array") {
                let list            = ["World", "Hello"]
                expect(elem("Hello", list)).to(beTrue())
                expect(elem("Good", list)).to(beFalse())
            }
            
            it("String") {
                let list            = "Hello"
                expect(elem("H", list)).to(beTrue())
                expect(elem("T", list)).to(beFalse())
            }
        }
        
        describe("notElem") {
            it("Int Array") {
                let list            = [2, 3, 3]
                expect(notElem(3, list)).to(beFalse())
                expect(notElem(5, list)).to(beTrue())
            }
            
            it("String Array") {
                let list            = ["World", "Hello"]
                expect(notElem("Hello", list)).to(beFalse())
                expect(notElem("Good", list)).to(beTrue())
            }
            
            it("String") {
                let list            = "Hello"
                expect(notElem("H", list)).to(beFalse())
                expect(notElem("T", list)).to(beTrue())
            }
        }
        
        describe("lookup") {
            it("Int Array") {
                let list            = ["a": 0, "b": 1]
                expect(lookup("a", list)).to(equal(0))
                expect(lookup("c", list)).to(beNil())
            }
            
            it("String Array") {
                let list            = ["firstname": "tom", "lastname": "sawyer"]
                expect(lookup("firstname", list)).to(equal("tom"))
                expect(lookup("middlename", list)).to(beNil())
            }
        }
        
        describe("find") {
            it("Int Array") {
                let list             = [1, 2, 3, 4, 5]
                let greaterThanThree = { x in x > 3 }
                let result           = find(greaterThanThree, list)
                expect(result).to(equal(4))
            }
            
            it("String Array") {
                let isSwift         = { (x : String) in x.lowercased().hasSuffix("swift") }
                let swiftFilter     = { xs in find(isSwift, xs) }
                let swiftFile       = swiftFilter(files)
                expect(swiftFile).to(equal("Haskell.swift"))
            }
            
            it("String") {
                let isA             = { (x : Character) in x == "a" }
                let isAFilter       = { (xs : String) in filter(isA, xs) }
                let result          = isAFilter("ABCDa")
                expect(result).to(equal("a"))
            }
        }
        
        describe("filter") {
            it("Int Array") {
                let list             = [1, 2, 3, 4, 5]
                let greaterThanThree = { x in x > 3 }
                let result           = filter(greaterThanThree, list)
                expect(result).to(equal([4, 5]))
            }
            
            it("String Array") {
                let isSwift         = { (x : String) in x.lowercased().hasSuffix("swift") }
                let swiftFilter     = { xs in filter(isSwift, xs) }
                let swiftFiles      = swiftFilter(files)
                expect(swiftFiles).to(equal(["Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]))
            }
            
            it("String") {
                let isA             = { (x : Character) in x == "a" }
                let isAFilter       = { (xs : String) in filter(isA, xs) }
                let result          = isAFilter("ABCDa")
                expect(result).to(equal("a"))
            }
        }
        
        describe("partition") {
            it("Int Array") {
                let list             = [1, 2, 3, 4, 5]
                let greaterThanThree = { x in x > 3 }
                let (r0, r1)         = partition(greaterThanThree, list)
                expect(r0).to(equal([4, 5]))
                expect(r1).to(equal([1, 2, 3]))
            }
            
            it("String Array") {
                let isSwift             = { (x : String) in x.lowercased().hasSuffix("swift") }
                let (r0, r1)            = partition(isSwift, files)
                expect(r0).to(equal(["Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]))
                expect(r1).to(equal(["README.md"]))
            }
            
            it("String") {
                let isA                 = { (x : Character) in x == "a" }
                let (r0, r1)            = partition(isA, "ABCDa")
                expect(r0).to(equal("a"))
                expect(r1).to(equal("ABCD"))
            }
        }

        //!!
//        describe("subscript") {
//            it("Int Array") {
//                let list: [Int] = [1, 2, 3, 4, 5]
//                let r = (list !! 0)
//                expect(r).to(equal(1))
//            }
//
//            it("String Array") {
//                let list = ["Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]
//                let r = (list !! 0)
//                expect(r) == "Haskell.swift"
//            }
//
//            it("String") {
//                let list = "Hello"
//                let r = list !! 0
//                expect(r) == "H"
//            }
//        }

        describe("elemIndex") {
            it("Int Array") {
                let list             = [1, 2, 3, 4, 5]
                expect(elemIndex(1, list)).to(equal(0))
                expect(elemIndex(2, list)).to(equal(1))
                expect(elemIndex(10, list)).to(beNil())
            }
            
            it("String Array") {
                let words  = ["Window", "Help", "Window"]
                expect(elemIndex("Window", words)).to(equal(0))
                expect(elemIndex("Help", words)).to(equal(1))
                expect(elemIndex("Debug", words)).to(beNil())
            }
            
            it("String") {
                let word = "Window"
                expect(elemIndex("W", word)).to(equal(0))
                expect(elemIndex("i", word)).to(equal(1))
                expect(elemIndex("T", word)).to(beNil())
            }
        }
        
        describe("elemIndices") {
            it("Int Array") {
                let list             = [1, 2, 3, 4, 3]
                expect(elemIndices(1, list)).to(equal([0]))
                expect(elemIndices(3, list)).to(equal([2,4]))
                expect(elemIndices(10, list)).to(equal([Int]()))
            }
            
            it("String Array") {
                let words  = ["Window", "Help", "Window"]
                expect(elemIndices("Help", words)).to(equal([1]))
                expect(elemIndices("Window", words)).to(equal([0, 2]))
                expect(elemIndices("D", words)).to(equal([Int]()))
            }
            
            it("String") {
                let word = "WINDOW"
                expect(elemIndices("W", word)).to(equal([0, 5]))
                expect(elemIndices("I", word)).to(equal([1]))
                expect(elemIndices("T", word)).to(equal([Int]()))            }
        }
        
        describe("findIndex") {
            it("Int Array") {
                let list             = [1, 2, 3, 4, 5]
                let greaterThanThree = { x in x > 3 }
                let result           = findIndex(greaterThanThree, list)
                expect(result).to(equal(3))
            }
            
            it("String Array") {
                let isSwift         = { (x : String) in x.lowercased().hasSuffix("swift") }
                let swiftFile       = findIndex(isSwift, files)
                expect(swiftFile).to(equal(1))
            }
            
            it("String") {
                let isA             = { (x : Character) in x == "a" }
                let result          =  findIndex(isA, "ABCDa")
                expect(result).to(equal(4))
            }
        }
        
        describe("findIndices") {
            it("Int Array") {
                let list             = [1, 2, 3, 4, 5]
                let greaterThanThree = { x in x > 3 }
                let result           = findIndices(greaterThanThree, list)
                expect(result).to(equal([3, 4]))
            }
            
            it("String Array") {
                let isSwift         = { (x : String) in x.lowercased().hasSuffix("swift") }
                let swiftFile       = findIndices(isSwift, files)
                expect(swiftFile).to(equal([1, 2, 3]))
            }
            
            it("String") {
                let isA             = { (x : Character) in x == "a" }
                let result          =  findIndices(isA, "ABCDa")
                expect(result).to(equal([4]))
            }
        }
        
    }
}

class DataList7Spec: QuickSpec {
    override func spec() {
        let files           = ["README.md", "Haskell.swift", "HaskellTests.swift", "HaskellSwift.swift"]
        
        describe("zip") {
            it("Int Array") {
                let tuples          = zip([1, 2, 3], [1, 4, 9])
                let expectedTuples  = [(1, 1), (2, 4), (3, 9)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array") {
                let tuples          = zip(["1", "2", "3"], [".swift", ".o", ".cpp"])
                let expectedTuples  = [("1", ".swift"), ("2", ".o"), ("3",".cpp")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array - Int") {
                let tuples          = zip([1, 2, 3], [".swift", ".o", ".cpp"])
                let expectedTuples  = [(1, ".swift"), (2, ".o"), (3, ".cpp")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
        }
        
        describe("zip3") {
            it("Int Array") {
                let tuples          = zip3([1, 2, 3], [1, 4, 9], [1, 8, 27])
                let expectedTuples  = [(1, 1, 1), (2, 4, 8), (3, 9, 27)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array") {
                let tuples          = zip3(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"])
                let expectedTuples  = [("1", ".", "swift"), ("2", ".", "o"), ("3", ".", "cpp")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array - Int") {
                let tuples          = zip3([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"])
                let expectedTuples  = [(1, ".", "swift"), (2, ".", "o"), (3, ".", "cpp")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
        }
        
        describe("zip4") {
            it("Int Array") {
                let tuples          = zip4([1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3])
                let expectedTuples  = [(1,1,1,1),(2,4,8,2),(3,9,27,3)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array") {
                let tuples          = zip4(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
                let expectedTuples  = [("1",".","swift","1"),("2",".","o","2"),("3",".","cpp","3")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array - Int") {
                let tuples          = zip4([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], [1, 2, 3])
                let expectedTuples  = [(1,".","swift",1),(2,".","o",2),(3,".","cpp",3)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
        }
        
        describe("zip5") {
            it("Int Array") {
                let tuples          = zip5([1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9])
                let expectedTuples  = [(1,1,1,1,1),(2,4,8,2,4),(3,9,27,3,9)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array") {
                let tuples          = zip5(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ])
                let expectedTuples  = [("1",".","swift","1","."),("2",".","o","2","."),("3",".","cpp","3",".")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array - Int") {
                let tuples          = zip5([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], [1, 2, 3], [1, 4, 9])
                let expectedTuples  = [(1,".","swift",1,1),(2,".","o",2,4),(3,".","cpp",3,9)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
        }
        
        describe("zip6") {
            it("Int Array") {
                let tuples          = zip6([1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9], [1, 8, 27])
                let expectedTuples  = [(1,1,1,1,1,1),(2,4,8,2,4,8),(3,9,27,3,9,27)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array") {
                let tuples          = zip6(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"])
                let expectedTuples  = [("1",".","swift","1",".","swift"),("2",".","o","2",".","o"),("3",".","cpp","3",".","cpp")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array - Int") {
                let tuples          = zip6([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], [1, 2, 3], [1, 4, 9], [1, 8, 27])
                let expectedTuples  = [(1,".","swift",1,1,1),(2,".","o",2,4,8),(3,".","cpp",3,9,27)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
        }
        
        describe("zip7") {
            it("Int Array") {
                let tuples          = zip7([1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3])
                let expectedTuples  = [(1,1,1,1,1,1,1),(2,4,8,2,4,8,2),(3,9,27,3,9,27,3)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array") {
                let tuples          = zip7(["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
                let expectedTuples  = [("1",".","swift","1",".","swift","1"),("2",".","o","2",".","o","2"),("3",".","cpp","3",".","cpp","3")]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
            
            it("String Array - Int") {
                let tuples          = zip7([1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3])
                let expectedTuples  = [(1,".","swift",1,1,1,1),(2,".","o",2,4,8,2),(3,".","cpp",3,9,27,3)]
                let result          = compareTupleArray(tuples, expectedTuples)
                expect(result).to(beTrue())
            }
        }
        
        describe("zipWith") {
            it("Int Array") {
                let result          = zipWith((+), [1, 2, 3], [1, 4, 9])
                expect(result).to(equal([2,6,12]))
            }
            
            it("String Array") {
                let result          = zipWith( (+), ["1", "2", "3"], [".swift", ".o", ".cpp"])
                expect(result).to(equal(["1.swift","2.o","3.cpp"]))
            }
            
            it("String Array - Int") {
                let result          = zipWith( { x, y in String(x) + y }, [1, 2, 3], [".swift", ".o", ".cpp"])
                expect(result).to(equal(["1.swift","2.o","3.cpp"]))
            }
        }
        
        describe("zipWith3") {
            it("Int Array") {
                let result          = zipWith3({(x, y, z) in x+y+z}, [1, 2, 3], [1, 4, 9], [1, 8, 27])
                expect(result).to(equal([3,14,39]))
            }
            
            it("String Array") {
                let result          = zipWith3({x, y, z in x+y+z }, ["1", "2", "3"], [".swift", ".o", ".cpp"],[".1", ".2", ".3"])
                expect(result).to(equal(["1.swift.1","2.o.2","3.cpp.3"]))
            }
            
            it("String Array - Int") {
                let result          = zipWith3( { x, y, z in String(x)+y+z }, [1, 2, 3], [".swift", ".o", ".cpp"], [".1", ".2", ".3"])
                expect(result).to(equal(["1.swift.1","2.o.2","3.cpp.3"]))
            }
        }
        
        describe("zipWith4") {
            it("Int Array") {
                let process         = {(a: Int, b: Int, c: Int, d: Int) -> Int in a+b+c+d}
                let result          = zipWith4(process, [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3])
                expect(result).to(equal([4,16,42]))
            }
            
            it("String Array") {
                let process         = {a,b,c,d-> String in a+b+c+d}
                let result          = zipWith4(process, ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
                expect(result).to(equal(["1.swift1","2.o2","3.cpp3"]))
            }
            
            it("String Array - Int") {
                let process         = {(a: Int,b: String,c: String,d: String) -> String in String(a)+b+c+d}
                let result          = zipWith4(process, [1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
                expect(result).to(equal(["1.swift1","2.o2","3.cpp3"]))
            }
        }
        
        describe("zipWith5") {
            it("Int Array") {
                let process         = {(a: Int, b: Int, c: Int, d: Int, e: Int) -> Int in a+b+c+d+e}
                let result          = zipWith5(process, [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9])
                expect(result).to(equal([5,20,51]))
            }
            
            it("String Array") {
                let process         = {a,b,c,d,e-> String in a+b+c+d+e}
                let result          = zipWith5(process, ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ])
                expect(result).to(equal(["1.swift1.","2.o2.","3.cpp3."]))
            }
            
            it("String Array - Int") {
                let process         = {(a: Int,b: String,c: String,d: String,e: String) -> String in String(a)+b+c+d+e}
                let result          = zipWith5(process, [1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ])
                expect(result).to(equal(["1.swift1.","2.o2.","3.cpp3."]))
            }
        }
        
        describe("zipWith6") {
            it("Int Array") {
                let process         = {(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int) -> Int in a+b+c+d+e+f}
                let result          = zipWith6(process, [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9], [1, 8, 27])
                expect(result).to(equal([6,28,78]))
            }
            
            it("String Array") {
                let process         = {a,b,c,d,e,f-> String in a+b+c+d+e+f}
                let result          = zipWith6(process, ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"])
                expect(result).to(equal(["1.swift1.swift","2.o2.o","3.cpp3.cpp"]))
            }
            
            it("String Array - Int") {
                let process         = {(a: Int,b: String,c: String,d: String,e: String,f: String) -> String in String(a)+b+c+d+e+f}
                let result          = zipWith6(process, [1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"])
                expect(result).to(equal(["1.swift1.swift","2.o2.o","3.cpp3.cpp"]))
            }
        }
        
        describe("zipWith7") {
            it("Int Array") {
                let process         = {(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int, g: Int) -> Int in a+b+c+d+e+f+g}
                let result          = zipWith7(process, [1, 2, 3], [1, 4, 9], [1, 8, 27], [1, 2, 3], [1, 4, 9], [1, 8, 27], [2, 4, 6])
                expect(result).to(equal([8,32,84]))
            }
            
            it("String Array") {
                let process         = {a,b,c,d,e,f,g -> String in a+b+c+d+e+f+g}
                let result          = zipWith7(process, ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
                expect(result).to(equal(["1.swift1.swift1","2.o2.o2","3.cpp3.cpp3"]))
            }
            
            it("String Array - Int") {
                let process         = {(a: Int,b: String,c: String,d: String,e: String,f: String,g: String) -> String in String(a)+b+c+d+e+f+g}
                let result          = zipWith7(process, [1, 2, 3], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"], [".", ".", ".", "." ], ["swift", "o", "cpp"], ["1", "2", "3"])
                expect(result).to(equal(["1.swift1.swift1","2.o2.o2","3.cpp3.cpp3"]))
            }
        }
        
        describe("unzip") {
            it("Int Array") {
                let (r0, r1)        = unzip([(1, 1), (2, 4), (3, 9)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([1, 4, 9]))
            }
            
            it("String Array") {
                let (r0, r1)        = unzip([("1", ".swift"), ("2", ".o"), ("3",".cpp")])
                expect(r0).to(equal(["1", "2", "3"]))
                expect(r1).to(equal([".swift", ".o", ".cpp"]))
            }
            
            it("String Array - Int") {
                let (r0, r1)        = unzip([(1, ".swift"), (2, ".o"), (3, ".cpp")])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([".swift", ".o", ".cpp"]))
            }
        }
        
        describe("unzip3") {
            it("Int Array") {
                let (r0, r1, r2)        = unzip3([(1,1,1),(2,4,8),(3,9,27)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([1, 4, 9]))
                expect(r2).to(equal([1, 8, 27]))
            }
            
            it("String Array") {
                let (r0, r1, r2)        = unzip3([("1",".","swift"),("2",".","o"),("3",".","cpp")])
                expect(r0).to(equal(["1", "2", "3"]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
            }
            
            it("String Array - Int") {
                let (r0, r1, r2)        = unzip3([(1,".","swift"),(2,".","o"),(3,".","cpp")])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
            }
        }
        
        describe("unzip4") {
            it("Int Array") {
                let (r0, r1, r2, r3)        = unzip4([(1,1,1,1),(2,4,8,2),(3,9,27,3)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([1, 4, 9]))
                expect(r2).to(equal([1, 8, 27]))
                expect(r3).to(equal([1, 2, 3]))
            }
            
            it("String Array") {
                let (r0, r1, r2, r3)        = unzip4([("1",".","swift","1"),("2",".","o","2"),("3",".","cpp","3")])
                expect(r0).to(equal(["1", "2", "3"]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal(["1", "2", "3"]))
            }
            
            it("String Array - Int") {
                let (r0, r1, r2, r3)        = unzip4([(1,".","swift",1),(2,".","o",2),(3,".","cpp",3)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal([1, 2, 3]))
            }
        }
        
        describe("unzip5") {
            it("Int Array") {
                let (r0, r1, r2, r3, r4)        = unzip5([(1,1,1,1,1),(2,4,8,2,4),(3,9,27,3,9)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([1, 4, 9]))
                expect(r2).to(equal([1, 8, 27]))
                expect(r3).to(equal([1, 2, 3]))
                expect(r4).to(equal([1, 4, 9]))
            }
            
            it("String Array") {
                let (r0, r1, r2, r3, r4)        = unzip5([("1",".","swift","1","."),("2",".","o","2","."),("3",".","cpp","3",".")])
                expect(r0).to(equal(["1", "2", "3"]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal(["1", "2", "3"]))
                expect(r4).to(equal( [".", ".", "." ]))
            }
            
            it("String Array - Int") {
                let (r0, r1, r2, r3, r4)        = unzip5([(1,".","swift",1,1),(2,".","o",2,4),(3,".","cpp",3,9)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal([1, 2, 3]))
                expect(r4).to(equal([1, 4, 9]))
            }
        }
        
        describe("unzip6") {
            it("Int Array") {
                let (r0, r1, r2, r3, r4, r5)        = unzip6([(1,1,1,1,1,1),(2,4,8,2,4,8),(3,9,27,3,9,27)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([1, 4, 9]))
                expect(r2).to(equal([1, 8, 27]))
                expect(r3).to(equal([1, 2, 3]))
                expect(r4).to(equal([1, 4, 9]))
                expect(r5).to(equal([1, 8, 27]))
            }
            
            it("String Array") {
                let (r0, r1, r2, r3, r4, r5)        = unzip6([("1",".","swift","1",".","swift"),("2",".","o","2",".","o"),("3",".","cpp","3",".","cpp")])
                expect(r0).to(equal(["1", "2", "3"]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal(["1", "2", "3"]))
                expect(r4).to(equal( [".", ".", "." ]))
                expect(r5).to(equal(["swift", "o", "cpp"]))
            }
            
            it("String Array - Int") {
                let (r0, r1, r2, r3, r4, r5)        = unzip6([(1,".","swift",1,1,1),(2,".","o",2,4,8),(3,".","cpp",3,9,27)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal([1, 2, 3]))
                expect(r4).to(equal([1, 4, 9]))
                expect(r5).to(equal([1, 8, 27]))
            }
        }
        
        describe("unzip7") {
            it("Int Array") {
                let (r0, r1, r2, r3, r4, r5, r6)        = unzip7([(1,1,1,1,1,1,1),(2,4,8,2,4,8,2),(3,9,27,3,9,27,3)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([1, 4, 9]))
                expect(r2).to(equal([1, 8, 27]))
                expect(r3).to(equal([1, 2, 3]))
                expect(r4).to(equal([1, 4, 9]))
                expect(r5).to(equal([1, 8, 27]))
                expect(r6).to(equal([1, 2, 3]))
            }
            
            it("String Array") {
                let (r0, r1, r2, r3, r4, r5, r6)        = unzip7([("1",".","swift","1",".","swift","1"),("2",".","o","2",".","o","2"),("3",".","cpp","3",".","cpp","3")])
                expect(r0).to(equal(["1", "2", "3"]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal(["1", "2", "3"]))
                expect(r4).to(equal( [".", ".", "." ]))
                expect(r5).to(equal(["swift", "o", "cpp"]))
                expect(r6).to(equal(["1", "2", "3"]))
            }
            
            it("String Array - Int") {
                let (r0, r1, r2, r3, r4, r5, r6)        = unzip7([(1,".","swift",1,1,1,1),(2,".","o",2,4,8,2),(3,".","cpp",3,9,27,3)])
                expect(r0).to(equal([1, 2, 3]))
                expect(r1).to(equal([".", ".", "." ]))
                expect(r2).to(equal(["swift", "o", "cpp"]))
                expect(r3).to(equal([1, 2, 3]))
                expect(r4).to(equal([1, 4, 9]))
                expect(r5).to(equal([1, 8, 27]))
                expect(r6).to(equal([1, 2, 3]))
            }
        }
        
        describe("lines") {
            it("String") {
                let result = lines("Functions\n\n\n don't evaluate their arguments.")
                expect(result).to(equal(["Functions","",""," don't evaluate their arguments."]))
            }
        }
        
        describe("words") {
            it("String") {
                let result = words("Functions\n\n\n don't evaluate their arguments.")
                expect(result).to(equal(["Functions","don't","evaluate","their","arguments."]))
            }
        }
        
        describe("unlines") {
            it("String") {
                let result = unlines(["Functions","",""," don't evaluate their arguments."]) //()
                expect(result).to(equal("Functions\n\n\n don't evaluate their arguments."))
            }
        }
        
        describe("unwords") {
            it("String") {
                let result = unwords(["Functions","don't","evaluate","their","arguments."])
                expect(result).to(equal("Functions don't evaluate their arguments."))
            }
        }
        
        describe("nub") {
            it("Int Array") {
                let result  = nub([1, 1, 2, 4, 1, 3, 9])
                expect(result).to(equal([1,2,4,3,9]))
            }
            
            it("String Array") {
                let result  = nub(["Create", "Set", "Any", "Set", "Any"])
                expect(result).to(equal(["Create","Set","Any"]))
            }
            
            it("String") {
                let result  = nub("are you ok")
                expect(result).to(equal("are youk"))
            }
        }
        
        describe("delete") {
            it("Int Array") {
                let list    = [1, 1, 2, 4, 1, 3, 9]
                expect(HaskellSwift.delete(2, list)).to(equal([1,1,4,1,3,9]))
                expect(HaskellSwift.delete(1, list)).to(equal([1,2,4,1,3,9]))
            }
            
            it("String Array") {
                let list    = ["Create", "Set", "Any", "Set", "Any"]
                expect(HaskellSwift.delete("Set", list)).to(equal(["Create","Any","Set","Any"]))
                expect(HaskellSwift.delete("Any", list)).to(equal(["Create","Set","Set","Any"]))
            }
            
            it("String") {
                expect(HaskellSwift.delete(Character("t"), "Swift")).to(equal("Swif"))
                expect(HaskellSwift.delete("t", "Swift")).to(equal("Swif"))
            }
        }
        
        describe("union") {
            it("Int Array") {
                let list1   = [1, 1, 2]
                let list2   = [4, 1, 3, 9]
                expect(union(list1, list2)).to(equal([1, 2, 4, 3, 9]))
            }
            
            it("String Array") {
                let list1   = ["Create", "Set"]
                let list2   = ["Any", "Set", "Any"]
                expect(union(list1, list2)).to(equal(["Create","Set", "Any"]))
            }
        }
        
        describe("intersect") {
            it("Int Array") {
                let list1   = [1, 1, 2]
                let list2   = [4, 1, 3, 9]
                expect(intersect(list1, list2)).to(equal([1, 1]))
            }
            
            it("String Array") {
                let list1   = ["Create", "Set", "Set"]
                let list2   = ["Any", "Set", "Any"]
                expect(intersect(list1, list2)).to(equal(["Set", "Set"]))
            }
        }
        
        describe("sort") {
            it("Int Array") {
                let list    = [1, 1, 2, 4, 1, 3, 9]
                expect(sort(list)).to(equal([1, 1, 1, 2, 3, 4, 9]))
            }
            
            it("String Array") {
                let list    = ["Create", "Set", "Any", "Set", "Any"]
                expect(sort(list)).to(equal(["Any", "Any", "Create", "Set", "Set"]))
            }
        }
        
        describe("sortOn") {
            it("Int Array") {
                let list    = [1, 1, 2, 4, 1, 3, 9]
                expect(sortOn({x, y in x < y}, list)).to(equal([1, 1, 1, 2, 3, 4, 9]))
                expect(sortOn({x, y in x > y}, list)).to(equal([9,4,3,2,1,1,1]))
            }
            
            it("String Array") {
                let list    = ["Create", "Set", "Any", "Set", "Any"]
                expect(sortOn({x, y in x < y}, list)).to(equal(["Any", "Any", "Create", "Set", "Set"]))
                expect(sortOn({x, y in x > y}, list)).to(equal(["Set","Set","Create","Any","Any"]))
            }
        }
        
        describe("insert") {
            it("Int Array") {
                let list    = [1, 1, 2, 4, 1, 3, 9]
                let result  = insert(10, list)
                expect(result).to(equal([1, 1, 2, 4, 1, 3, 9, 10]))
            }
            
            it("String Array") {
                let list    = ["Create", "Set", "Any", "Set", "Any"]
                expect(insert("Where", list)).to(equal(["Create", "Set", "Any", "Set", "Any", "Where"]))
            }
            
            it("String") {
                let list    = "Hello World"
                expect(insert("!", list)).to(equal("Hello World!"))
            }
        }
        
        describe("nubBy") {
            it("Int Array") {
                expect(nubBy({ (x: Int, y: Int) in x == y }, [1, 1, 2, 4, 1, 3, 9])).to(equal([1,2,4,3,9]))
                expect(nubBy({ (x: Int, y: Int) in x == y || x < 3}, [1, 1, 2, 4, 1, 3, 9])).to(equal([1, 4, 3, 9]))
            }
            
            it("String Array") {
                let list = ["Create", "Set", "Any", "Set", "Any"]
                expect(nubBy({ (x: String, y: String) in x == y }, list)).to(equal(["Create","Set","Any"]))
                expect(nubBy({ (x: String, y: String) in length(intersect(x, y)) > 0 }, list)).to(equal(["Create", "Any"]))
            }
            
            it("String") {
                let f       = { (x: Character, y: Character) -> Bool in
                    let x1 = String(x).uppercased()
                    let y1 = String(y).uppercased()
                    return x1 == y1
                }
                let r1      = nubBy(f, "Create , cuT")
                expect(r1).to(equal("Creat ,u"))
                
                let isSame  = { (x: Character, y: Character) -> Bool in x == y }
                let r2      = nubBy(isSame, "Create a World")
                expect(r2).to(equal("Creat Wold"))
            }
        }
        
        describe("deleteBy") {
            it("Int Array") {
                let list    = [1, 1, 2, 4, 1, 3, 9]
                expect(deleteBy({x,y in x == y}, 2, list)).to(equal([1,1,4,1,3,9]))
                expect(deleteBy({x,y in x == y}, 1, list)).to(equal([1,2,4,1,3,9]))
            }
            
            it("String Array") {
                let list    = ["Create", "Set", "Any", "Set", "Any"]
                expect(deleteBy({x,y in x == y}, "Set", list)).to(equal(["Create","Any","Set","Any"]))
                expect(deleteBy({x,y in x == y}, "Any", list)).to(equal(["Create","Set","Set","Any"]))
            }
            
            it("String") {
                expect(deleteBy({x,y in x == y}, Character("t"), "Swift")).to(equal("Swif"))
                expect(deleteBy({x,y in x == y}, "t", "Swift")).to(equal("Swif"))
            }
        }
        
        describe("deleteFirstsBy") {
            it("Int Array") {
                let list1    = [1, 1, 2, 4, 1, 3, 9]
                let list2    = [2, 4, 1, 3]
                expect(deleteFirstsBy({x,y in x == y}, list1, list2)).to(equal([1,1,9]))
                expect(deleteFirstsBy({x,y in x == y}, list2, list1)).to(equal([]))
            }
            
            it("String Array") {
                let list1    = ["Create", "Set", "Any", "Set", "Any"]
                let list2    = ["Set", "Any", "Object"]
                expect(deleteFirstsBy({x,y in x == y}, list1, list2)).to(equal(["Create","Set","Any"]))
                expect(deleteFirstsBy({x,y in x == y}, list2, list1)).to(equal(["Object"]))
            }
            
            it("String") {
                let list1   = "overloaded"
                let list2   = "number of elements"
                expect(deleteFirstsBy({x,y in x == y}, list1, list2)).to(equal("voadd"))
                expect(deleteFirstsBy({x,y in x == y}, list2, list1)).to(equal("numb f ements"))
            }
        }
        
        describe("unionBy") {
            it("Int Array") {
                let list1    = [1, 1, 2, 4, 1, 3, 9]
                let list2    = [2, 4, 1, 3]
                expect(unionBy({x,y in x == y}, list1, list2)).to(equal([1,1,2,4,1,3,9]))
                expect(unionBy({x,y in x == y}, list2, list1)).to(equal([2,4,1,3,9]))
            }
            
            it("String Array") {
                let list1    = ["Create", "Set", "Any", "Set", "Any"]
                let list2    = ["Set", "Any", "Object"]
                let r0       = unionBy({x,y in x == y}, list1, list2)
                expect(r0).to(equal(["Create","Set","Any","Set","Any","Object"]))
                let r1       = unionBy({x,y in x == y}, list2, list1)
                expect(r1).to(equal(["Set","Any","Object","Create"]))
            }
            
            it("String") {
                let list1   = "overloaded"
                let list2   = "number of elements"
                expect(unionBy({x,y in x == y}, list1, list2)).to(equal("overloadednumb fts"))
                expect(unionBy({x,y in x == y}, list2, list1)).to(equal("number of elementsvad"))
            }
        }
        
        describe("intersectBy") {
            it("Int Array") {
                let list1    = [1, 1, 2, 4, 1, 3, 9]
                let list2    = [2, 4, 1, 3]
                expect(intersectBy({x,y in x == y}, list1, list2)).to(equal([1,1,2,4,1,3]))
                expect(intersectBy({x,y in x == y}, list2, list1)).to(equal([2,4,1,3]))
            }
            
            it("String Array") {
                let list1    = ["Create", "Set", "Any", "Set", "Any"]
                let list2    = ["Set", "Any", "Object"]
                let r0       = intersectBy({x,y in x == y}, list1, list2)
                expect(r0).to(equal(["Set","Any","Set","Any"]))
                let r1       = intersectBy({x,y in x == y}, list2, list1)
                expect(r1).to(equal(["Set","Any"]))
            }
            
            it("String") {
                let list1   = "overloaded"
                let list2   = "number of elements"
                expect(intersectBy({x,y in x == y}, list1, list2)).to(equal("oerloe"))
                expect(intersectBy({x,y in x == y}, list2, list1)).to(equal("eroelee"))
            }
        }
        
        describe("groupBy") {
            it("Int Array") {
                let ints            = [1, 1, 2, 3, 3, 5, 5]
                let r0              = groupBy({(x, y) in x == y}, ints)
                expect(r0).to(equal([[1,1],[2],[3,3],[5,5]]))
                let r1              = groupBy({(x,y) in x < y}, ints)
                let _r1             = [[1],[1,2,3,3,5,5]]
                expect(r1).to(equal(_r1))
            }
            
            it("String Array") {
                let list    = ["Apple", "Pie", "Pie"]
                let r0      = groupBy( {(x, y) in x == y}, list)
                expect(r0).to(equal([["Apple"], ["Pie", "Pie"]]))
                let r1      = groupBy({(x,y) in x > y}, list)
                let _r1     = [["Apple"],["Pie"],["Pie"]]
                expect(r1).to(equal(_r1))
            }
            
            it("String") {
                let list    = "Hello World"
                let r0      = groupBy({(x, y) in x == y}, list)
                let _r0     = ["H","e","ll","o"," ","W","o","r","l","d"]
                expect(r0).to(equal(_r0))
                let r1      = groupBy({(x, y) in x < y}, list)
                let _r1     = ["Hello"," World"]
                expect(r1).to(equal(_r1))
            }
        }
        
        describe("sortBy") {
            it("Int Array") {
                let list    = [1, 1, 2, 4, 1, 3, 9]
                expect(sortBy({x, y in x < y}, list)).to(equal([1,1,1,2,3,4,9]))
                expect(sortBy({x, y in x > y}, list)).to(equal([9,4,3,2,1,1,1]))
            }
            
            it("String Array") {
                let list    = ["Create", "Set", "Any", "Set", "Any"]
                expect(sortBy({x, y in x < y}, list)).to(equal(["Any", "Any", "Create", "Set", "Set"]))
                expect(sortBy({x, y in x > y}, list)).to(equal(["Set","Set","Create","Any","Any"]))
            }
        }
        
        describe("insertBy") {
            it("Int Array") {
                let list    = [1, 1, 2, 4, 1, 3, 9]
                expect(insertBy({x, y in x < y}, 6, list)).to(equal([1,1,2,4,1,3,6,9]))
                expect(insertBy({x, y in x > y}, 2, list)).to(equal([2,1,1,2,4,1,3,9]))
            }
            
            it("String Array") {
                let list    = ["Create", "Set", "Any", "Set", "Any"]
                expect(insertBy({x, y in x < y}, "Object", list)).to(equal(["Create","Object","Set","Any","Set","Any"]))
                expect(insertBy({x, y in x > y}, "Object", list)).to(equal(["Object","Create","Set","Any","Set","Any"]))
            }
        }
        
        describe("maximumBy") {
            it("Int Array") {
                let list    = [1, 1, 2, 18, 4, 24, 6, 9]
                let r0 = maximumBy({(x: Int, y: Int) in x < y ? Ordering.lt : Ordering.gt }, list)
                expect(r0) == 24
                let r1 = maximumBy({x, y in x > y ? Ordering.gt : Ordering.lt }, list)
                expect(r1) == 24
            }
            
            it("String Array") {
                let list    = ["Create", "Set", "Any", "Set", "Any"]
                expect(maximumBy({(x: String, y: String) in x < y ? Ordering.lt : Ordering.gt }, list)).to(equal("Set"))
                expect(maximumBy({x, y in x > y ? Ordering.gt : Ordering.lt }, list)).to(equal("Set"))
            }
        }
        
        describe("minimumBy") {
            it("Int Array") {
                let list    = [1, 1, 2, 18, 4, 24, 6, 9]
                expect(minimumBy({x, y in x < y ? Ordering.lt : Ordering.gt }, list)).to(equal(1))
                expect(minimumBy({x, y in x > y ? Ordering.gt : Ordering.lt }, list)).to(equal(1))
            }
            
            it("String Array") {
                let list    = ["Create", "Set", "Any", "Set", "Any"]
                expect(minimumBy({x, y in x < y ? Ordering.lt : Ordering.gt }, list)).to(equal("Any"))
                expect(minimumBy({x, y in x > y ? Ordering.gt : Ordering.lt }, list)).to(equal("Any"))
            }
        }
        
        describe("genericLength") {
            it("Int Array") {
                expect(genericLength([1])).to(equal(1))
                expect(genericLength([1,2])).to(equal(2))
            }
            
            it("String Array") {
                expect(genericLength(["World"])).to(equal(1))
                expect(genericLength(files)).to(equal(files.count))
            }
            
            it("String") {
                expect(genericLength("World")).to(equal(5))
                expect(genericLength("")).to(equal(0))
            }
        }
    }
}
