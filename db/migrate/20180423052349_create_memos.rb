class CreateMemos < ActiveRecord::Migration[5.0]
  def change
    create_table :memos do |t|
      t.string :memotitle
      t.string :description
      t.references :list, foreign_key: true

      t.timestamps
    end
  end
end
