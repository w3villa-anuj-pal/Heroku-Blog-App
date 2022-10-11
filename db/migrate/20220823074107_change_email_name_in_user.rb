class ChangeEmailNameInUser < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :Email, :email
  end
end
