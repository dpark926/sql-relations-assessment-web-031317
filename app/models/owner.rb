class Owner
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
  }

  # restaurant ATTRIBUTES = {
  #   id: "INTEGER PRIMARY KEY",
  #   name: "TEXT",
  #   location: "TEXT",
  #   owner_id: "INTEGER"
  # }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def restaurants
    # returns all restaurants belonging to that owner
    sql = <<-SQL
    SELECT * FROM owners
    INNER JOIN restaurants
    ON owner_id = restaurant.owner_id
    WHERE id = ?
    SQL
    self.class.db.execute(sql, self.owner_id)
  end
end
