class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.text :body
      t.text :code
      t.timestamps
    end
  end
end
