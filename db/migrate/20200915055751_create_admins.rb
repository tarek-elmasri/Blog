class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :search_by
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
