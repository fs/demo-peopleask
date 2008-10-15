begin
    require 'vlad'

    Vlad.load(
	:scm    => :git,
        :web    => nil
    )
rescue LoadError    
end
