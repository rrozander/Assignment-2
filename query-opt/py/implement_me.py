# Implementation of B+-tree functionality.

from index import *
import math

# You should implement all of the static functions declared
# in the ImplementMe class and submit this (and only this!) file.
class ImplementMe:

  # Returns a B+-tree obtained by inserting a key into a pre-existing
  # B+-tree index if the key is not already there. If it already exists,
  # the return value is equivalent to the original, input tree.
  #
  # Complexity: Guaranteed to be asymptotically linear in the height of the tree
  # Because the tree is balanced, it is also asymptotically logarithmic in the
  # number of keys that already exist in the index.
  @staticmethod
  def InsertIntoIndex( index, key ):
    # Return original tree if already exists
    if (ImplementMe.LookupKeyInIndex(index, key)):
      return index

    # Find where to insert key
    cur_node = ImplementMe.findNode(index.root, key)
    
    # Insert into leaf
    if ImplementMe.isNodeFull(cur_node):
      # Overflow 
      root = ImplementMe.splitNode(index.root, cur_node, key)   
      newbtree = Index(root=root)
      return newbtree

    else:
      # No Overflow
      for idx, ele in enumerate(cur_node.keys.keys):
        if ele == None:
          cur_node.keys.keys[idx] = key
          break
      cur_node.keys.keys = ImplementMe.sortNode(cur_node.keys.keys)
    
    return index


  # Returns a boolean that indicates whether a given key
  # is found among the leaves of a B+-tree index.
  #
  # Complexity: Guaranteed not to touch more nodes than the
  # height of the tree
  @staticmethod
  def LookupKeyInIndex( index, key ):
    node = ImplementMe.findNode(index.root, key)
    if node.keys.keys.count(key) == 0:
      return False
    return True


  # Returns a list of keys in a B+-tree index within the half-open
  # interval [lower_bound, upper_bound)
  #
  # Complexity: Guaranteed not to touch more nodes than the height
  # of the tree and the number of leaves overlapping the interval.
  @staticmethod
  def RangeSearchInIndex( index, lower_bound, upper_bound ):
    return []


  # Helper Functions:
  def isLeafNode( node ):
    if (node.pointers.pointers[0] is None):
      return True
    return False


  def isNodeFull( node ):
    if (node.keys.keys.count(None) == 0):
      return True
    return False
  

  def sortNode(list):
    return sorted(list, key=lambda x: (x is None, x))


  def newRoot(lc, rc):
    return Node(keys=KeySet([rc.keys.keys[0], None]), pointers=PointerSet([lc, rc, None]))


  def getParent(root, child):
    parent = None
    return parent


  # returns node that key should be added to or key is inside.
  def findNode(root, key):
    cur_node = root 
    while( ImplementMe.isLeafNode(cur_node) == False):
      for idx, ele in enumerate(cur_node.keys.keys):
        if (ele == None or ele > key):
          cur_node = cur_node.pointers.pointers[idx]
          break           
        else:
          if(idx == cur_node.get_num_keys()-1):
            cur_node = cur_node.pointers.pointers[idx+1]
            break
    return cur_node


  def internalSplit(root, node, key):
    return root 


  # Splits node and returns updated tree. Works for all overflow cases
  def splitNode(root, node, key):
    # Splits keys into current and new node
    temp_list = node.keys.keys.copy()
    temp_list.append(key)        
    temp_list = ImplementMe.sortNode(temp_list)

    split_idx = math.ceil(Index.NUM_KEYS/2)-1
    new_idx = 0
    
    new_node = Node()
        
    for idx, ele in enumerate(temp_list):
      if idx <= split_idx:
        node.keys.keys[idx] = ele
      else:
        new_node.keys.keys[new_idx] = ele
        new_idx = new_idx + 1
    
    for idx in range(split_idx+1,Index.NUM_KEYS):
      node.keys.keys[idx] = None

    node.pointers.pointers[Index.FAN_OUT-1] = new_node

    # Move key up tree
    if( node == root):
      new_root = ImplementMe.newRoot(node, new_node)
    else:
      new_root = ImplementMe.internalSplit(root, ImplementMe.getParent(root, node), new_node.keys.keys[0])
    
    return new_root
  

