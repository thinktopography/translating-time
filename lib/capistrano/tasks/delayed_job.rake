namespace :delayed_job do

  task :restart, :roles => :app do
    command  = "cd #{current_path};"
    command += "RAILS_ENV=production script/delayed_job restart"
    run(command)
  end

end