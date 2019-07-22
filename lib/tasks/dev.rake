namespace :dev do

  DEFAULT_PASS = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner('Apagando BD...') { `rails db:drop` }
      show_spinner('Criando BD...') { `rails db:create` }
      show_spinner('Migrando BD...') { `rails db:migrate` }

      show_spinner('Registra administrador padrão...') do
        `rails dev:add_default_admin`
      end

      show_spinner('Registra administradores extras...') do
        `rails dev:add_extra_admins`
      end

      show_spinner('Registra usuário padrão...') do
        `rails dev:add_default_user`
      end

      show_spinner('Cadastrando assuntos padrões..') do
        `rails dev:add_subjects`
      end

      show_spinner('Cadastrando perguntas e respostas..') do
        `rails dev:add_answers_and_questions`
      end
    else
      puts 'Você não esta no ambiente de desenvolvimento!!!'
    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASS,
      password_confirmation: DEFAULT_PASS
    )
  end

  desc "Adiciona administradores extras"
  task add_extra_admins: :environment do
    10.times do
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASS,
        password_confirmation: DEFAULT_PASS
      )
    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASS,
      password_confirmation: DEFAULT_PASS
    )
  end

  desc "Adiciona assuntos padrões"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc "Adiciona perguntas e respostas"
  task add_answers_and_questions: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do
        Question.create!(
          description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
          subject: subject
        )
      end
    end
  end

  private

  def show_spinner(msg_start, msg_end = 'Concluído com sucesso!!!')
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success(msg_end.to_s)
  end
end
