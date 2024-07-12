class EnumQuestionType < ActiveRecord::Migration[7.1]
  def change
    change_column :questions, :question_type, :string, default: "texto", null: false
  end
end
