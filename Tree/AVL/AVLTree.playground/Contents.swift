import UIKit




func LLBalance() -> AVLTree<Int, String> {
    let tree = AVLTree<Int, String>()
    tree.insert(10, "a10")
    tree.insert(6, "a6")
    tree.insert(13, "a13")
    tree.insert(12, "a12")
    tree.insert(11, "a11")
    return tree
}

func LRBalance() -> AVLTree<Int, String> {
    let tree = AVLTree<Int, String>()
    tree.insert(10, "a10")
    tree.insert(6, "a6")
    tree.insert(12, "a12")
    tree.insert(11, "a11")
    tree.insert(13, "a13")
    return tree
}

func RRBalance() -> AVLTree<Int, String> {
    let tree = AVLTree<Int, String>()
    tree.insert(10, "a10")
    tree.insert(6, "a6")
    tree.insert(11, "a11")
    tree.insert(12, "a12")
    tree.insert(13, "a13")
    return tree
}

func RLBalance() -> AVLTree<Int, String> {
    let tree = AVLTree<Int, String>()
    tree.insert(10, "a10")
    tree.insert(6, "a6")
    tree.insert(12, "a12")
    tree.insert(13, "a13")
    tree.insert(11, "a11")
    return tree
}

func traverse(_ tree: AVLTree<Int, String>) {
    tree.traverseInOrder { (node) in
        print("key(\(node.key)), value(\(node.value!))")
        if node.key == 12 {
            print(node.left?.value, node.right?.value)
        }
    }
}

print("LLRotation:")
traverse(LLBalance())
print("\nLRRotation:")
traverse(LRBalance())
print("\nRRRotation:")
traverse(RRBalance())
print("\nRLRotation:")
traverse(RLBalance())
