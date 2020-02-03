class Event < ApplicationRecord
  belongs_to :course
  serialize :recurring, Hash

  def recurring=(value)
    if (value!="null")#RecurringSelect.is_valid_rule?(value)
      super(RecurringSelect.dirty_hash_to_rule(value).to_hash)
    else
      super(nil)
    end
  end
end
