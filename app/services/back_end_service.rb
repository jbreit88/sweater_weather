class BackEndService

  private

  def self.get_data(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

end
