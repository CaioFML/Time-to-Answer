class Site::SearchController < SiteController
  def questions
    @questions = Question.includes(:answers)
                         .where('lower(description) LIKE ?', "%#{params[:term].downcase}%")
                         .page(params[:page])
                         .per(10)
  end
end
