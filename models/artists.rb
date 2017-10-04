require_relative '../db/sql_runner'

class Artist
    attr_accessor :name
    attr_reader :id

    def initialize(details)
      @id = details['id'].to_i if details['id']
      @name = details['name']
    end

    def save()
      sql = "INSERT INTO artists
      (name)
      VALUES
      ($1)
      RETURNING id;"
      values = [@name]
      result = SqlRunner.run(sql, "save_artist", values)
      @id = result[0]['id'].to_i()
    end

    def update()
      sql = "UPDATE artists SET
      (
        name
      ) = (
        $1
      )
      WHERE id = $2;"
      values = [@name, @id]
      SqlRunner.run(sql, "update_artist", values)
    end

    def delete()
      sql = "DELETE FROM artists WHERE id = $1;"
      values = [@id]
      SqlRunner.run(sql, "delete_artists", values)
    end

    def self.delete_all()
      sql = "DELETE FROM artists"
      values = []
      SqlRunner.run(sql, "delete_all_artists", values)
    end

    def self.all()
      sql = "SELECT * FROM artists"
      values = []
      SqlRunner.run(sql, "select_all_artists", values)
    end

    def self.find_artist(id)
      sql = "SELECT * FROM artists WHERE id = $1;"
      values = [id]
      artist = SqlRunner.run(sql, "find_artist_by_id", values)
      result = Artist.new(artist)
    end

    def albums()
      sql = "SELECT * from albums WHERE artist_id = $1;"
      values = [@id]
      result = SqlRunner.run(sql, "get_album", values)
      return result.map {|album| Album.new(album)}
    end

end
