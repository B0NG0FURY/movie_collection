genres = ["action", "drama", "comedy", "horror", "sci-fi", "romance"]
formats = ["blu-ray", "dvd", "vhs", "laserdisc"]

genres.each {|genre| Genre.create(name: genre)}
formats.each {|format| Format.create(name: format)}