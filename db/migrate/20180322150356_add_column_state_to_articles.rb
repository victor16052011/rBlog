class AddColumnStateToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :state, :string, default: "en_borrador"
  end
end
