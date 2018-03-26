#ifdef _REDBLACKTREE_H_

#include <iostream>    
#include <algorithm>

// recursive helper function for deep copy
// creates a new node based on sourcenode's contents, links back to parentnode,
//   and recurses to create left and right children
template <class T>
Node<T>* RedBlackTree<T>::CopyTree(Node<T>* sourcenode, Node<T>* parentnode)
{
	Node<T>* node = new Node<T>(sourcenode->data);
	node->p = parentnode;
	node->is_black = sourcenode->is_black;
	node->right = CopyTree(sourcenode->right, node);
	node->left = CopyTree(sourcenode->left, node);
	return node;
}

// recursive helper function for tree deletion
// deallocates nodes in post-order
template <class T>
void RedBlackTree<T>::RemoveAll(Node<T>* node)
{
	if (node == nullptr)
		return;

	// Check left
	RemoveAll(node->left);
	// Check right
	RemoveAll(node->right);
	// Check
	Remove(node->data);
}

// Tree fix, performed after removal of a black node
// Note that the parameter x may be NULL
template <class T>
void RedBlackTree<T>::RBDeleteFixUp(Node<T>* x, Node<T>* xparent, bool xisleftchild)
{
	Node<T>* s;
	while (xparent != root && xparent->is_black == true)
	{
		if (xparent->p->left == xparent)
		{
			s = xparent->p->right;
			if (s->is_black == false)
			{
				s->is_black = true;
				xparent->p->is_black = false;
				LeftRotate(xparent->p);
				s = xparent->p->right;
			}
			if (s->right->is_black == true && s->left->is_black == true)
			{
				s->is_black = false;
				xparent = xparent->p;
			}
			else
			{
				if (s->right->is_black == true)
				{
					s->left->is_black == true;
					s->is_black = false;
					RightRotate(s);
					s = xparent->p->right;
				}
				s->is_black = xparent->p->is_black;
				xparent->p->is_black = true;
				s->right->is_black = true;
				LeftRotate(xparent->p);
				xparent = root;
			}
		}
		else
		{
			s = xparent->p->left;
			if (s->is_black == false)
			{
				s->is_black = true;
				xparent->p->is_black = false;
				RightRotate(xparent->p);
				s = xparent->p->left;
			}
			if (s->left->is_black == true && s->right->is_black == true)
			{
				s->is_black = false;
				xparent = xparent->p;
			}
			else
			{
				if (s->left->is_black == true)
				{
					s->right->is_black = true;
					s->is_black = false;
					LeftRotate(s);
					s = xparent->p->left;
				}
				s->is_black = xparent->p->is_black;
				xparent->p->is_black = true;
				s->left->is_black = true;
				RightRotate(xparent->p);
				xparent = root;
			}
		}
		xparent->is_black = true;
		root->is_black = true;
	}
}

// Calculates the height of the tree
// Requires a traversal of the tree, O(n)
template <class T>
int RedBlackTree<T>::CalculateHeight(Node<T>* node) const
{
	int count = 0;

	if (node == nullptr)
		return 0;

	count = 1 + std::max(CalculateHeight(node->left), CalculateHeight(node->right));

	return count;
}

// default constructor
template <class T>
RedBlackTree<T>::RedBlackTree()
{
	root = nullptr;
	size = 0;
}

// copy constructor, performs deep copy of parameter
template <class T>
RedBlackTree<T>::RedBlackTree(const RedBlackTree<T>& rbtree)
{
	RedBlackTree<T> t = new RedBlackTree();
	t->root = CopyTree(rbtree->root, nullptr);
}

// destructor
// Must deallocate memory associated with all nodes in tree
template <class T>
RedBlackTree<T>::~RedBlackTree()
{
	RemoveAll();
	delete root;
}

