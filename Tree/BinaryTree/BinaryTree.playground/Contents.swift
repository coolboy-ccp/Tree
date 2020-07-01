import UIKit

func createTree() -> BinaryTree<String> {
    let nodeD = BinaryTree.node(.empty, "D", .empty)
    let nodeE = BinaryTree.node(.empty, "E", .empty)
    let nodeF = BinaryTree.node(.empty, "F", .empty)
    let nodeG = BinaryTree.node(.empty, "G", .empty)

    let nodeB = BinaryTree.node(nodeD, "B", nodeE)
    let nodeC = BinaryTree.node(nodeF, "C", nodeG)

    return BinaryTree.node(nodeB, "A", nodeC)
}


let tree = createTree()


func inOrderTravel() {
    print(#function)
    tree.traverseInOrder {
        print($0)
    }
}

func preOrderTravel() {
    print(#function)
    tree.traversePreOrder {
        print($0)
    }
}

func postOrderTravel() {
    print(#function)
    tree.traversePostOrder {
        print($0)
    }
}

func levelOrderTravel() {
    print(#function)
    tree.traverseLevelOrder {
        print($0)
    }
}

levelOrderTravel()

//inOrderTravel()
//preOrderTravel()
//postOrderTravel()

