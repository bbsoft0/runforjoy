# ssh configuration options. Make sure the following works: $ ssh <deploy_user>@<server_ip>
server '188.166.163.34', user: 'root', roles: %w{web app db}

# only if your app already has a domain, then add:
# set :nginx_server_name, 'mydomain.com'

config.serve_static_assets = true
config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'
config.assets.compile = true