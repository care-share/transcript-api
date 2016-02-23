# -*- coding: utf-8 -*-
class ListPairController < ApplicationController
  respond_to :json

  # from TranScript
  require "medrec/aligner.rb"
  require "medrec/list_pair_reader.rb"
  require "medrec/list_pair_prescription_feature_extractor.rb"
  require "medrec/aligned_list_discrepancy_detector.rb"
  require "medrec/list_pair_writer.rb"
  require "medrec/analyst.rb"
  require "med_order_working/fhir_list_pair_reader_from_string"

  before_filter :set_access_control

  def set_access_control
###    #headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"]
###    headers['Access-Control-Allow-Origin'] = '*'
###    headers['Access-Control-Expose-Headers'] = 'ETag'
###    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
###    #headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
###    headers['Access-Control-Allow-Headers'] = '*'
###    headers['Access-Control-Max-Age'] = '86400'
###    headers['Access-Control-Allow-Credentials'] = 'true'
  end

  def align #POST
    reader = FHIRListPairReaderFromString.new(params[:listpair])
    pipeline_array = [ListPairPrescriptionFeatureExtractor.new, Aligner.new, \
                      AlignedListStrictStringMatchDiscrepancyDetector.new(["name", "annotation"]), \
                      AlignedListMedAttribMatchDiscrepancyDetector.new, \
                      AlignedListDoseStrengthDiscrepancyDetector.new(["dose"]),\
                      GUIMockup.new ]
    @pipeline = Pipeline.new(reader, pipeline_array)
    @pipeline.run 1

    puts @pipeline.data.first.values["medsRecon"].inspect

    respond_to do |format|
      format.json {render :json => {"medsRecon" => @pipeline.data.first.values["medsRecon"]}}
    end
  end

################# Example Usage ########################################
# Simulated aligner call:
# curl -O --data @/home/davidtk/transcript/git/transcript-rule-based-full/merged_short__for_service__post.json -i http://localhost:3005/list_pair/align.json -L --verbose
#
# Contents of listpair.json:
# listpair={ "patientId": "1", "hh": [ { "patientId": "1", "name": "RABEPRAZOLE NA 20MG EC TAB", "form": null, "dose": "20MG", "SIG": "BID", "route": "ORAL", "instructions": null, "annotation": null, "id": 1 }, { "patientId": "1", "name": "DOCUSATE NA 100MG CAP", "form": null, "dose": "200MG", "SIG": "BID", "route": "ORAL", "instructions": null, "annotation": null, "id": 2 }, { "patientId": "1", "name": "IBUPROFEN 400MG TAB", "form": null, "dose": "400MG", "SIG": "TID", "route": "ORAL", "instructions": null, "annotation": null, "id": 3 }, { "patientId": "1", "name": "LISINOPRIL 5MG TAB", "form": null, "dose": "5MG", "SIG": "QD", "route": "ORAL", "instructions": null, "annotation": null, "id": 4 }, { "patientId": "1", "name": "SERTRALINE HCL 100MG TAB", "form": null, "dose": "50MG", "SIG": "QD", "route": "ORAL", "instructions": null, "annotation": null, "id": 5 }, { "patientId": "1", "name": "SIMVASTATIN 5MG TAB", "form": null, "dose": "5MG", "SIG": "QPM", "route": "ORAL", "instructions": null, "annotation": null, "id": 6 }, { "patientId": "1", "name": "SENNOSIDES 8.6MG TAB", "form": null, "dose": "8.6MG", "SIG": "BID PRN", "route": "ORAL", "instructions": null, "annotation": null, "id": 7 }, { "patientId": "1", "name": "TERAZOSIN HCL 10MG CAP", "form": null, "dose": "10MG", "SIG": "QHS", "route": "ORAL", "instructions": null, "annotation": null, "id": 8 }, { "patientId": "1", "name": "ALENDRONATE 70MG TAB", "form": null, "dose": "70MG", "SIG": "QWEEK", "route": "ORAL", "instructions": null, "annotation": null, "id": 9 }, { "patientId": "1", "name": "WARFARIN NA (GOLDEN STATE) 5MG TAB", "form": null, "dose": "5MG", "SIG": "Q-PM", "route": "ORAL", "instructions": null, "annotation": null, "id": 10 } ], "va": [ { "patientId": "1", "name": "Acetaminophen", "form": null, "dose": "1000mg", "SIG": "q6º", "route": "po", "instructions": null, "annotation": null, "id": 1 }, { "patientId": "1", "name": "Albuterol", "form": null, "dose": "90mcg/200 2 puffs", "SIG": "Q4ºPRN", "route": "inhale", "instructions": null, "annotation": null, "id": 2 }, { "patientId": "1", "name": "albuterol 90/1Pratrop", "form": null, "dose": "2puffs", "SIG": "Q6ºPRN", "route": "inhale", "instructions": null, "annotation": null, "id": 3 }, { "patientId": "1", "name": "Alendronate", "form": null, "dose": "70mg", "SIG": "QMONDAY", "route": "po", "instructions": null, "annotation": null, "id": 4 }, { "patientId": "1", "name": "Calcium-Vitamin D", "form": null, "dose": "1tab", "SIG": "TID w/meals", "route": "po", "instructions": null, "annotation": null, "id": 5 }, { "patientId": "1", "name": "Coumadin", "form": null, "dose": "5mg", "SIG": "QPM", "route": "po", "instructions": null, "annotation": null, "id": 6 }, { "patientId": "1", "name": "Advil", "form": null, "dose": "400mg", "SIG": "TID w/meals", "route": "po", "instructions": null, "annotation": null, "id": 7 }, { "patientId": "1", "name": "Lisinopril", "form": null, "dose": "5mg", "SIG": "QD", "route": "po", "instructions": null, "annotation": null, "id": 8 }, { "patientId": "1", "name": "Morphine Sulfate", "form": null, "dose": "15mg", "SIG": "Q6ºPRN", "route": "po", "instructions": null, "annotation": null, "id": 9 }, { "patientId": "1", "name": "raberprazole", "form": null, "dose": "20 mg", "SIG": "bid 30min prior to meal", "route": "po", "instructions": null, "annotation": null, "id": 10 }, { "patientId": "1", "name": "Sertraline HCL", "form": null, "dose": "50 mg", "SIG": "QD", "route": "po", "instructions": null, "annotation": null, "id": 11 }, { "patientId": "1", "name": "simvastin", "form": null, "dose": "5mg", "SIG": "QPM", "route": "po", "instructions": null, "annotation": null, "id": 12 }, { "patientId": "1", "name": "TERAZOSIN", "form": null, "dose": "10mg", "SIG": "QPM", "route": "po", "instructions": null, "annotation": null, "id": 13 }, { "patientId": "1", "name": "Vitamin D", "form": null, "dose": "200u", "SIG": "TID w/meals", "route": "po", "instructions": null, "annotation": null, "id": 14 } ] }
  #########################################################################

  protect_from_forgery
  skip_before_filter :verify_authenticity_token, if: :json_request?

  protected

  def json_request?
    request.format.json?
  end
end
