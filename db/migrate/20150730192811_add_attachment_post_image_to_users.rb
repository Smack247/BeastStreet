class AddAttachmentPostImageToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :post
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :users, :post
    remove_attachment :users, :image
  end
end
