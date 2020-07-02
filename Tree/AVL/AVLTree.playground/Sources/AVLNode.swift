//
//  AVLTree.swift
//  Tree
//
//  Created by 123 on 2020/6/30.
//  Copyright © 2020 ccp. All rights reserved.
//

import Swift

/// sorted by Key
public final class AVLNode<Key: Comparable, Value> {
    public typealias Node = AVLNode<Key, Value>
    
    public var key: Key
    public var value: Value?
    weak var parent: Node?
    
    public var height: Int = 1
    
    public var left: Node? {
        didSet {
            left?.parent = self
        }
    }
    public var right: Node? {
        didSet {
            right?.parent = self
        }
    }
    
    init (_ key: Key, _ value: Value?, left: Node? = nil, right: Node? = nil, parent: Node? = nil) {
        self.key = key
        self.value = value
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
    public static func == (lhs: AVLNode<Key, Value>, rhs: AVLNode<Key, Value>) -> Bool {
        return lhs.key == rhs.key
    }
}

extension AVLNode {
    func min() -> Node? {
        if !hasLeft {
            return self
        }
        return left?.min()
    }
    
    func max() -> Node? {
        if !hasRight {
            return self
        }
        return right?.max()
    }
}

extension AVLNode {
    
    func setHeight() {
        let l = left?.height ?? 0
        let r = right?.height ?? 0
        height = Swift.max(l, r) + 1
        parent?.setHeight()
    }
    
    var lrDifference: Int {
        let l = left?.height ?? 0
        let r = right?.height ?? 0
        return l - r
    }
    
    func balance() {
        let lrDif = lrDifference
        if lrDif > 1 {
            LBalance()
        }
        else if lrDif < -1 {
            RBalance()
        }
    }
    
    private func LBalance() {
        if LLBalance() { return }
        LRBalance()
    }
    
    private func RBalance() {
        if RRBalance() { return }
        RLBalance()
    }
    
    private func LLBalance() -> Bool {
        guard let l1 = left, let l2 = l1.left else {
            return false
        }
        left = nil
        resetParent(child: l1)
        l1.right = self
        l1.left = l2
        return true
    }
    
    private func LRBalance() {
        guard let l1 = left, let r2 = l1.right else {
            return
        }
        l1.right = nil
        right = r2
    }
    
    private func RRBalance() -> Bool {
        guard let r1 = right, let r2 = r1.right else {
            return false
        }
        right = nil
        resetParent(child: r1)
        r1.right = r2
        r1.left = self
        return true
    }
    
    private func RLBalance() {
        guard let r1 = right, let l2 = r1.left else {
            return
        }
        r1.left = nil
        left = l2
    }
    
    private func resetParent(child: Node) {
        if isLeft {
            parent?.left = child
        }
        else {
            parent?.right = child
        }
    }
    
}

extension AVLNode {
    public func traverseInOrder(process: (Node) -> Void) {
        left?.traverseInOrder(process: process)
        process(self)
        right?.traverseInOrder(process: process)
    }
}


