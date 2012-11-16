class GroupValue < ActiveRecord::Base
  attr_accessible :group_id, :status, :value_id
  belongs_to :group
  belongs_to :value
end
