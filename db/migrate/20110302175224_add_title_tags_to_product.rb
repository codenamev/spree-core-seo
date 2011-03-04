class AddTitleTagsToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :title_tag, :string
  end

  def self.down
    remove_column :products, :title_tag
  end
end
