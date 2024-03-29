class CreateComents < ActiveRecord::Migration[5.0]
  def change
    create_table :coments do |t|
      t.references :user, foreign_key: true
      t.references :article, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
