require File.dirname(__FILE__) + '/../../spec_helper'

describe "/questions/index.html.erb" do
  include QuestionsHelper
    
  def do_render
    render "/questions/index.html.erb"
  end
    
  before do
    assigns[:question] = stub_question.as_new_record
        
    @question1 = stub_question
    @question2 = stub_question
    assigns[:questions] = [@question1, @question2]
  end
    
  it "should render question form" do
    do_render

    response.should have_tag("form[action=?][method=post]", formatted_questions_path(:js)) do
      with_tag("input#question_question[name=?]", 'question[question]')
      with_tag("input#question_submit[type=?]", 'submit')
    end
  end
    
  it "should have block for suggestion" do
    do_render
        
    response.should have_tag("div#suggest")
  end
    
  it "should render default questions" do
    do_render
        
    response.should have_text(Regexp.new(@question1.question))
    response.should have_text(Regexp.new(@question2.question))
  end
end

