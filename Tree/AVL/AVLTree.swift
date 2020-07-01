//
//  AVLTree.swift
//  Tree
//
//  Created by 123 on 2020/6/30.
//  Copyright © 2020 ccp. All rights reserved.
//

import UIKit

final class AVLTree<Key: Comparable, Value> {

    typealias Node = AVLNode<Key, Value>
    var root: Node?
    var size = 0
    
    init() {}
}

//balance
extension AVLTree {
    func updateDepth(_ node: Node?) {
        guard let node = node else {
            return
        }
        
    }
}

//insert
extension AVLTree {
    func insert(_ key: Key, _ value: Value?, node: Node) {
        
    }
}

//search
extension AVLTree {
    
    func search(_ key: Key) -> Node? {
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
