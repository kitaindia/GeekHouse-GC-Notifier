class Tweet < ActiveRecord::Base
  attr_accessible :cron_week, :cron_number_week, :message, :user_id
  belongs_to :user
  default_scope order: 'cron_week, cron_number_week'

  validates_length_of :message, maximum: 140
  validate :cron_week,        numericality: {greater_than_or_equal_to: 0,
                                              less_than_or_equal_to: 6}
  validate :cron_number_week, numericality: {greater_than_or_equal_to: 1,
                                              less_than_or_equal_to: 4}
end
