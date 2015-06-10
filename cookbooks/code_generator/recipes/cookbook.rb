
context = ChefDK::Generator.context
cookbook_dir = File.join(context.cookbook_root, context.cookbook_name)

# cookbook root dir
directory cookbook_dir

# ruby version
cookbook_file "#{cookbook_dir}/.ruby-version" do
  source "ruby-version"
  action :create_if_missing
end

# metadata.rb
template "#{cookbook_dir}/metadata.rb" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# README
template "#{cookbook_dir}/README.md" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# chefignore
cookbook_file "#{cookbook_dir}/chefignore"

# Berks
cookbook_file "#{cookbook_dir}/Berksfile" do
  action :create_if_missing
end

# Gemfile
cookbook_file "#{cookbook_dir}/Gemfile" do
  action :create_if_missing
end

# TK & Serverspec
template "#{cookbook_dir}/.kitchen.yml" do
  source 'kitchen.yml.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

directory "#{cookbook_dir}/test/integration/default/serverspec" do
  recursive true
end

directory "#{cookbook_dir}/test/integration/helpers/serverspec" do
  recursive true
end

cookbook_file "#{cookbook_dir}/test/integration/helpers/serverspec/spec_helper.rb" do
  source 'serverspec_spec_helper.rb'
  action :create_if_missing
end

template "#{cookbook_dir}/test/integration/default/serverspec/default_spec.rb" do
  source 'serverspec_default_spec.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# Chefspec
directory "#{cookbook_dir}/spec/unit/recipes" do
  recursive true
end

cookbook_file "#{cookbook_dir}/spec/spec_helper.rb" do
  action :create_if_missing
end

template "#{cookbook_dir}/spec/unit/recipes/default_spec.rb" do
  source "recipe_spec.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# Recipes

directory "#{cookbook_dir}/recipes"

template "#{cookbook_dir}/recipes/default.rb" do
  source "recipe.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# Vagrant
template "#{cookbook_dir}/Vagrantfile" do
  source "vagrantfile.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# Overcommit
directory "#{cookbook_dir}/.git-hooks/pre_commit" do
  recursive true
end

cookbook_file "#{cookbook_dir}/.overcommit.yml" do
  action :create_if_missing
end

cookbook_file "#{cookbook_dir}/.rubocop.yml" do
  action :create_if_missing
end

cookbook_file "#{cookbook_dir}/.git-hooks/pre_commit/food_critic.rb" do
  action :create_if_missing
end

# git
if context.have_git
  cookbook_file "#{cookbook_dir}/.gitignore" do
    source "gitignore"
  end

  if !context.skip_git_init

    execute("initialize-git") do
      command("git init .")
      cwd cookbook_dir
    end

    execute('bundle-install') do
      command('bundle install')
      cwd cookbook_dir
    end

    execute('berks-install') do
      command('berks install')
      cwd cookbook_dir
    end

    execute('initialize-overcommit') do
      command('overcommit --install')
      cwd cookbook_dir
    end

    execute('sign-foodcritic-check') do
      command('overcommit --sign pre-commit')
      cwd cookbook_dir
    end

    execute("add all files") do
      command("git add .")
      cwd cookbook_dir
    end
  end
end
