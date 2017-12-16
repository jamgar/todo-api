class RemoveCreatedByFromBoards < ActiveRecord::Migration[5.1]
  def change
    remove_column :boards, :created_by, :string
  end
end
