class Product < ApplicationRecord
    validates :name, :image, presence: true
end