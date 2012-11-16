class Group < ActiveRecord::Base
  attr_accessible :name, :status, :user_id
  belongs_to :user
  has_many :matrix_configs ,:dependent=>:destroy
  has_many :group_parameters,:dependent=>:destroy
  has_many :group_values, :dependent=>:destroy
  #validates :name, :uniqueness => {:message => "The name has been used, please change another one!"}
  validates_uniqueness_of :name, :scope=>"user_id"
end
