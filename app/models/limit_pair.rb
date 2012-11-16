class LimitPair < ActiveRecord::Base
  attr_accessible :first_value_id, :matrix_config_id, :second_value_id
  belongs_to :matrix_config
  belongs_to :value
  
  validate :pair_is_unique

  def pair_is_unique
	if LimitPair.find(:first, :conditions =>['matrix_config_id= ? and first_value_id = ? and second_value_id = ? ', matrix_config,first_value_id, second_value_id])
		errors.add(:matrix_config_id,"The limit pair has already been added to the matrix.")
	end
  end

end
