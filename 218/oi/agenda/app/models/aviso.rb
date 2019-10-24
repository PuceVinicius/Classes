class Aviso < ApplicationRecord
  validates :body, presence: true, length: {maximum: 50} 
  validates :title, presence: true, length: {maximum: 20}
end
