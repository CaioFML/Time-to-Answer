class AdminsBackoffice::WelcomeController < AdminsBackofficeController
  def index
    @total_users = AdminsStatistic.total_users
    @total_questions = AdminsStatistic.total_questions
  end
end
