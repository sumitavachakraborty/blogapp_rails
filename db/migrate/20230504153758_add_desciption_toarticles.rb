class AddDesciptionToarticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :name, :string
    add_column :articles, :description, :text
  end
end
