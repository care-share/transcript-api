##
# Copyright 2016 The MITRE Corporation, All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this work except in compliance with the License.
# You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class PrescriptionsController < ApplicationController
  respond_to :json

  #API posts a JSON object to index...
  #e.g. curl -d 'prescription[values]={"Medication":"ADVAIR DISKUS 100/50 (FLUTICASONE PROPIONATE/SALMETEROL 100/50)","Route":"INH","Dose":"1","DoseUnits":"PUFF","Strength":"","Take":"","Form":"","Frequency":"daily","PRN":"0","PRNreason":"","Duration":"","DurationUnits":"","Dispensequantity":"1","Dispensequantityunits":"diskus","DIRECTIONS":"do not exceed the prescribed dosage"}' -i localhost:3000/prescriptions/index.json -L
  def index
#    @prescription = Prescription.new
#    @prescription.values = JSON.parse(params[:prescription][:values])
#    reader = PrescriptionObjectReader.new(@prescription)
#    @pipeline = Pipeline.new(reader, [MyFeatures.new, AllErrorsClassifier.new])
#    @pipeline.run 1
#    @prescription.features = nil # sanitize artifacts other than the input and the decision. make this less kludgey later.
#    respond_to do |format|
#      format.json {render :json => @prescription}
#    end
    respond_to do |format|
      format.json {redirect_to :action => "home", :prescription_values => params[:prescription][:values] }
    end
  end

  #... and gets redirected to home, which returns back the original json with an added field "classifier_decision"
  #classifier_decision==true means discrepancy found, classifier_decision==false means no discrepancy
  def home
    @prescription = Prescription.new
    @prescription.values = JSON.parse(params[:prescription_values])
    reader = PrescriptionObjectReader.new(@prescription)
    @pipeline = Pipeline.new(reader, [MyFeatures.new, AllErrorsClassifier.new])
    @pipeline.run 1
    @prescription.features = nil # sanitize artifacts other than the input and the decision. make this less kludgey later.
    respond_with(@prescription)
  end

end


# find a better place for this. directly in lib? models?
class MyFeatures < GenericFeatureExtractor
  def feature_sets;    [Features::Basic, Features::StructuredFields, Features::MedAttribDirections, Features::MedAttribFrequency, Features::ParsedStructuredFields];  end
end
