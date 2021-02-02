# Movie Collection Database

Movie Collection Database is a Sinatra web app that allows the user to keep track and sort through their movie collection.

## Installation

Run 'bundle install' then make an environment variable called 'SESSION_MOVIE' with the value being randomly generated using 'sysrandom/securerandom'

Copy the value of: 
$ ruby -e "require 'sysrandom/securerandom'; puts SecureRandom.hex(64)"

and export your environment variable:
$ export SESSION_MOVIE=paste value copied above here

In the console enter 'rake db:seed' to run the seeds.rb file to create all the genres and formats you will need for the database.

## Usage

Create an account by entering your name, username, and password you would like to use.

Once logged in you can click 'Add' to add a movie to your collection. You must enter at least a name for the movie to save it to your collection.

You can view all movies in your collection alphabetically from the 'Titles' link.
You can also see movies based on what genre they are, format you own them in, or by the director of the movie. Click the according links for those.

To edit a movie in your collection click on the movie then at the bottom there should be a link marked 'Edit'. Click to bring up the edit page.

To delete a movie click on the movie then underneath all the info for the movie will be a 'delete' button. Click to remove the movie from your collection.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
