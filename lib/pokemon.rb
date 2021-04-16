class Pokemon
    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
        p self
    end
    
    def self.new_from_db(array)
        p array[0]
        p array[1]
        p array[2]
        p array[3]


        pokemon = self.new(id: array[0], name: array[1], type: array[2], db: array[3])
      end

    def self.find(id, db)
        sql = <<-SQL
        SELECT *
        FROM pokemon
        WHERE id = ?
        LIMIT 1
      SQL
  
      db.execute(sql, id).map do |row|
        self.new_from_db(row)
      end[0]
    end

    def self.save(name, type, db)
        db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)",name, type)
    end
end
