class Person
  include Neo4j::ActiveNode
  has_many :in, :posts, origin: :author
  has_many :in, :comments, origin: :author
  has_many :in, :written_things, type: false, model_class: [:Post, :Comment]

  property :nickname, index: :exact
  property :reserved
  index :reserved
end
