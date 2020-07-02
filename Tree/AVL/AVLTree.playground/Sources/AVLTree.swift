//
//  AVLTree.swift
//  Tree
//
//  Created by 123 on 2020/6/30.
//  Copyright © 2020 ccp. All rights reserved.
//

import UIKit

public final class AVLTree<Key: Comparable, Value> {

    public typealias Node = AVLNode<Key, Value>
    var root: Node?
    var count = 0
    
    public init() {}
}



//insert
extension AVLTree {
    
    public func insert(_ key: Key, _ value: Value) {
        if let root = root {
            insert(key, value, to: root)
        }
        else {
            root = Node(key, value)
        }
        count += 1
    }
    
    func insert(_ key: Key, _ value: Value?, to node: Node) {
        if key == node.key { return }
        if key > node.key {
            insertToRight(key, value, to: node)
        }
        else {
            insertToLeft(key, value, to: node)
        }
    }
    
    private func insertToLeft(_ key: Key, _ value: Value?, to node: Node) {
        guard let left = node.left else {
            node.left = Node(key, value)
            if let parent = node.parent {
                node.left?.setHeight()
                parent.balance()
            }
            return
        }
        insert(key, value, to: left)
    }
    
    private func insertToRight(_ key: Key, _ value: Value?, to node: Node) {
        guard let right = node.right else {
            node.right = Node(key, value)
            if let parent = node.parent {
                node.right?.setHeight()
                parent.balance()
            }            
            return
        }
        insert(key, value, to: right)
    }
}

//search
extension AVLTree {
    
    public func search(_ key: Key) -> Node? {
        return search(key, node: root)
    }
   
    func search(_ key: Key, node: Node?) -> Node? {
        guard let node = node else {
            return nil
        }
        if key == node.key {
            return node
        }
        if key < node.key {
           return search(key, node: node.left)
        }
        if key > node.key {
            return search(key, node: node.right)
        }
        return nil
    }
}

extension AVLTree {
    public func traverseInOrder(process: (Node) -> Void) {
        root?.traverseInOrder(process: process)
    }
}


