class Book
  attr_reader :isbn,
              :title,
              :publisher,
              :publish_date

  def initialize(data)
    @isbn = data[:isbn]
    @title = data[:title]
    @publisher = data[:publisher]
    @publish_date = data[:publish_date]
  end
end
