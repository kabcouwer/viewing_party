class Movie
  attr_reader :title,
              :rating,
              :id
  def initialize(data)
    @title = data[:title]
    @rating = data[:vote_average]
    @id = data[:id]
  end
end
