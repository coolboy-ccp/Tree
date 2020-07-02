//
//  BinaryTree.swift
//  Tree
//
//  Created by 123 on 2020/7/1.
//  Copyright © 2020 ccp. All rights reserved.
//

import UIKit

public indirect enum BinaryTree<T> {
    case node(BinaryTree<T>, T, BinaryTree<T>)
    case empty
    
    public var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + right.count + 1
        case .empty:
            return 0
        }
    }    
}

extension BinaryTree: CustomStringConvertible {
    public var description: String {
      switch self {
      case let .node(left, value, right):
        return "value: \(value), left = [\(left.description)], right = [\(right.description)]"
      case .empty:
        return ""
      }
    }
}

extension BinaryTree {
    public func traverseInOrder(process: (T) -> Void) {
        if case let .node(left, value, right) = self {
            left.traverseInOrder(process: process)
            process(value)
            right.traverseInOrder(process: process)
        }
    }
    
    public func traversePreOrder(process: (T) -> Void) {
        if case let .node(left, value, right) = self {
            process(value)
            left.traverseInOrder(process: process)
            right.traverseInOrder(process: process)
        }
    }
    
    public func traversePostOrder(process: (T) -> Void) {
        if case let .node(left, value, right) = self {
            left.traverseInOrder(process: process)
            right.traverseInOrder(process: process)
            process(value)
        }
    }
    
    public func traverseLevelOrder(process: (T) -> Void) {
        var queue = [self]
        while queue.count > 0 {
            _ = queue.map {
                if case let .node(left, value, right) = $0 {
                    process(value)
                    queue.append(contentsOf: [left, right])
                }
                queue = Array(queue.dropFirst())
            }
        }
    }
    
    public func traverseLevelOrder() -> [BinaryTree<T>] {
        var level = 0
        var marr = [[BinaryTree<T>]]()
        marr.append([self])
        
        while level == marr.count - 1 {
            var levelArr = [BinaryTree<T>]()
            for n in marr[level] {
                if case let .node(left, _ , right) = n {
                    levelArr.append(left)
                    levelArr.append(right)
                }
            }
            if levelArr.count > 0 {
                marr.append(levelArr)
            }
            
            level += 1
        }
        return marr.flatMap {
            $0.map {
                $0
            }
        }

    }
}
