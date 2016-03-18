class Contains
  include Neo4j::ActiveRel

  from_class :Post
  to_class :Comment
  type "contains"
end
