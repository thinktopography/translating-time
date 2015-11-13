namespace :sync do
  
  task :default do
    invoke 'sync:dump_database'
    invoke 'sync:download_database'
    invoke 'sync:populate_database'
  end
  
  task :dump_database do
    on roles(:db) do
      db = YAML.load_file("#{File.dirname(__FILE__)}/../../../config/database.yml")['production']
      command  = "/usr/bin/mysqldump -u #{db['username']} -p#{db['password']} -h #{db['host']} #{db['database']} > #{deploy_to}/database.sql;" 
      command += "cd #{deploy_to};"
      command += "tar -czf database.tgz database.sql;"
      command += "rm -rf database.sql;"
      execute(command)
    end
  end
  
  task :download_database do
    on roles(:db) do
      download!  "#{deploy_to}/database.tgz", "./tmp/database.tgz"
    end
  end

  task :populate_database do
    on roles(:db) do
      db = YAML.load_file("#{File.dirname(__FILE__)}/../../../config/database.yml")['development']
      system("tar -xzf ./tmp/database.tgz -C ./tmp")
      system("cat ./tmp/database.sql | mysql -u #{db['username']} -h #{db['host']} #{db['database']}")
      system("rm -rf ./tmp/*") 
    end
  end

end

task :sync => "sync:default"