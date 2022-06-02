class ApplicationController < ActionController::Base
  before_action :set_current_user
  around_action :use_zone
  before_action :denied_if_user_missing

  def set_current_wordle_number
    @wordle_number = (Date.current - Date.new(2021, 6, 19)).to_i
  end

  attr_reader :current_user

  def denied
    render 'landing/_no_access', status: :forbidden
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def use_zone
    zone_str = current_user&.local_time_zone.presence || 'America/New_York'
    Time.use_zone(zone_str) do
      set_current_wordle_number
      yield
    end
  end

  def denied_if_user_missing
    denied if current_user.blank?
  end
end
