require 'net/http'
require 'timeout'

class Question < ActiveRecord::BaseWithoutTable
    
    column :question, :string
    
    GOOGLE_COMPLETE_URL = 'http://www.google.com/complete/search?hl=ru&xml=true&qu=%s'
    
    class << self
        
        private
        
        def default_questions
            @default_questions ||= YAML.load_config(RAILS_ROOT + "/db/yml/config/questions.yml")
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
                
                    results = xml['toplevel']['CompleteSuggestion']
                    results = [results] unless results.is_a?(Array)
                end
            end
                    
            return results
        end
    rescue Timeout::Error
        return []
    end

    
end
