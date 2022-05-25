class AdminsSpaceController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins_space'
end
