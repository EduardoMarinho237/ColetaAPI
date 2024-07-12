class EnumVisitStatus < ActiveRecord::Migration[7.1]
  def change
    change_column :visits, :status, :string, default: "pendente", null: false
  end
end
