class MovieDetail < Movie
  attr_reader :runtime,
              :genre_array,
              :genres,
              :summary,
              :cast_array,
              :cast,
              :review_array,
              :reviews

  def initialize(data)
    super(data)
    @runtime = data[:runtime]
    @genre_array = data[:genres]
    @genres = genres
    @summary = data[:overview]
    @cast_array = data[:cast]
    @cast = cast
    @review_array = data[:reviews]
    @reviews = reviews
  end

  def genres
    unless @genre_array.nil?
      @genre_array.map do |hash|
        hash[:name]
      end.join(', ')
    end
  end

  def cast
    unless @cast_array.nil?
      @cast_array.map do |hash|
        "#{hash[:name]} as #{hash[:character]}"
      end
    end
  end

  def reviews
    reviews = []
    unless @review_array.nil?
      @review_array.map do |hash|
        review_hash = {}
        review_hash[:author] = hash[:author_details][:username]
        review_hash[:comment] = hash[:content]
        reviews << review_hash
      end
    end
    reviews
  end
end
