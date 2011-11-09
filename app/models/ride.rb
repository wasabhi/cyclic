class Ride < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :distance, :date
  validate :favourite_rides_must_have_a_name

  def favourite_rides_must_have_a_name
    if favourite && name.blank?
      errors.add(:name, "A favourite ride must have a name")
    end
  end
end
