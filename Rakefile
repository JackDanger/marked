begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "marked"
    gem.summary = %Q{Fast debugging for Ruby. Output any objects or blocks to both Rails log and console output simultaneously}
    gem.description = %Q{Quick Ruby debugger. Easily print any object or string to the console and to your logs while you're working.}
    gem.email = "rubygems@6brand.com"
    gem.homepage = "http://github.com/JackDanger/marked"
    gem.authors = ["Jack Danger Canty"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end



task :default => :test

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << '.'
  test.pattern = 'test/*_test.rb'
  test.verbose = true
end
