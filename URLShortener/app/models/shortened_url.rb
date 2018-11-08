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

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  def self.make_url(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create({:short_url => short_url, :long_url => long_url, :user_id => user.id})
  end

  def self.random_code
    rand_code = SecureRandom::urlsafe_base64
    if ShortenedUrl.exists?(rand_code)
      self.random_code
    else
      return rand_code
    end
  end

end
