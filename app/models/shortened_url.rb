class ShortenedUrl < ApplicationRecord

  def self.sanitize(url)

    url.strip!
    url = url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
    url.slice!(0) if url[0] == "/"
    url = "http://#{url}"
  end

  def self.is_not_empty?(url)

    if url.nil? || url == ""
      return false
    else
      return true
    end

  end

end
