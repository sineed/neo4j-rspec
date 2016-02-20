class Comment
  include Neo4j::ActiveNode
  has_one :out, :post, type: :post
  has_one :out, :author, type: :author, model_class: :Person
end
