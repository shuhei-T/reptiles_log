class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top]
  before_action :forbid_login_user, only: %i[top]

  def top;end
end
