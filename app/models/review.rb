class Review
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    customer_id: "INTEGER",
    restaurant_id: "INTEGER"
  }

  # customer ATTRIBUTES = {
  #   id: "INTEGER PRIMARY KEY",
  #   name: "TEXT",
  #   birth_year: "INTEGER",
  #   hometown: "TEXT"
  # }

  # restaurant ATTRIBUTES = {
  #   id: "INTEGER PRIMARY KEY",
  #   name: "TEXT",
  #   location: "TEXT",
  #   owner_id: "INTEGER"
  # }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def customer
    # returns the customer of that review
    sql = <<-SQL
    SELECT * FROM customers
    INNER JOIN reviews
    ON customer.id = customer_id
    WHERE id = ?
    SQL
    self.class.db.execute(sql, self.customer_id)
  end

  def restaurant
    # returns the restaurant of that particular review
    sql = <<-SQL
    SELECT * FROM restaurants
    INNER JOIN reviews
    ON restaurant.id = restaurant_id
    WHERE id = ?
    SQL
    self.class.db.execute(sql, self.restaurant_id)
  end

end
