class AddCreatedByToBoard < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :created_by, :string
  end
end
