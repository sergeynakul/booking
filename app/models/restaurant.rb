class Restaurant < ApplicationRecord
  has_many :tables, dependent: :destroy
end
