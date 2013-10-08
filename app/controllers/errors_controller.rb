class ErrorsController < ApplicationController
  def routing
    render_with 404, "Invalid Resource"
  end
end