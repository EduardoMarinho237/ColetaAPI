class AddAttachmentContentToAnswers < ActiveRecord::Migration[7.1]
  def change
    change_table :answers do |t|
      t.string :content_image_file_name
      t.string :content_image_content_type
      t.integer :content_image_file_size 
      t.datetime :content_image_updated_at
    end
  end
end
