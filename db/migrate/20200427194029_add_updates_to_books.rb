class AddUpdatesToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :lent, :string
    add_column :books, :isbn, :string
  end
end
