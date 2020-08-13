//
//  Trie.swift
//  DFA
//
//  Created by 123 on 2020/6/22.
//  Copyright © 2020 ccp. All rights reserved.
//

import UIKit

class TrieNode<T: Hashable> {
    let value: T?
    var parent: TrieNode?
    var children = [T : TrieNode]()
    var isTerminated = false
    
    var isLeaf: Bool {
        return children.count == 0
    }
    
    init(value: T? = nil, parent: TrieNode? = nil) {
        self.value = value
        self.parent = parent
    }
    
    func add(child value: T) -> TrieNode<T> {
        if children[value] != nil {
            return children[value]!
        }
        let node = TrieNode(value: value)
        children[value] = node
        return node
    }
    
}


class WordTrie: NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(words(), forKey: "words")
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
        if let words = coder.decodeObject(forKey: "words") as? [String] {
            for word in words {
                insert(word)
            }
        }
    }
    
    typealias Node = TrieNode<Character>
    
    private(set) var count: Int = 0
    
    
    private let root: Node
    
    override init() {
        root = Node()
        super.init()
    }
}

extension WordTrie {
    func insert(_ word: String) {
        if word.isEmpty { return }
        let node = word.reduce(root) {
            if let child = $0.children[$1] {
                return child
            }
            return $0.add(child: $1)
        }
        if node.isTerminated {
            return
        }
        count += 1
        node.isTerminated = true
    }
    
    func contains(word: String) -> Bool {
        if word.isEmpty { return false }
        var currentNode = root
        for character in word {
            guard let node = currentNode.children[character] else {
                return false
            }
            currentNode = node
        }
        return currentNode.isTerminated
    }
    
    private func lastNode(of word: String) -> Node? {
        var node = root
        for character in word {
            guard let child = node.children[character] else {
                return nil
            }
            node = child
        }
        return node
    }
    
    private func terminalNode(of word: String) -> Node? {
        guard let last = lastNode(of: word) else {
            return nil
        }
        if last.isTerminated {
            return last
        }
        return nil
    }
    
    private func deletNodes(with terminal: Node) {
        var node = terminal
        guard var value = node.value else {
            return
        }
        while node.isLeaf, let parent = node.parent {
            node = parent
            node.children[value] = nil
            if node.isTerminated {
                break
            }
            guard let newValue = node.value else {
                break
            }
            value = newValue
        }
    }
    
    func remove(word: String) {
        if word.isEmpty {
            return
        }
        guard let terminal = terminalNode(of: word) else {
            return
        }
        if terminal.isTerminated {
            deletNodes(with: terminal)
        }
        else {
            terminal.isTerminated = false
        }
        count -= 1
    }
    
    fileprivate func wordsInSubtrie(root: Node, previous: String) -> [String] {
        var words = previous
        var resultWords = [String]()
        if let value = root.value {
            words.append(value)
        }
        if root.isTerminated {
            resultWords.append(words)
        }
        for child in root.children.values {
            resultWords += wordsInSubtrie(root: child, previous: words)
        }
        return resultWords
    }
    
    
    func words(with prefix: String = "") -> [String] {
        var words = [String]()
        guard let node = lastNode(of: prefix) else {
            return words
        }
        if node.isTerminated {
            words.append(prefix)
        }
        return node.children.values.reduce([String]()) { (r, node) -> [String] in
            return r + wordsInSubtrie(root: node, previous: prefix)
        }
    }
    
    
}
