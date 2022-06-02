class User < ApplicationRecord
  has_many :rounds_users
  has_many :result_submissions
  has_many :rounds, through: :rounds_users
  has_one :preference
  after_validation :generate_login_key, if: -> { login_key.blank? }
  def self.for_select
    all.order(name: :asc).pluck(:name, :id)
  end

  def to_s
    name.presence || super
  end

  def generate_login_key
    self.login_key = SecureRandom.uuid
  end

  def local_time_zone
    TZInfo::Timezone.get(time_zone)
  end

  def time_zone
    preference&.time_zone.presence || 'America/New_York'
  end
end
