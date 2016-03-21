class Post
  include Neo4j::ActiveNode

  property :title
  property :description, type: String
  property :published, type: Boolean
  property :custom_constraint, constraint: :unique
  include Neo4j::Timestamps

  has_many :in, :comments, origin: :post
  has_one :out, :author, type: :author, model_class: :Person
end
