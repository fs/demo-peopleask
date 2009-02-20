require 'digest/md5'

class QuestionsController < ApplicationController
  
  before_filter :build_question, :only => [:index, :create]
  
  caches_page :index
  caches_action :create, :cache_path => Proc.new { |c| c.send(:cache_path) }
  
  private
  
  def build_question
    @question = Question.new(params[:question])
  end
  
  def cache_path
    { :question => params[:question][:question] }
  end    
  
  public
  
  # GET /questions
  def index
    @question.question = Question.find(:random)
    @questions = Question.find(:all)
  end
  
  
  # GET /questions.js
  def create
    @results = @question.results!
    
    render :update do |page|
      page.replace_html :suggest, render(:partial => 'suggest')
    end
  end
end