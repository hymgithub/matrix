class Result < ActiveRecord::Base
  attr_accessible :is_chose, :matrix_params_id, :sort_id, :value_id, :tag
  belongs_to :matrix_param
  belongs_to :matrix_config
end
