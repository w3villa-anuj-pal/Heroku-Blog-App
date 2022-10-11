class AddCategoryIdToBlogs < ActiveRecord::Migration[6.1]
  def change
    add_column :blogs, :category_id, :integer
  end
end
