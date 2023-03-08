class AddColumnToEmails < ActiveRecord::Migration[7.0]
  def change
    add_column :emails, :read, :boolean
  end
end
