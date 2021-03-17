class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :title, null: false
      t.string :image_id, null: true
      t.text :body, null: false
      t.integer :user_id
      t.boolean :solution, default: false
      t.references :category

      t.timestamps
    end
  end
end
