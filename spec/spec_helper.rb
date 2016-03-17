$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "neo4j/rspec"
require "neo4j"
require "pry"

Dir[File.join(File.dirname(__FILE__), "nodes", "*.rb")].each { |file| require file }

module Neo4jHelpers
  def server_username
    ENV['NEO4J_USERNAME'] || 'neo4j'
  end

  def server_password
    ENV['NEO4J_PASSWORD'] || 'password'
  end

  def basic_auth_hash
    {
      username: server_username,
      password: server_password
    }
  end

  def server_url
    ENV['NEO4J_URL'] || 'http://localhost:7474'
  end

  def create_server_session(options = {})
    Neo4j::Session.open(:server_db, server_url, { basic_auth: basic_auth_hash }.merge(options))
  end
end


RSpec.configure do |config|
  include Neo4jHelpers

  config.include Neo4j::RSpec::Matchers

  config.before(:suite) do
    Neo4j::Session.current.close if Neo4j::Session.current
    create_server_session
  end
end
