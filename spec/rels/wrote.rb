class Wrote
  include Neo4j::ActiveRel

  from_class :Person
  to_class :any

  property :uid
end
