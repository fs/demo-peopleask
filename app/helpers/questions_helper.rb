module QuestionsHelper
  def link_to_question(question, *args)
    link_to_function(question, *args) do |page|
      page['question_question'].value = question
      page['question_submit'].click()
    end
  end
end
