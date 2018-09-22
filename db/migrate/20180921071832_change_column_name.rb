class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    change_column :links, :url, :text
  end
end
