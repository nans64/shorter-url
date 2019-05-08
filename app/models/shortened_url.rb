class ShortenedUrl < ApplicationRecord

  def self.sanitize(url)

    url.strip!
    url = url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
    url.slice!(0) if url[0] == "/"
    url = "http://#{url}/"
  end

end
