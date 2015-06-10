current_dir = File.dirname(__FILE__)
user = ENV['OPSCODE_USER'] || ENV['USER']
node_name                user
client_key               "#{ENV['CHEF_CLIENT_KEY']}"
validation_client_name   "#{ENV['CHEF_VALIDATOR_CLIENT']}"
validation_key           "#{ENV['CHEF_VALIDATOR_KEY']}"
chef_server_url          "#{ENV['CHEF_SERVER']}"
syntax_check_cache_path  "#{ENV['HOME']}/.chef/syntax_check_cache"
cookbook_path            ["#{current_dir}/../cookbooks"]
ssl_verify_mode :verify_none
