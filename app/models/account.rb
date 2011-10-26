class Account < ActiveRecord::Base
  has_many :users
  validates_presence_of :name
  validates :name, :uniqueness => true

  def to_s
    name
  end
end
