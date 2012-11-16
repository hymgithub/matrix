class GroupParameter < ActiveRecord::Base
  attr_accessible :group_id, :parameter_id, :status
  belongs_to :group
  belongs_to :parameter
  validates_uniqueness_of :parameter_id, :scope => "group_id"
end
