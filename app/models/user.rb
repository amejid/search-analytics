class User < ApplicationRecord
  validates :ip_address, presence: true, uniqueness: true

  has_many :searches
end
