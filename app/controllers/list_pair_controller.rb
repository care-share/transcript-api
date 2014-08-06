class ListPairController < ApplicationController
  respond_to :json
  require "medrec/list_pair_reader_from_string.rb"

  before_filter :set_access_control

  def set_access_control
    headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"]
    headers['Access-Control-Expose-Headers'] = 'ETag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
    headers['Access-Control-Max-Age'] = '86400'
    headers['Access-Control-Allow-Credentials'] = 'true'
  end

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
