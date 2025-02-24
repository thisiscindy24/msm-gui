class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    # Extract form parameters
    director_name = params.fetch("query_name")
    director_dob = params.fetch("query_dob")
    director_bio = params.fetch("query_bio")
    director_image = params.fetch("query_image")

    # Create new director record
    new_director = Director.new
    new_director.name = director_name
    new_director.dob = director_dob
    new_director.bio = director_bio
    new_director.image = director_image
    
    new_director.save
    @list_of_directors = Director.order({ :created_at => :desc })
    render({ :template => "director_templates/index" })
  end

  def delete_this
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    @the_director.destroy
    

    redirect_to("/directors")
  end

  def modify
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)
    render({ :template => "director_templates/modify" })

  end

  def update
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)
    @the_director.name = params.fetch("query_name")
    @the_director.dob = params.fetch("query_dob")
    @the_director.bio = params.fetch("query_bio")
    @the_director.image = params.fetch("query_image")
    
    @the_director.save
    redirect_to("/directors/#{@the_director.id}")
  end


end
