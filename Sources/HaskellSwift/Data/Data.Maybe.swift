//
//  Data.Maybe.swift
//  HaskellSwift
//
//  Created by Liang on 31/08/2015.
//  Copyright © 2015 Liang. All rights reserved.
//

import Foundation

public func Nothing() -> AnyObject? {
    return nil
}

public func Just<A>(_ x: A) -> A? {
    return Optional<A>.some(x)
}

//MARK: maybe :: b -> (a -> b) -> Maybe a -> b
public func maybe<A, B>(_ a: A, _ f:((B)->A), _ b: B?) -> A {
    return b == nil ? a : f(b!) //Don't use ??, it is different from this one.
}

//MARK: isJust :: Maybe a -> Bool
public func isJust<A>(_ a: A?) -> Bool {
    return a != nil
}

//MARK: isNothing :: Maybe a -> Bool
public func isNothing<A>(_ a: A?) -> Bool {
    return a == nil
}

//MARK: fromJust :: Maybe a -> a
public func fromJust<A>(_ a: A?) -> A {
    assert(a != nil, "nil")
    return a!
}

//MARK: fromMaybe :: a -> Maybe a -> a
public func fromMaybe<A>(_ b: A, _ a: A?) -> A {
    return a ?? b
}

public func fromMaybe<A>(_ b: A) -> (A?) -> A {
    return { a in fromMaybe(b, a) }
}

//MARK: listToMaybe :: [a] -> Maybe a
public func listToMaybe<A>(_ xs: [A]) -> A? {
    guard length(xs) > 0 else {
        return nil
    }
    
    let x : A? = xs[0]
    return x
}

//MARK: maybeToList :: Maybe a -> [a]
public func maybeToList<A>(_ x: A?) -> [A] {
    return isNothing(x) ? [A]() : [x!]
}

//MARK: catMaybes :: [Maybe a] -> [a]
public func catMaybes<A>(_ xs: [A?]) -> [A] {
    let ys = filter({x in x != nil}, xs)
    return map(fromJust, ys)
}

//MARK: mapMaybe :: (a -> Maybe b) -> [a] -> [b]
public func mapMaybe<A, B>(_ f:@escaping ((A)->B?), _ xs: [A]) -> [B] {
    return catMaybes(map(f, xs))
}
