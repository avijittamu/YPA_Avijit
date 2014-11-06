class AddColumnNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :volunteer, :text
  end
end
