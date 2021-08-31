class MovieDetail < Movie
  attr_reader :runtime,
              :genre_array,
              :genres,
              :summary,
              :cast,
              :reviews

  def initialize(data)
    super(data)
    @runtime = data[:runtime]
    @genre_array = data[:genres]
    @genres = genres
    @summary = data[:overview]
    @cast = data[:cast]
    @reviews = data[:reviews]
  end

  def genres
    @genre_array.map do |hash|
      hash[:name]
    end.join(', ')
  end
end
