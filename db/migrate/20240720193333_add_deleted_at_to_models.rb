class AddDeletedAtToModels < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at

    add_column :visits, :deleted_at, :datetime
    add_index :visits, :deleted_at

    add_column :formularies, :deleted_at, :datetime
    add_index :formularies, :deleted_at

    add_column :questions, :deleted_at, :datetime
    add_index :questions, :deleted_at

    add_column :answers, :deleted_at, :datetime
    add_index :answers, :deleted_at
  end
end
