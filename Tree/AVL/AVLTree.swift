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
    public func delete(node: Node) {
        if node.isLeaf {
            deleteLeaf(node: node)
            return
        }
        
    }
    
    private func deleteLeaf(node: Node) {
        guard let parent = node.parent else {
            root = nil
            return
        }
        if node.isLeft {
            parent.left = nil
        }
        else {
            parent.right = nil
        }
        if parent.isLeaf {
            parent.height -= 1
            parent.parent?.balance()
        }
        
    }
    
    private func deleteStem(node: Node) {
        let replace = replaceNode(node: node)
        if replace !== node {
            node.key = replace.key
            node.value = replace.value
            delete(node: replace)
        }
    }
    
    private func replaceNode(node: Node) -> Node {
        if let left = node.left?.max() {
            return left
        }
        return (node.right?.min())!
    }
}

extension AVLTree {
    public func traverseInOrder(process: (Node) -> Void) {
        root?.traverseInOrder(process: process)
    }
}


