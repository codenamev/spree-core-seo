class AddTitleTagToTaxon < ActiveRecord::Migration
  def self.up
    add_column :taxons, :title_tag, :string
  end

  def self.down
    remove_column :taxons, :title_tag
  end
end
