class Api::V1::UsersController < ApplicationController
    before_action :authenticate_user!

    def me
    render json: {
      user: {
      id: current_user.id,
      email: current_user.email,
      username: current_user.username,
      boat_class: current_user.boat_class,
      role: current_user.role
    }
    }
  end
end
