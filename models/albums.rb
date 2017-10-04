require_relative '../db/sql_runner'

class Album
  attr_accessor :artist_id, :title
  attr_reader :id

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @artist_id = details['artist_id'].to_i
    @title = details['title']
  end

  def save()
    sql = "INSERT INTO albums
    (
    artist_id,
    title
    ) VALUES (
    $1, $2
      )
    RETURNING id;"
    values = [@artist_id, @title]
    result = SqlRunner.run(sql, "save", values)
    @id = result[0]["id"].to_i
  end

  def update()
    sql = "UPDATE albums SET (
    artist_id,
    title
    ) = (
      $1, $2
    )
    WHERE id = $3;"
    values = [@artist_id, @title]
    SqlRunner.run(sql, "update", values)
  end

  def delete()
    sql = "DELETE FROM albums where id = $1;"
    values = [@id]
    SqlRunner.run(sql, "delete", values)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1;"
    values = [id]
    results = SqlRunner.run(sql, "find", values)
    result_hash = results.first
    result = Album.new(results_hash)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    values = []
    SqlRunner.run(sql, "delete_all", values)
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [@artist_id]
    results = SqlRunner.run(sql, "get_customer", values)
    artist = results[0]
    return Artist.new(artist)
  end
end
