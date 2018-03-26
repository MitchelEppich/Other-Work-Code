// File:        redblacktree.h
// Author:      Geoffrey Tien
// Date:        2016-03-02
// Description: Declaration of a RedBlackTree class and template Node class for use with CMPT 225 assignment #4

#ifndef _REDBLACKTREE_H_
#define _REDBLACKTREE_H_

#include <cstdlib>
#include <stdexcept>
#include <string>
using namespace std;

template <class T>
class Node
{
  public:
    T data;
    Node<T>* left;
    Node<T>* right;
    Node<T>* p;     // parent pointer
    bool is_black;

    // parameterized constructor
    Node(T value)
    {
      data = value;
      left = NULL;
      right = NULL;
      p = NULL;
      is_black = false;
    }
};

template <class T>
class RedBlackTree
{
  private:
    Node<T>* root;
    int size;

    // recursive helper function for deep copy
    // creates a new node based on sourcenode's contents, links back to parentnode,
    //   and recurses to create left and right children
    Node<T>* CopyTree(Node<T>* sourcenode, Node<T>* parentnode);

    // recursive helper function for tree deletion
    // deallocates nodes in post-order
    void RemoveAll(Node<T>* node);

    // performs BST insertion and returns pointer to inserted node
    // Note that this should only be called if item does not already exist in the tree
    // Does not increase tree size.
    Node<T>* BSTInsert(T item);

    // helper function for in-order traversal
    void InOrder(const Node<T>* node, T* arr, int arrsize, int& index) const;

    // rotation functions
    void LeftRotate(Node<T>* node);
    void RightRotate(Node<T>* node);

    // get the predecessor of a node
    Node<T>* Predecessor(Node<T>* node);

    // Tree fix, performed after removal of a black node
    // Note that the parameter x may be NULL
    void RBDeleteFixUp(Node<T>* x, Node<T>* xparent, bool xisleftchild);

    // Calculates the height of the tree
    // Requires a traversal of the tree, O(n)
    int CalculateHeight(Node<T>* node) const;
  public:
    // default constructor
    RedBlackTree();

    // copy constructor, performs deep copy of parameter
    RedBlackTree(const RedBlackTree<T>& rbtree);

    // destructor
    // Must deallocate memory associated with all nodes in tree
    ~RedBlackTree();

    // overloaded assignment operator
    RedBlackTree<T>& operator=(const RedBlackTree<T>& rbtree);

    // Accessor functions

    // Calls BSTInsert and then performs any necessary tree fixing.
    // If item already exists, do not insert and return false.
    // Otherwise, insert, increment size, and return true.
    bool Insert(T item);

    // Removal of an item from the tree.
    // Must deallocate deleted node after RBDeleteFixUp returns
    bool Remove(T item);

    // Returns existence of item in the tree.
    // Return true if found, false otherwise.
    bool Search(T item) const;

    // Searches for item and returns a pointer to the node contents so the
    //   value may be accessed or modified
    // Use with caution! Do not modify the item's key value such that the
    //   red-black / BST properties are violated.
    T* Retrieve(T item);

    // deletes all nodes in the tree. Calls recursive helper function.
    void RemoveAll();

    // performs an in-order traversal of the tree
    // arrsize is the size of the returned array (equal to tree size attribute)
    T* Dump(int& arrsize) const;

    // returns the number of items in the tree
    int Size() const;

    // returns the height of the tree, from root to deepest null child. Calls recursive helper function.
    // Note that an empty tree should have a height of 0, and a tree with only one node will have a height of 1.
    int Height() const;

    // returns a pointer to the root of the tree
    // NOTE: This will be used only for grading.
    // Providing access to the tree internals is dangerous in practice!
    Node<T>* GetRoot() const
    {
      return this->root;
    }
};

// include functions completed by instructor
#include "rbtreepartial.cpp"
// include functions to be completed by yourself
#include "redblacktree.cpp"

#endif