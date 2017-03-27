class Customer
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    birth_year: "INTEGER",
    hometown: "TEXT"
  }

  # review ATTRIBUTES = {
  #   id: "INTEGER PRIMARY KEY",
  #   customer_id: "INTEGER",
  #   restaurant_id: "INTEGER"
  # }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def reviews
    # returns all of the reviews written by that customer
    sql = <<-SQL
    SELECT * FROM reviews
    INNER JOIN customers
    ON customer_id = review.customer_id
    WHERE id = ?
    SQL
    self.class.db.execute(sql, self.customer_id)
  end

  def restaurants
    sql = <<-SQL
      SELECT restaurants.* FROM restaurants
      INNER JOIN reviews ON reviews.restaurant_id = restaurants.id
      WHERE reviews.customer_id = ?
    SQL
    self.class.db.execute(sql, self.id)
  end
end
