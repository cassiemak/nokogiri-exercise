class Company < ActiveRecord::Base

  has_many :annualincomes
  has_many :products

end
