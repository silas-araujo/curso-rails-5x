namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?

      show_spinner("Apagando BD...") {%x(rails db:drop)}
      show_spinner("Criando BD...") {%x(rails db:create)}
      show_spinner("Migrando as tabelas...") {%x(rails db:migrate)}

      show_spinner("Populando BD...")do
        %x(rails db:seed)
      end


    else 
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  private
   
  def show_spinner(msg_start, msg_end = "Conluído com sucesso")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("#{msg_end}")
  end

end
