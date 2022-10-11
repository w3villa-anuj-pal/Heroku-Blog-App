class Blog < ApplicationRecord
    belongs_to :user
    belongs_to :category
    validates :title, presence: true , length: { in: 2..40} , 
                      uniqueness: {case_sensitive: false}
     validates :description, presence: true , length:  {minimum: 10}
end
