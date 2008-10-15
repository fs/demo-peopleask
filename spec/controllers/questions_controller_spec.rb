require File.dirname(__FILE__) + '/../spec_helper'

describe QuestionsController do
    describe "handling GET /questions" do

        before(:each) do
            @question = mock_model(Question)
            Question.stub!(:find).and_return([@question])
        end
  
        def do_get
            get :index
        end
  
        it "should be successful" do
            do_get
            response.should be_success
        end

        it "should render index template" do
            do_get
            response.should render_template('index')
        end
  
        it "should find all questions" do
            Question.should_receive(:find).with(:all).and_return([@question])
            do_get
        end
  
        it "should assign the found questions for the view" do
            do_get
            assigns[:questions].should == [@question]
        end
    end
end