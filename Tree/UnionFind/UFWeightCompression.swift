//
//  UFWeightCompression.swift
//  Tree
//
//  Created by 123 on 2020/8/13.
//  Copyright © 2020 ccp. All rights reserved.
//

import UIKit

class UFWeightCompression<T: Hashable> {
    private var index = [T : Int]()
      private var parent = [Int]()
      private var size = [Int]()
      
      init() {}
      
      func add(_ element: T) {
          index[element] = parent.count
          parent.append(parent.count)
          size.append(1)
      }
      
      func setBy(_ index: Int) -> Int {
          if parent[index] == index {
              return index
          }
          parent[index] = setBy(parent[index])
          return parent[index]
      }
      
      func setOf(_ element: T) -> Int? {
          if let idx = index[element] {
              return setBy(idx)
          }
          return nil
      }
      
      func unionSets(first: T, second: T) {
          guard let set1 = setOf(first), let set2 = setOf(second) else {
              return
          }
          if set1 == set2 { return }
          if size[set2] > size[set1] {
              parent[set1] = set2
              size[set2] += size[set1]
          }
          else {
              parent[set2] = set1
              size[set1] += size[set2]
          }
      }
      
      func isInSameSet(first: T, second: T) -> Bool {
          guard let set1 = setOf(first), let set2 = setOf(second) else {
              return false
          }
          return set2 == set1
      }
}

extension UFWeightCompression: CustomStringConvertible {
    var description: String {
        return """
        index: \(index),
        parent: \(parent),
        size: \(size)
        """
    }
}
