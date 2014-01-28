class Estimate < ActiveRecord::Base
#  attr_accessible :accuracy, :facebook_gay_friends, :facebook_male_friends, :gay_friends, :male_friends, :right_percentage
   validates   :facebook_gay_friends, :how_recruited, :accuracy, presence: true, on: :update
   validates :right_percentage, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 },if: "accuracy == 'High' || accuracy == 'Low'", on: :update


    validates  :facebook_gay_friends, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: :facebook_male_friends }, on: :update
end
