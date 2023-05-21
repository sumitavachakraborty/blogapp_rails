class Article < ApplicationRecord
   belongs_to :user
   validates :name, presence: true, length: {minimum: 4, maximum: 100}
   validates :description, presence: true, length: {minimum: 4, maximum: 1000}
end