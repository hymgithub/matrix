class MatrixConfig < ActiveRecord::Base
  attr_accessible :group_id, :name, :status, :version_id
  belongs_to :group
  has_many :matrix_params,:dependent => :destroy
  has_many :limit_pairs,:dependent=>:destroy
  has_many :results
  validates_uniqueness_of :name, :scope =>"group_id"
end
