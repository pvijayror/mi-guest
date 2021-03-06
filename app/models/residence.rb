class Residence < ActiveRecord::Base
  attr_accessible :address, :owner_name, :town

  validates_presence_of :address, :owner_name, :town

  def to_s
    "#{owner_name}, #{address} - #{town}"
  end
end
