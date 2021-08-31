class Movie
  attr_reader :id,
              :title,
              :rating

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @rating = data[:vote_average]
  end
end
