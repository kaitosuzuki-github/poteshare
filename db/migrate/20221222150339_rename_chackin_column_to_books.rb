class RenameChackinColumnToBooks < ActiveRecord::Migration[6.1]
  def change
    rename_column :books, :chack_in, :check_in
  end
end
