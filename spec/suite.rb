cwd = File.expand_path('../', __FILE__)
Dir["#{cwd}/**/*.rb"].each { |spec| require spec }
