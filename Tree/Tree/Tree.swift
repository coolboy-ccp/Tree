//
//  Tree.swift
//  Tree
//
//  Created by 123 on 2020/6/23.
//  Copyright © 2020 ccp. All rights reserved.
//

import UIKit

class TreeNode<T> {
    var value: T?
    var parent: TreeNode?
    var children = [TreeNode]()
    
    init(value: T? = nil) {
        self.value = value
    }
    
    func add(child: TreeNode) {
        children.append(child)
        child.parent = self
    }
}

extension TreeNode where T: Equatable {
    func search(_ value: T?) -> TreeNode? {
        if let v = self.value, v == value {
            return self
        }
        for child in children {
            if let result = child.search(value) {
                return result
            }
        }
        return nil
    }
}


