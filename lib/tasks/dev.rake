namespace :dev do
  desc "TODO"
  task setup: :environment do
    if Rails.env.development?

      %x(rails db:drop db:create db:migrate dev:add_admins dev:add_users)

    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Cria adiministrador padrão"
  task add_admins: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: 123456,
      password_confirmation: 123456
    )
  end

  desc "Cria user padrão"
  task add_users: :environment do
    User.create!(
      email: 'user@user.com',
      password: 123456,
      password_confirmation: 123456
    )
  end

end
