class AddOwnerToMessages < ActiveRecord::Migration
  def change
    add_column :notifications_messages, :owner_id, :integer
    add_column :notifications_messages, :owner_type, :string
  end
end
