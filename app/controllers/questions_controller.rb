require 'digest/md5'

class QuestionsController < ApplicationController
  caches_page :index
  caches_action :create, :cache_path => Proc.new { |c| c.send(:cache_path) }
  
  private
  
  def cache_path
    { :question => params[:question][:question] }
  end    
  
  public
  
  # GET /questions
  def index
    @question = Question.new(:question => params[:question] || Question.find(:random))
    @questions = Question.find(:all)
  end
  
  # POST /questions.js
  def create
    @question = Question.new(:question => params[:question][:question])
    @results = @question.results!
    
    render :update do |page|
      page.replace_html :suggest, render(:partial => 'suggest')
    end
  end
end