namespace :dev do

  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')


  desc "TODO"
  task setup: :environment do
    if Rails.env.development?

      %x(rails db:drop db:create db:migrate dev:add_admins dev:add_users dev:add_extra_admins dev:add_subjects dev:add_answers_and_questions)

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

  desc "Cria adiministradores extras"
  task add_extra_admins: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: 123456,
        password_confirmation: 123456
      )
    end
  end

  desc "Cria user padrão"
  task add_users: :environment do
    User.create!(
      email: 'user@user.com',
      password: 123456,
      password_confirmation: 123456
    )
  end
  
  desc "Adiciona assuntos padrão"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc "Adiciona perguntas e resposta"
  task add_answers_and_questions: :environment do
    Subject.all.each do |subject|
      rand(1..3).times do |i|
        params = {question: {
          description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
          subject: subject,
          answers_attributes: []
        }}

        rand(2..4).times do |j|
          params[:question][:answers_attributes].push(
            {description: Faker::Lorem.sentence, correct: false }
          )
        end

        index = rand(params[:question][:answers_attributes].size)
        params[:question][:answers_attributes][index] = {description: Faker::Lorem.sentence, correct: true}

        Question.create!(params[:question])
      end
    end
  end

  desc "Reseta os contadores de assunto"
  task reset_subject_counter: :environment do
    Subject.all.each do |subject|
      Subject.reset_counters(subject.id, :questions)
    end
  end

end
