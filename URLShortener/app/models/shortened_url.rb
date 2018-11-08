# == Schema Information
#
# Table name: shortened_urls
#
#  id        :bigint(8)        not null, primary key
#  short_url :string           not null
#  long_url  :string           not null
#  user_id   :integer          not null
#

class ShortenedUrl < ApplicationRecord

  validates :short_url, :long_url, :user_id, presence: true, uniqueness: true

  def self.make_url(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.new({:short_url => short_url, :long_url => long_url, :user_id => user.id})
  end

  def self.random_code
    rand_code = SecureRandom::urlsafe_base64
    if ShortenedUrl.exists?(rand_code)
      self.random_code
    else
      return rand_code
    end
  end

  def initialize(options)
    @short_url = options[:short_url]
    @long_url = options[:long_url]
    @user_id = options[:user_id]
  end

end
