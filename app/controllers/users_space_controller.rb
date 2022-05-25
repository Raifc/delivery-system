class UsersSpaceController < ApplicationController
  before_action :authenticate_user!
  layout 'users_space'
end
