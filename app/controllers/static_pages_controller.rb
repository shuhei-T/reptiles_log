class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top privacy service]
  before_action :forbid_login_user, only: %i[top]

  def top;end

  def privacy;end

  def service;end
end
