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
    
    ///https://blog.csdn.net/collonn/article/details/20128205
    func balance() {
        left?.setHeight()
        right?.setHeight()
        let lrDif = lrDifference
        if lrDif > 1 {
            if left!.lrDifference > 0 {
                LL()
            }
            else {
                LR()
            }
        }
        else if lrDif < -1 {
            if right!.lrDifference < 0 {
                RR()
            }
            else {
                RL()
            }
        }
        else {
            parent?.balance()
        }
    }
    
    private func LL() {
        let l = left
        let p = parent
        let lr = l?.right
        
        l?.right = self
        l?.parent = p
        left = lr
    }
    
    private func LR() {
        let l = left
        let lr = l?.right
        left = lr
        lr?.left = l
        LL()
    }
    
    private func RR() {
        let r = right
        let p = parent
        let rl = left
        
        r?.parent = p
        r?.left = self
        right = rl
        
    }
    
    private func RL() {
        let r = right
        let rl = r?.left
        right = rl
        rl?.right = r
        RR()
    }
}

extension AVLNode {
    public func traverseInOrder(process: (Node) -> Void) {
        left?.traverseInOrder(process: process)
        process(self)
        right?.traverseInOrder(process: process)
    }
}


