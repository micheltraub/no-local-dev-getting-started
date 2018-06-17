# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require './environments'


get "/" do
  erb :home
end

### START OBJECTS ###
class Contact < ActiveRecord::Base
  self.table_name = 'salesforce.contact'
end

class VolunteerArea__c < ActiveRecord::Base
  self.table_name = 'salesforce.volunteerarea__c'
end

class Volunteer__c < ActiveRecord::Base
  self.table_name = 'salesforce.volunteer__c'
  #create a filer to show volunteers by area 
  scope :from_area, -> (area_id) { where(:volunteerarea__c => area_id) }
end
### END OBJECTS ###

### START ROUTES ###
# get all contacts
get "/contacts" do
  @contacts = Contact.all
  erb :index
end
# get all areas
get "/areas" do
  @areas = VolunteerArea__c.all
  erb :area
end
# get all volunteers by area id
get "/volunteers" do
  @volunteers = Volunteer__c.from_area(params[:area_id])
  erb :volunteer
end
### END ROUTES ###


