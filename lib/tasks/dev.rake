namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "sets up development environment"
  task setup: :environment do
    if Rails.env.development?
      `rails db:drop`
      `rails db:create`
      `rails db:migrate`
      `rails dev:add_default_admin`
      `rails dev:add_default_user`
    else
      puts "You are not on development evironment!"
    end
  end

  desc "Adds default admin"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adds default user"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

end
