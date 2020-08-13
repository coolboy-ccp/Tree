//
//  RedBlackNode.swift
//  Tree
//
//  Created by 123 on 2020/8/12.
//  Copyright © 2020 ccp. All rights reserved.
//

import UIKit

enum RBColor {
    case red
    case black
}

class RedBlackNode<T: Comparable> {
    
    var parent: RedBlackNode?
    var left: RedBlackNode?
    var right: RedBlackNode?
    var value: T?
    lazy var color: RBColor = .red
    
    init(value: T? = nil, left: RedBlackNode? = nil, right: RedBlackNode? = nil, parent: RedBlackNode? = nil, color: RBColor = .red) {
        self.value = value
        self.left = left
        self.right = right
        self.parent = parent
        self.color = color
    }
    
    convenience init(_ value: T?) {
        self.init(value: value, left: RedBlackNode(), right: RedBlackNode())
    }
}

extension RedBlackNode {
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    var isNil: Bool {
        return value == nil
    }
    
    var isLeft: Bool {
        return parent?.left == self
    }
    
    var isRight: Bool {
        return parent?.right == self
    }
    
    var sibling: RedBlackNode? {
        return isLeft ? parent?.right : parent?.left
    }
    
    var uncle: RedBlackNode? {
        return parent?.sibling
    }
    
    var grandParent: RedBlackNode? {
        return parent?.parent
    }
    
    var minimum: RedBlackNode? {
        if let l = left, !l.isNil {
            return l.minimum
        }
        return self
    }
    
    var maxmum: RedBlackNode? {
        if let r = right, !r.isNil {
            return r.maxmum
        }
        return self
    }
    
    /// 中序后继
    /// 1.如果当前节点存在右子节点，则返回右节点最左节点
    /// 2.如果当前节点是左节点，则返回父节点
    /// 3.当前节点是右节点，向父节点寻找
    var succrssor: RedBlackNode? {
        if let right = right, !right.isNil {
            return right.minimum
        }
        var tmp = self
        var tmpp = parent
        while tmp.isRight {
            if let p = tmpp {
                tmp = p
                tmpp = tmp.parent
            }
            else {
                break
            }
        }
        return tmpp
    }
}

extension RedBlackNode: Equatable {
    static func == (lhs: RedBlackNode<T>, rhs: RedBlackNode<T>) -> Bool {
        return rhs.value == lhs.value
    }
}
