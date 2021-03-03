class StudyItem
    attr_reader :id, :title, :category

    @@next_id = 1
    @@study_items = []

    def initialize(title:, category:)
        @id = @@next_id
        @title = title
        @category = category

        @@next_id += 1
        @@study_items << self
    end

    def include?(query)
        title.include?(query) || category.include?(query)
    end

    def to_s
        "##{id} - #{title} - ##{category}"
    end

    def self.register
        print 'Digite o título do seu item de estudo: '
        title = gets.chomp
        print 'Digite a categoria do seu item de estudo: '
        category = gets.chomp
        puts "Item '#{title}' da categoria '#{category}' cadastrado com sucesso!"
        new(title: title, category: category)
    end

    def self.all
        @@study_items
    end

    def self.search(term)
    end

end