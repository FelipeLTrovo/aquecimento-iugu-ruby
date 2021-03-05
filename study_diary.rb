require 'colorize'
require_relative 'study_item'

REGISTER = 1
VIEW     = 2
SEARCH   = 3
DELETE   = 4
EXIT     = 5

def clear
  system('clear')
end

def wait_keypress
  puts
  puts "Pressione Enter para continuar".colorize(:light_green)
  gets
end

def wait_keypress_and_clear
  wait_keypress
  clear
end

def welcome
  'Bem-vindo ao Diário de Estudos, seu companheiro para estudar!'.colorize(:blue)
end

def menu
  puts "[#{REGISTER}] Cadastrar um item para estudar".colorize(:light_blue)
  puts "[#{VIEW}] Ver todos os itens cadastrados".colorize(:light_blue)
  puts "[#{SEARCH}] Buscar um item de estudo".colorize(:light_blue)
  puts "[#{DELETE}] Remover um item de estudo".colorize(:red)
  puts "[#{EXIT}] Sair".colorize(:yellow)
  print 'Escolha uma opção: '.colorize(:blue)
  gets.to_i
end

clear
puts welcome
option = menu

loop do
  clear
  case option
  when REGISTER
    StudyItem.register
  when VIEW
    StudyItem.all
  when SEARCH
    StudyItem.search
  when DELETE
    StudyItem.delete
  when EXIT
    clear
    puts 'Obrigado por usar o Diário de Estudos'.colorize(:green)
    break  
  else
    puts 'Opção inválida'.colorize(:red)
  end
  wait_keypress_and_clear
  option = menu
end
