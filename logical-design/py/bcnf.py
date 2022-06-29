# Counts the number of steps required to decompose a relation into BCNF.

from relation import *
from functional_dependency import *

# You should implement the static function declared
# in the ImplementMe class and submit this (and only this!) file.
# You are welcome to add supporting classes and methods in this file.
class ImplementMe:

  # Returns the number of recursive steps required for BCNF decomposition
  #
  # The input is a set of relations and a set of functional dependencies.
  # The relations have *already* been decomposed.
  # This function determines how many recursive steps were required for that
  # decomposition or -1 if the relations are not a correct decomposition.
  @staticmethod
  def DecompositionSteps( relations, fds ):
    
    # Check if for prime keys are split
    if (ImplementMe.hasPrime(relations, fds)) and (len(relations.relations) > 1):
      return -1

    # Check for lossless
    if not ImplementMe.isLossless(relations, fds):
      return -1

    # Calculate Fds for each relation
    relation_fds_list = []
    for relation in relations.relations:
      fds_for_relation = ImplementMe.calculateRelationFds(relation, fds)

      if fds_for_relation.functional_dependencies != set():
        relation_fds_list.append([relation, fds_for_relation])

    # Check closure for each attribute
    for relation_fds in relation_fds_list:
      relation = relation_fds[0]
      fds_for_relation = relation_fds[1]

      for fd in fds_for_relation.functional_dependencies:
        if (ImplementMe.calculateClosure(fd.left_hand_side, fds_for_relation)) != relation.attributes:
          return -1

    return len(relations.relations) - 1


  # Calculates closure of attribute set from fds
  def calculateClosure(attributes: set, fds: FDSet) -> set:
    closure = set()
    closure = closure.union(attributes)
    
    len_closure_bef = 0
    len_closure_aft = len(closure)
    while len_closure_bef != len_closure_aft:
      len_closure_bef = len_closure_aft

      for fd in fds.functional_dependencies:
        if fd.left_hand_side.issubset(closure):
          closure = closure.union(fd.right_hand_side)

      len_closure_aft = len(closure)

    # print("Closure of: "+str(attributes)+" is "+str(closure))
    return closure


  def calculateRelationFds(relation: Relation, all_fds: FDSet) -> FDSet:
    relation_fds = set()

    for fd in all_fds.functional_dependencies:
      if (fd.left_hand_side.union(fd.right_hand_side)).issubset(relation.attributes):
        relation_fds.add(fd)
    
    return FDSet(relation_fds)


  def isLossless(relations: RelationSet, fds: FDSet) -> boolean:
    for relation in relations.relations:
      false_cnt = 0
      for fd in fds.functional_dependencies:         
        if (fd.left_hand_side.intersection(relation.attributes) == set()) and (fd.right_hand_side.intersection(relation.attributes) == set()):
          false_cnt = false_cnt+1
      if false_cnt == len(fds.functional_dependencies):
        return False
    return True
    
  # Checks if orginal relation is in bcnf  
  def hasPrime(relations: RelationSet, fds: FDSet) -> boolean:
    org_relation = set()

    for relation in relations.relations:
      org_relation = org_relation.union(relation.attributes)
    
    for fd in fds.functional_dependencies:
      if(ImplementMe.calculateClosure(fd.left_hand_side, fds) != org_relation):
        return False

    return True
