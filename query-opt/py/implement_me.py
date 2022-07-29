# Implementation of B+-tree functionality.

from index import *

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
      if (node.pointers.pointers[0] == None):
        return True
      return False

    def isNodeFull( node ):
      if (node.keys.keys.count(None) == 0):
        return True
      return False
    
    def sortNode(list):
      return sorted(list, key=lambda x: (x is None, x))

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