require("pry")
require_relative("../models/albums")
require_relative("../models/artists")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  'name' => "Tycho"
  })

artist2 = Artist.new({
  'name' => "Roosevelt"
  })

artist3 = Artist.new({
  'name' => "Hird"
  })

artist1.save()
artist2.save()
artist3.save()

album1 = Album.new({
  'artist_id' => artist1.id,
  'title' => "Dive"
  })

album2 = Album.new({
  'artist_id' => artist1.id,
  'title' => "Awake"
  })

album3 = Album.new({
  'artist_id' => artist2.id,
  'title' => "Beat!Beat!Beat!"
  })

album4 = Album.new({
  'artist_id' => artist3.id,
  'title' => "Moving On"
  })

album1.save()
album2.save()
album3.save()
album4.save()

binding.pry
nil
