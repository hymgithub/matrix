class MatrixParam < ActiveRecord::Base
  attr_accessible :matrix_config_id, :parameter_id, :status
  belongs_to :matrix_config
  belongs_to :parameter
  has_many :matrix_values
  has_many :results
  validates_uniqueness_of :parameter_id, :scope => "matrix_config_id", :message =>"The parameter has already been in the matrix."
end
