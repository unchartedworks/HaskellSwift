//
//  DataList.swift
//  HaskellSwift
//
//  Created by Liang on 14/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation

infix operator • { associativity right precedence 100}
func •<A,B,C>(f2: B->C, f1: A->B) -> (A->C) {
    return { (x: A) in f2(f1(x)) }
}

//func •<A,B,C>(f2: [B]->[C], f1: [A]->[B]) -> ([A]->[C]) {
//    return { (x: [A]) in f2(f1(x)) }
//}

//MARK: - Basic functions
//MARK: (++) :: [a] -> [a] -> [a]
infix operator ++ {}
func ++<A>(left: [A], right: [A]) -> [A] {
    return left + right
}

func ++(left: String, right: String) -> String {
    return left + right
}

//MARK: head :: [a] -> a
public func head<T>(xs: [T]) ->T {
    assert(xs.isEmpty != true, "Empty List")
    return xs[0]
}

public func head(xs: String) -> Character {
    assert(xs.isEmpty != true, "Empty List")
    let c =  xs[advance(xs.startIndex, 0)]
    return c
}

//MARK: last :: [a] -> a
public func last<T>(xs: [T]) ->T {
    assert(xs.isEmpty != true, "Empty List")
    return xs[xs.count - 1]
}

public func last(xs: String) -> Character {
    assert(xs.isEmpty != true, "Empty List")
    let c =  xs[advance(xs.endIndex, -1)]
    return c
}

//MARK: tail :: [a] -> [a]
public func tail<T>(xs: [T])->[T] {
    var list = [T]()
    assert(xs.count > 0, "Empty List")
    if xs.count == 1 {
        return list
    }
    
    for i in 1..<(xs.count) {
        list.append(xs[i])
    }
    
    return list
}

public func tail(xs: String)->String {
    var list = String()
    assert(xs.characters.count > 0, "Empty List")
    if xs.characters.count == 1 {
        return list
    }
    
    for i in 1..<(xs.characters.count) {
        let c = xs[advance(xs.startIndex, i)]
        list.append(c)
    }
    
    return list
}

//MARK: init :: [a] -> [a]
public func xinit<T>(xs: [T])->[T] {
    var list = [T]()
    assert(xs.count > 0, "Empty List")
    if xs.count == 1 {
        return list
    }
    
    for i in 0..<(xs.count - 1) {
        list.append(xs[i])
    }
    
    return list
}

public func xinit(xs: String)->String {
    var list = String()
    assert(xs.characters.count > 0, "Empty List")
    if xs.characters.count == 1 {
        return list
    }
    
    for i in 0..<(xs.characters.count - 1) {
        let c = xs[advance(xs.startIndex, i)]
        list.append(c)
    }
    
    return list
}

//MARK: null :: Foldable t => t a -> Bool
public func null<T>(xs: [T]) -> Bool {
    return xs.isEmpty
}

public func null(xs: String) -> Bool {
    return xs.characters.count == 0
}

//MARK: length :: Foldable t => t a -> Int
public func length<T>(xs: [T]) -> Int {
    return xs.count
}

public func length(xs: String) -> Int {
    return xs.characters.count
}

//MARK: - List transformations
//MARK: map :: (a -> b) -> [a] -> [b]
public func map(transform: Character->Character, _ xs: String) -> String {
    var results = String()
    for i in 0..<xs.characters.count {
        let c = xs[advance(xs.startIndex, i)]
        results.append(transform(c))
    }
    
    return results
}

public func map<U>(transform: Character-> U, _ xs: String) -> [U] {
    var results = [U]()
    for i in 0..<xs.characters.count {
        let c = xs[advance(xs.startIndex, i)]
        results.append(transform(c))
    }
    
    return results
}

public func map<T, U>(transform: T->U, _ xs: [T]) -> [U] {
    var results = [U]()
    for x in xs {
        results.append(transform(x))
    }
    
    return results
}

//MARK: reverse :: [a] -> [a]
public func reverse<T>(xs: [T]) -> [T] {
    return [T](xs.reverse())
}

public func reverse(xs: String) -> String {
    return String(xs.characters.reverse())
}

//MARK: - Reducing lists (folds)
//MARK: foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b
public func foldl<A,B>(process: (A, B)->A, _ initialValue: A, _ xs: [B]) -> A {
    return reduce(process, initialValue, xs)
}

public func foldl(process: (String, Character)->String, _ initialValue: String, _ xs: String) -> String {
    return reduce(process, initialValue, xs)
}

public func reduce<S, T> (combine: (T, S)->T, _ initial: T, _ xs: [S]) -> T {
    var result = initial
    for x in xs {
        result = combine(result, x)
    }
    
    return result
}

public func reduce(combine: (String, Character)->String, _ initial: String, _ xs: String) -> String {
    var result = initial
    for x in xs.characters {
        result = combine(result, x)
    }
    
    return result
}

//MARK: foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
public func foldr<A,B>(process: (A, B)->B, _ initialValue: B, _ xs: [A]) -> B {
    var result = initialValue
    for x in xs.reverse() {
        result = process(x, result)
    }
    
    return result
}

public func foldr(process: (Character, String)->String, _ initialValue: String, _ xs: String) -> String {
    var result = initialValue
    for x in xs.characters.reverse() {
        result = process(x, result)
    }
    
    return result
}

//MARK: - Building lists
//MARK: Scans

//MARK: - Sublists
//MARK: Extracting sublists
//MARK: take :: Int -> [a] -> [a]
public func take<T>(len: Int, _ xs: [T]) -> [T] {
    assert(len >= 0 , "Illeagal Length")
    var list = [T]()
    if len == 0 {
        return list
    }
    
    if len >= xs.count {
        return xs
    }
    
    for i in 0..<len {
        list.append(xs[i])
    }
    
    return list
}

public func take(len: Int, _ xs: String)->String {
    var list = String()
    assert(len >= 0, "Illeagal Length")
    if len == 0 {
        return list
    }
    
    if len >= xs.characters.count {
        return xs
    }
    
    for i in 0..<len {
        let c = xs[advance(xs.startIndex, i)]
        list.append(c)
    }
    
    return list
}

//MARK: drop :: Int -> [a] -> [a]
public func drop<T>(len: Int, _ xs: [T]) -> [T] {
    assert(len >= 0, "Illeagal Length")
    var list = [T]()
    if len == 0 {
        return xs
    }
    
    if len >= xs.count {
        return list
    }
    
    for i in len..<xs.count {
        list.append(xs[i])
    }
    
    return list
}

public func drop(len: Int, _ xs: String)->String {
    var list = String()
    assert(len >= 0, "Illeagal Length")
    if len == 0 {
        return xs
    }
    
    if len >= xs.characters.count {
        return list
    }
    
    for i in len..<(xs.characters.count) {
        let c = xs[advance(xs.startIndex, i)]
        list.append(c)
    }
    
    return list
}

//MARK: - Searching lists
//MARK: Searching by equality

//MARK: Searching with a predicate
//MARK: filter :: (a -> Bool) -> [a] -> [a]
public func filter<U>(check: U -> Bool, _ xs: [U]) -> [U] {
    var results = [U]()
    for x in xs {
        if check(x) {
            results.append(x)
        }
    }
    
    return results
}

public func filter(check: Character -> Bool, _ xs: String) -> String {
    var results = String()
    for x in xs.characters {
        if check(x) {
            results.append(x)
        }
    }
    
    return results
}

//MARK: Indexing lists