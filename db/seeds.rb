genres = ["action", "drama", "comedy", "horror", "sci-fi", "romance"]
formats = ["blu-ray", "dvd", "vhs", "laserdisc"]

genres.each {|genre| Genre.find_or_create_by(name: genre)}
formats.each {|format| Format.find_or_create_by(name: format)}