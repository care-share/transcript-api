class PrescriptionController < ApplicationController

  respond_to :json, :xml

  def home
    respond_with([1,2,3])
#    @prescription = Prescription.new
#    render :text => "OK"
#    render :text => @prescription.to_json
#    render :inline => "hey there"
  end

end
