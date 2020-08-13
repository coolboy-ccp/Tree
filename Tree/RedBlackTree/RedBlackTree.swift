//
//  RedBlackTree.swift
//  Tree
//
//  Created by 123 on 2020/8/11.
//  Copyright © 2020 ccp. All rights reserved.
//

import UIKit

enum RotationDirection {
    case left
    case right
}


class RedBlackTree<T: Comparable>: NSObject {
    typealias Node = RedBlackNode<T>
    
    var root = Node()
    var size = 0
    
    
}

/// insert
/// https://www.jianshu.com/p/e136ec79235c
extension RedBlackTree {
    
    func balance(_ node: Node) {
        defer {
            root.color = .black
        }
        guard !node.isNil, let parent = node.parent, parent.color == .red, let uncle = node.uncle else { return }
        /// 叔叔节点不是叶子节点，变色操作
        if uncle.color == .red {
            parent.color = .black
            uncle.color = .black
            if let gp = parent.parent {
                gp.color = .red
                balance(gp)
            }
        }
        /// 叔叔节点是叶子节点，旋转操作
        else {
        }
        
    }
    
}

/// search
extension RedBlackTree {
    
    func sarch(_ value: T) -> Node? {
        return search(value, from: root)
    }
    
    func search(_ value: T, from node: Node?) -> Node? {
        guard
            let node = node,
            let v = node.value,
            !node.isNil
            else {
                return nil
        }
        if v == value {
            return node
        }
        else if v < value {
            return search(value, from: node.right)
        }
        else if v > value {
            return search(value, from: node.left)
        }
        return nil
    }
}
