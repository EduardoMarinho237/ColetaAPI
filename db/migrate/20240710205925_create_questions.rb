class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :name
      t.references :formulary, null: false, foreign_key: true
      t.string :question_type

      t.timestamps
    end
  end
end
