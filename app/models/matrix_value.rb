class MatrixValue < ActiveRecord::Base
  attr_accessible :is_chosen, :matrix_param_id, :status, :value_id, :weight
  belongs_to :matrix_param
  belongs_to :value
  validates_uniqueness_of :value_id , :scope =>"matrix_param_id", :message =>"The value has already been chosen."
end
