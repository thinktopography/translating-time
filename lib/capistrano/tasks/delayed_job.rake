namespace :delayed_job do

  task :restart do
    on roles :all do
      command  = "cd #{current_path};"
      command += "RAILS_ENV=production bin/delayed_job restart"
      execute(command)
    end
  end

end