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

  def rule
    IceCube::Rule.from_hash recurring
  end

  def schedule(start)
    schedule = IceCube::Schedule.new(start)
    schedule.add_recurrence_rule(rule)

    #event_exceptions.each do |exception|
    #  schedule.add_exception_time(exception.time)
    #end

    schedule
  end
  
  def calendar_events(start)
    if recurring.empty?
      [self]
    else
      #start_date = start.beginning_of_month.beginning_of_week
      end_date = start.end_of_month.end_of_week
      schedule(start_time).occurrences(8).map do |date, index|
        Event.new(id: id, course_id: course_id, number: index, start_time: date)
      end
    end
  end
end
