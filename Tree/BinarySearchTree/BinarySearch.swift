//
//  BinarySearch.swift
//  Tree
//
//  Created by 123 on 2020/8/11.
//  Copyright © 2020 ccp. All rights reserved.
//

import UIKit

enum BinarySearchTree<T: Comparable> {
    case empty
    case leaf(T)
    indirect case node(BinarySearchTree, T, BinarySearchTree)
}

extension BinarySearchTree {
    var count: Int {
        switch self {
        case .empty:
            return 0
        case .leaf:
            return 1
        case let .node(left, _, right):
            return left.count + right.count + 1
            
        }
    }
    
    var height: Int {
        switch self {
        case .empty:
            return -1
        case .leaf:
            return 0
        case let .node(left, _, right):
            return max(left.height, right.height) + 1
        }
    }
}

extension BinarySearchTree {
    func insert(_ newValue: T) -> BinarySearchTree {
        switch self {
        case .empty:
            return .leaf(newValue)
        case .leaf(let value):
            if newValue > value {
                return .node(.empty, value, .leaf(newValue))
            }
            return .node(.leaf(newValue), value, .empty)
        case let .node(left, value, right):
            if newValue > value {
                return .node(left, value, right.insert(newValue))
            }
            return .node(left.insert(newValue), value, right)
        }
    }
    
    func search(_ value: T) -> BinarySearchTree? {
        switch self {
        case .empty:
            return nil
        case .leaf(let v):
            return (value == v) ? self : nil
        case let .node(left, v, right):
            if value > v {
                return right.search(value)
            }
            else if value < v {
                return left.search(value)
            }
            return self
        }
    }
}
