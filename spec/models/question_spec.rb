require File.dirname(__FILE__) + '/../spec_helper'

describe Question do
    def valid_attributes
        {
            :question => 'What',
        }
    end    
    
    before(:each) do
        @question = Question.new(valid_attributes)
    end
    
    describe ".find(:all) should" do
        
        before do
            @questions = Question.find(:all)
        end
    
        it "return array" do
            @questions.should be_a_kind_of(Array)
        end
        
        it "retrun array of questions" do
            @questions.first.should be_a_kind_of(Question)
        end
    
    end
    
    describe ".find(:random) should" do
        before do
            @question = Question.find(:random)
        end
        
        it "return random question" do
            @question.should be_a_kind_of(String)
        end
    end
    
    describe "#results should" do
        
        describe "not raise error" do
            it do
                lambda { Question.new(:question => '').results! }.should_not raise_error
            end
            
            it "with single russian word query" do
                lambda { Question.new(:question => 'тест').results! }.should_not raise_error
            end
            
            it "with russian phrase query" do
                lambda { Question.new(:question => 'тест драйв').results! }.should_not raise_error
            end
            
            it "with query without results" do
                lambda { Question.new(:question => 'тест123тест').results! }.should_not raise_error
            end
        end

        describe "return not empty array with" do
            it "pharase query" do
                Question.new(:question => 'test drive').results!.should_not be_blank
            end
            
            it "with single word query" do
                Question.new(:question => 'test').results!.should_not be_blank
            end
            
            it "with single russian word query" do
                lambda { Question.new(:question => 'тест').results! }.should_not be_blank
            end
            
            it "with russian phrase query" do
                lambda { Question.new(:question => 'тест драйв').results! }.should_not be_blank
            end
        end
        
        it "return empty array with empty query" do
            Question.new(:question => '').results!.should == []
        end
    end

end
