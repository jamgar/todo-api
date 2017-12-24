class RenameTitleInCardsTable < ActiveRecord::Migration[5.1]
  def change
    rename_column :cards, :title, :content
  end
end
