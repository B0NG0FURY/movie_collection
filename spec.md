# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
    Using Sinatra 2.1.0
- [x] Use ActiveRecord for storing information in a database
    Using ActiveRecord 4.2.11.3 with 8 tables
- [x] Include more than one model class (e.g. User, Post, Category)
    There are 8 total models
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
    User and Director both have a has_many relationship with movies
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
    Movie belongs_to User and Director
- [x] Include user accounts with unique login attribute (username or email)
    Users have accounts with their own unique username
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
    Movies have routes for each element of CRUD
- [x] Ensure that users can't modify content created by other users
    A user can only view movies, genres, directors, and formats if they are logged in, otherwise they are given an error screen informing them to sign in
- [x] Include user input validations
    Users can't create an account without filling out all of the forms. Movies cannot be created or edited unless at least the Movie's name is filled out
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
    Flash messages are implemented whenever a user fails to login successfully, fill out required forms, when a movie is added to collection, modified, or deleted
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
    README.md is complete and contains all above requirements

Confirm
- [x] You have a large number of small Git commits
    There are a large number of commits
- [x] Your commit messages are meaningful
    Each commit has a message describing what was done
- [x] You made the changes in a commit that relate to the commit message
    Each commit has a message detailing changes done only within that commit
- [x] You don't include changes in a commit that aren't related to the commit message
    Commit messages only detail changes done within that commit