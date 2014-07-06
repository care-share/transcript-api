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
