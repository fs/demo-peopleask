require 'net/http'
require 'timeout'

class Question < ActiveRecord::BaseWithoutTable
    
  column :question, :string
    
  GOOGLE_COMPLETE_URL = 'http://www.google.com/complete/search?hl=ru&xml=true&qu=%s'
    
  class << self
        
    private
        
    def default_questions
      @default_questions ||= YAML.load(File.read(Rails.root + "/config/questions.yml"))
    end
        
    def find_all
      returning [] do |ret|
        default_questions.each { |q| ret << new(:question => q) }
      end
    end
        
    def find_first_random
      default_questions.rand
    end
        
    public
        
    def find(*args)
      case args.first
      when :all
        find_all
      when :random
        find_first_random
      else
        raise NotImplementedError if args != [:all]
      end
    end
  end
    
  public

  def results!
    results = []
        
    timeout(60) do
      response = Net::HTTP.get_response(URI.parse(GOOGLE_COMPLETE_URL % URI.escape(self.question.to_s)))
            
      if response.kind_of?(Net::HTTPSuccess)
        xml = Hash.from_xml(response.body)
                
        if  xml.include?('toplevel') &&
            !xml['toplevel'].blank? &&
            xml['toplevel'].include?('CompleteSuggestion')

          items = xml['toplevel']['CompleteSuggestion'].is_a?(Array) ?
            xml['toplevel']['CompleteSuggestion'] :
            [xml['toplevel']['CompleteSuggestion']]

          results = returning([]) do |values|
            items.each {|item| values << [item['suggestion']['data'], item['num_queries']['int'].to_i] }
          end.sort {|x,y| y[1] <=> x[1] }

          Rails.logger.debug(results.inspect)

          results
        end
      end
                    
      return results
    end
  rescue Timeout::Error
    return []
  end

    
end
