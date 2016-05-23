class Profile
  include Neo4j::ActiveNode
  has_one :out, :person, type: :person
end
