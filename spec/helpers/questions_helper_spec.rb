require File.dirname(__FILE__) + '/../spec_helper'

describe QuestionsHelper do
    include QuestionsHelper
  
    describe "#link_to_question" do
        it "should render link_to_function" do
            should_receive(:link_to_function).with('test')
            link_to_question('test')
        end
    end
end
