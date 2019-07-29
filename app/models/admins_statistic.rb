class AdminsStatistic < ApplicationRecord
  EVENTS = {
    total_users: "TOTAL_USERS",
    total_questions: "TOTAL_QUESTIONS"
  }

  # Scopes

  scope :total_users, lambda {
    find_by_event(AdminsStatistic::EVENTS[:total_users]).value
  }

  scope :total_questions, lambda {
    find_by_event(AdminsStatistic::EVENTS[:total_questions]).value
  }

  # Class Methods

  def self.increment_event(event)
    admin_statistic = AdminsStatistic.find_or_create_by(event: event)
    admin_statistic.value += 1
    admin_statistic.save
  end
end
