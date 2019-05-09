class ShortenedUrl < ApplicationRecord
  attr_accessor :nombre, :expire_date

  def self.sanitize(url)

    url.strip!
    url = url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
    url.slice!(0) if url[0] == "/"
    url = "http://#{url}"
  end

  def self.add_days(id, numbers)

    url = Shortener::ShortenedUrl.find(id)
    url.expires_at = url.expires_at + numbers.to_i.days
    url.save

  end

  def self.expire(id, date)

    url = Shortener::ShortenedUrl.find(id)
    url.expires_at = DateTime.now
    url.save

  end

  def self.date_is_valid?(date)
    date.expires_at > DateTime.now
  end

end
