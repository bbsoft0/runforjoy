worker_processes Integer(ENV['WEB_CONCURRENCY'] || 3)
timeout Integer(ENV['WEB_TIMEOUT'] || 20)
preload_app true


# Set environment to development unless something else is specified
env = ENV["RAILS_ENV"] || "development"

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
listen "/tmp/unicorn.#{app_dir}.socket", :backlog => 64

# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.
working_directory "/root/runforjoy/#{app_dir}/current"

# feel free to point this anywhere accessible on the filesystem
shared_path = "/root/runforjoy/#{app_dir}/shared"

stderr_path "#{shared_path}/log/unicorn.stderr.log"
stdout_path "#{shared_path}/log/unicorn.stdout.log"

pid "#{shared_path}/tmp/pids/unicorn.pid"


before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end  

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
