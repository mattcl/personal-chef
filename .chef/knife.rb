current_dir = File.dirname(__FILE__)
user = ENV['OPSCODE_USER'] || ENV['USER']
node_name                user
client_key               "#{ENV['HOME']}/.chef/#{user}.pem"
validation_client_name   "chef-validator"
validation_key           "#{ENV['HOME']}/.chef/chef-validator.pem"
chef_server_url          "#{ENV['CHEF_SERVER']}"
syntax_check_cache_path  "#{ENV['HOME']}/.chef/syntax_check_cache"
cookbook_path            ["#{current_dir}/../cookbooks"]
