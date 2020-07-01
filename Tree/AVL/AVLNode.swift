//
//  AVLTree.swift
//  Tree
//
//  Created by 123 on 2020/6/30.
//  Copyright © 2020 ccp. All rights reserved.
//

import UIKit


/// sorted by Key
final class AVLNode<Key: Comparable, Value> {
    typealias Node = AVLNode<Key, Value>
    
    var key: Key
    var value: Value?
    var left: Node?
    var right: Node?
    var depth: Int
    weak fileprivate var parent: Node?
    
    init (_ key: Key, _ value: Value?, _ depth: Int, left: Node? = nil, right: Node? = nil, parent: Node? = nil) {
        self.key = key
        self.value = value
        self.depth = depth
        self.left = left
        self.right = right
        self.parent = parent
        
        self.right?.parent = self
        self.left?.parent = self
    }
    
    var isRoot: Bool {
        parent == nil
    }
    
    var isLeaf: Bool {
        return right == nil && left == nil
    }
    
    var isLeft: Bool {
        return parent?.left == self
    }
    
    var isRight: Bool {
        return parent?.right == self
    }
    
    var hasLeft: Bool {
        return left != nil
    }
    
    var hasRight: Bool {
        return right != nil
    }
    
    var hasChild: Bool {
        return hasLeft || hasRight
    }
    
    var hasBothChild: Bool {
        return hasLeft && hasRight
    }
}

extension AVLNode: Equatable {
    static func == (lhs: AVLNode<Key, Value>, rhs: AVLNode<Key, Value>) -> Bool {
        return lhs.key == rhs.key
    }
}

extension AVLNode {
    var min: Node? {
        if !hasLeft {
            return self
        }
        return left?.min
    }
    
    var max: Node? {
        if !hasRight {
            return self
        }
        return right?.max
    }
}


