class Ride < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :length, :date
end
