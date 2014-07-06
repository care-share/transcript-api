class ListPairController < ApplicationController
  respond_to :json
  require "medrec/list_pair_reader_from_string.rb"

  def align #POST
    reader = ListPairReaderFromString.new(params[:listpair])
    pipeline_array = [ListPairPrescriptionFeatureExtractor.new, Aligner.new, \
                      AlignedListStrictStringMatchDiscrepancyDetector.new(["name", "annotation"]), \
                      AlignedListMedAttribMatchDiscrepancyDetector.new, \
                      AlignedListDoseStrengthDiscrepancyDetector.new(["dose"]),\
                      GUIMockup.new ]
    @pipeline = Pipeline.new(reader, pipeline_array)
    @pipeline.run 1

    respond_to do |format|
      format.json {render :json => {"medsRecon" => @pipeline.data.first.values["medsRecon"]}}
    end

  end

end
