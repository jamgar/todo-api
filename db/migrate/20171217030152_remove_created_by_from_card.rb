class RemoveCreatedByFromCard < ActiveRecord::Migration[5.1]
  def change
    remove_column :cards, :created_by, :string
    add_column :cards, :board_id, :integer
  end
end
