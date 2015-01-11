class ControlPointsController < ApplicationController

  respond_to :json

  def destroy
    @control_point = ControlPoint.find(params[:id])
    @control_point.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

end
