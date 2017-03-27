class Restaurant
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    location: "TEXT",
    owner_id: "INTEGER"
  }

  # owner ATTRIBUTES = {
  #   id: "INTEGER PRIMARY KEY",
  #   name: "TEXT",
  # }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def owner
    # returns the owner of that restaurant
  end
end
