class Estimate < ActiveRecord::Base
#  attr_accessible :accuracy, :facebook_gay_friends, :facebook_male_friends, :gay_friends, :male_friends, :right_percentage
   validates   :facebook_gay_friends, :how_recruited,  presence: true, on: :update
   validates :percentage_upper, :percentage_lower, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, on: :update

    validates  :facebook_gay_friends, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, on: :update
end
