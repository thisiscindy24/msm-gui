class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    # Fetch form parameters
    movie_title = params.fetch("query_title")
    movie_year = params.fetch("query_year")
    movie_duration = params.fetch("query_duration")
    movie_description = params.fetch("query_description")
    movie_image = params.fetch("query_image")
    movie_director_id = params.fetch("query_director_id")
  
    # Create a new movie record
    new_movie = Movie.new
    new_movie.title = movie_title
    new_movie.year = movie_year
    new_movie.duration = movie_duration
    new_movie.description = movie_description
    new_movie.image = movie_image
    new_movie.director_id = movie_director_id

    new_movie.save
    @list_of_movies = Movie.order({ :created_at => :desc }) 
    render({ :template => "movie_templates/index" })
      
  end

  def delete_this
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    @the_movie.destroy
    

    redirect_to("/movies")
  end

  def modify
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_directors.at(0)
    render({ :template => "movie_templates/modify" })
  end

  def update
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    @the_movie.title = params.fetch("query_title")
    @the_movie.year = params.fetch("query_year")
    @the_movie.duration = params.fetch("query_duration")
    @the_movie.description = params.fetch("query_description")
    @the_movie.image = params.fetch("query_image")
    @the_movie.director_id = params.fetch("query_director_id")

    @the_movie.save
    redirect_to("/movies/#{@the_movie.id}")
  end
end
