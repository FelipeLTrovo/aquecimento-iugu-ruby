require "sqlite3"
require "colorize"

class StudyItem
    attr_reader :id, :title, :category
    
    @@db = SQLite3::Database.new "study_diary.db"

    def initialize(title:, category:)
        @title = title
        @category = category
    end

    def include?(query)
        title.include?(query) || category.include?(query)
    end

    def self.register
        print 'Digite o título do seu item de estudo: '.colorize(:blue)
        title = gets.chomp
        print 'Digite a categoria do seu item de estudo: '.colorize(:blue)
        category = gets.chomp
        @@db.execute("INSERT INTO study_items (id, title, category) 
        VALUES (?, ?, ?)", [nil, title, category])
        puts "Item '#{title}' da categoria '#{category}' cadastrado com sucesso!".colorize(:green)
    end

    def self.all
        response = @@db.execute("select * from study_items") 
        response.each do |row|
            puts "##{row[0]} - #{row[1]} - #{row[2]}".colorize(:light_yellow)
        end
        puts "Nenhum item encontrado".colorize(:red) if response.length == 0
    end

    def self.search
        print 'Digite uma palavra para procurar: '.colorize(:blue)
        term = gets.chomp
        response = @@db.execute("select * from study_items where title like ? or category like ?", "%#{term}%", "%#{term}%") 
        response.each do |row|
            puts "##{row[0]} - #{row[1]} - #{row[2]}".colorize(:light_yellow)
        end
        puts "Nenhum item encontrado".colorize(:red) if response.length == 0
    end

    def self.delete
        all()
        print 'Digite o ID do registro a ser removido: '.colorize(:blue)
        remove_id = gets.chomp
        if find(remove_id).length == 1
            @@db.execute("delete from study_items where id = ?", remove_id)
            puts "Item ##{remove_id} removido com sucesso.".colorize(:green)
        else
            puts "Nenhum item encontrado".colorize(:red) 
        end
    end

    def self.find(id)
        response = @@db.execute("select * from study_items where id = ?", id)
    end

end