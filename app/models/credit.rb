class Credit < ActiveRecord::Base
	belongs_to :user
	attr_accessible :card_type, :ccv, :number, :expiration


	validates :card_type, :presence => true, :inclusion => { :in => [1,2,3] }, :numericality => { :only_integer => true }
	validates :number, :presence => true, :numericality => { :only_integer => true }, :length => { :is => 16, :wrong_length => "Credit card number must have 16 digits"}
	validates :ccv, :presence => true, :length => { :is => 3, :wrong_length => "CCV number must have 3 digits"}
	validates :expiration, :presence => true


	validate :expiration_date_cannot_be_in_the_past
 
  def expiration_date_cannot_be_in_the_past
    if !expiration.blank? and expiration < Date.today
      errors.add(:expiration, "Can't be in the past")
    end
  end
end


##
#class Person < ActiveRecord::Base
#  validates_with GoodnessValidator
#end
# 
#class GoodnessValidator < ActiveModel::Validator
#  def validate(record)
#    if record.first_name == "Evil"
#      record.errors[:base] << "This person is evil"
#    end
#  end
#end
#