// Calls BSTInsert and then performs any necessary tree fixing.
// If item already exists, do not insert and return false.
// Otherwise, insert, increment size, and return true.
template <class T>
bool RedBlackTree<T>::Insert(T item)
{
	// Check if item exists
	if (!Search(item))
	{
		Node<T>* p;
		Node<T>* q;
		Node<T>* t = new Node<T>(item);

		t->left = nullptr;
		t->right = nullptr;
		t->is_black = false;

		p = root;
		q = nullptr;

		if (p == nullptr)
		{
			root = t;
			t->p = nullptr;
		}
		else
		{
			while (p != nullptr)
			{
				q = p;
				if (p->data < t->data)
					p = p->right;
				else
					p = p->left;
			}
			t->p = q;
			if (q->data < t->data)
				q->right = t;
			else
				q->left = t;
		}
		size++;

		// Fix
		Node<T>* u;
		if (root == t)
		{
			t->is_black = true;
			return 1;
		}
		while (t->p != nullptr && t->p->is_black == false)
		{
			Node<T>* g = t->p->p;
			if (g->left == t->p)
			{
				if (g->right != nullptr)
				{
					u = g->right;
					if (u->is_black == false)
					{
						t->p->is_black = true;
						u->is_black = true;
						g->is_black = false;
						t = g;
					}
				}
				else
				{
					if (t->p->right == t)
					{
						t = t->p;
						LeftRotate(t);
					}
					t->p->is_black = true;
					g->is_black = false;
					RightRotate(g);
				}
			}
			else
			{
				if (g->left != nullptr)
				{
					u = g->left;
					if (u == nullptr) return 0;
					if (u->is_black == false)
					{
						t->p->is_black = true;
						u->is_black = true;
						g->is_black = false;
						t = g;
					}
				}
				else
				{
					if (t->p->left == t)
					{
						t = t->p;
						RightRotate(t);
					}
					t->p->is_black = true;
					g->is_black = false;
					LeftRotate(g);
				}
			}
			root->is_black = true;
		}
	}
}

// Removal of an item from the tree.
// Must deallocate deleted node after RBDeleteFixUp returns
template <class T>
bool RedBlackTree<T>::Remove(T item)
{
	if (root == nullptr)
		return 0;

	Node<T>* p;
	p = root;
	Node<T>* y = nullptr;
	Node<T>* q = nullptr;

	int found = 0;

	while (p != nullptr && found == 0)
	{
		if (p->data == item)
			found = 1;
		if (found == 0)
		{
			if (p->data < item)
				p = p->right;
			else
				p = p->left;
		}
	}
	if (found == 0)
	{
		return 0;
	}
	else
	{
		if (p->left == nullptr || p->right == nullptr)
			y = p;
		else
			y = Predecessor(p);
		if (y->left != nullptr)
			q = y->left;
		else
		{
			if (y->right != nullptr)
				q = y->right;
			else
				q = nullptr;
		}
		if (q != nullptr)
			q->p = y->p;
		if (y->p == nullptr)
			root = q;
		else
		{
			if (y == y->p->left)
				y->p->left = q;
			else
				y->p->right = q;
		}
		if (y != p)
		{
			p->is_black = y->is_black;
			p->data = y->data;
		}
		if (q == nullptr || y == nullptr || p == nullptr) return 0;
		if (y->is_black == true)
			RBDeleteFixUp(q, q->p, q == q->p->left ? true : false);
	}
}
//InOrder(const Node<T>* node, T* arr, int arrsize, int& index)
// deletes all nodes in the tree. Calls recursive helper function.
template <class T>
void RedBlackTree<T>::RemoveAll()
{
	RemoveAll(GetRoot());
}


// returns the number of items in the tree
template <class T>
int RedBlackTree<T>::Size() const
{
	return size;
}

// overloaded assignment operator
template <class T>
RedBlackTree<T>& RedBlackTree<T>::operator=(const RedBlackTree<T>& rbtree)
{
	return RedBlackTree(rbtree);
}

// returns the height of the tree, from root to deepest null child. Calls recursive helper function.
// Note that an empty tree should have a height of 0, and a tree with only one node will have a height of 1.
template <class T>
int RedBlackTree<T>::Height() const
{
	return CalculateHeight(GetRoot());
}

#endif