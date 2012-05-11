p 'checking files'
# Dir[File.dirname(__FILE__) + './**/*.rb'].each{ |f| p f }
Dir['./../lib/**/*.rb'].each{ |file| p file }
