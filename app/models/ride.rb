class Ride < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :distance, :date
end
