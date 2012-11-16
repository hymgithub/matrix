class User < ActiveRecord::Base
  attr_accessible :name, :password, :status
  has_many :groups ,:dependent=>:destroy
end
