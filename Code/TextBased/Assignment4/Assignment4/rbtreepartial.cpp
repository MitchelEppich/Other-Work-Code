// File:        rbtreepartial.cpp
// Author:      Geoffrey Tien
// Date:        2016-02-27
// Description: Contains implementation of some RedBlackTree functions.
//              This file does not require modification.

#ifdef _REDBLACKTREE_H_

// performs BST insertion and returns pointer to inserted node
// Note that this should only be called if item does not already exist in the tree
// Does not increase tree size.
template <class T>
Node<T>* RedBlackTree<T>::BSTInsert(T item)
{
  Node<T>* refnode; // will be pointer to parent of inserted node
  Node<T>* newnode; // will be pointer to inserted node
  // special case: empty tree
  if (size <= 0)
  {
    root = new Node<T>(item);
    newnode = root;
  }
  else // general case: non-empty tree
  {
    refnode = root;
    // find the insertion location
    while ((item < refnode->data && refnode->left != NULL) || (item > refnode->data && refnode->right != NULL))
    {
      if (item < refnode->data)
        refnode = refnode->left;
      else if (item > refnode->data)
        refnode = refnode->right;
    }
    // exited while loop, refnode points to the parent of the insertion location and has a null location to insert
    newnode = new Node<T>(item);
    newnode->p = refnode;
    if (item < refnode->data)
      refnode->left = newnode;
    else
      refnode->right = newnode;
  }

  return newnode;
}

// Returns existence of item in the tree.
// Return true if found, false otherwise.
template <class T>
bool RedBlackTree<T>::Search(T item) const
{
  Node<T>* node = root;

  while (node != NULL)
  {
    if (item == node->data)
      return true;
    else if (item < node->data)
      node = node->left;
    else
      node = node->right;
  }
  // if exit while loop, item is not found
  return false;
}

// Searches for item and returns a pointer to the node contents so the
//   value may be accessed or modified within the tree
// Use with caution! Do not modify the item's key value such that the
//   red-black /BST properties are violated.
template <class T>
T* RedBlackTree<T>::Retrieve(T item)
{
  T* value = NULL;

  // search for the item
  Node<T>* node = root;

  while (node != NULL)
  {
    if (item == node->data)
    {
      value = &(node->data);
      break; // item has been found, exit while loop
    }
    else if (item < node->data)
      node = node->left;
    else
      node = node->right;
  }
  // if exit while loop without breaking, item is not found
  return value;
}

// helper function for in-order traversal
template <class T>
void RedBlackTree<T>::InOrder(const Node<T>* node, T* arr, int arrsize, int& index) const
{
  if (node != NULL)
  {
    // recurse on left child
    if (node->left != NULL)
      InOrder(node->left, arr, arrsize, index);

    // visit current node
    arr[index] = node->data;
    index++;

    // recurse on right child
    if (node->right != NULL)
      InOrder(node->right, arr, arrsize, index);
  }
}

// rotation functions
// These functions are tested and working.
// If you experience a crash in these functions, most likely some child/parent pointers
// in your tree are broken due to incorrect insertion/removal logic
template <class T>
void RedBlackTree<T>::LeftRotate(Node<T>* node)
{
  if (node != NULL)
  {
    // if root
    if (node == root)
    {
      // case: no right child (no child or left child only)
      if (node->right == NULL)
      {
        // do nothing, do not allow the rotation
      }
      else
      {
        Node<T>* rc = node->right; // right child
        Node<T>* rclc = node->right->left; // right child's left child
        rc->p = NULL;
        rc->left = node;
        node->p = rc;
        node->right = rclc;
        if (rclc != NULL)
          rclc->p = node;

        root = rc;
      }
    }
    // if elsewhere
    else
    {
      // case: no right child (no child or left child only)
      if (node->right == NULL)
      {
        // do nothing, do not allow the rotation
      }
      else
      {
        Node<T>* parent = node->p; // parent
        Node<T>* rc = node->right; // right child
        Node<T>* rclc = node->right->left; // right child's left child

        if (node == node->p->left)
          node->p->left = rc;
        else
          node->p->right = rc;

        rc->p = parent;
        rc->left = node;
        node->p = rc;
        node->right = rclc;
        if (rclc != NULL)
          rclc->p = node;
      }
    }
  }
}

template <class T>
void RedBlackTree<T>::RightRotate(Node<T>* node)
{
  if (node != NULL)
  {
    // if root
    if (node == root)
    {
      // case: no left child (no child or right child only)
      if (node->left == NULL)
      {
        // do nothing, do not allow the rotation
      }
      else
      {
        Node<T>* lc = node->left; // left child
        Node<T>* lcrc = node->left->right; // left child's right child
        lc->p = NULL;
        lc->right = node;
        node->p = lc;
        node->left = lcrc;
        if (lcrc != NULL)
          lcrc->p = node;

        root = lc;
      }
    }
    // if elsewhere
    else
    {
      // case: no left child (no child or right child only)
      if (node->left == NULL)
      {
        // do nothing, do not allow the rotation
      }
      else
      {
        Node<T>* parent = node->p; // parent
        Node<T>* lc = node->left; // left child
        Node<T>* lcrc = node->left->right; // left child's right child

        if (node == node->p->left)
          node->p->left = lc;
        else
          node->p->right = lc;

        lc->p = parent;
        lc->right = node;
        node->p = lc;
        node->left = lcrc;
        if (lcrc != NULL)
          lcrc->p = node;
      }
    }
  }
}

// get the predecessor of a node
template <class T>
Node<T>* RedBlackTree<T>::Predecessor(Node<T>* node)
{
  Node<T>* pre = NULL;
  // do not allow operation on a null node
  if (node != NULL)
  {
    // case: node has no left child
    if (node->left == NULL)
      pre = NULL;
    else
    {
      // go left once, then follow right pointers until no more right pointers found
      pre = node->left;
      while (pre->right != NULL)
      {
        pre = pre->right;
      }
      //while loop exited, pre contains the predecessor or NULL
    }
  }
  return pre;
}

// performs an in-order traversal of the tree
// arrsize is the size of the returned array (equal to tree size attribute)
template <class T>
T* RedBlackTree<T>::Dump(int& arrsize) const
{
  int index = 0;
  arrsize = size;
  T* contents = new T[size];
  InOrder(this->root, contents, size, index);

  return contents;
}

#endif