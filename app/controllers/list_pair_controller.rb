class ListPairController < ApplicationController
  respond_to :json
  require "medrec/list_pair_reader_from_string.rb"
  def align
#this works as a post with reply for prescriptions#index, take inspiration from this 
#    @prescription.values = puts 
#    reader = PrescriptionObjectReader.new(@prescription)
#    @pipeline = Pipeline.new(reader, [MyFeatures.new, AllErrorsClassifier.new])
#    @pipeline.run 1
#    @prescription.features = nil # sanitize artifacts other than the input and the decision. make this less kludgey later.
#    respond_to do |format|
#      format.json {render :json => @prescription}
#    end


    reader = ListPairReaderFromString.new
  end

end
