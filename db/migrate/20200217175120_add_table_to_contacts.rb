class AddTableToContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|

      t.timestamps
    end
  end
end
