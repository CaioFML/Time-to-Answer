class Site::SearchController < SiteController
  def questions
    @questions = Question.includes(:answers)
  end
end
