class AddPublishedTo<%= @model.singularize %> < ActiveRecord::Migration
  def change
    add_column :<%= @model.tableize %>, :published, :boolean, :default => false
    #published_at
  end
end