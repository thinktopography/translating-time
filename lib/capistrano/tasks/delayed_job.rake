namespace :delayed_job do

  task :restart do
    command  = "cd #{current_path};"
    command += "RAILS_ENV=production bin/delayed_job restart"
    run(command)
  end

end