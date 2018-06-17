# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'


get "/" do
  erb :home
end


class Contact < ActiveRecord::Base
  self.table_name = 'salesforce.contact'
end


class VolunteerArea__c < ActiveRecord::Base
  self.table_name = 'salesforce.volunteerarea__c'
end

class Volunteer__c < ActiveRecord::Base
  self.table_name = 'salesforce.volunteer__c'
   scope :from_area, -> (area_id) { where("name like ?", "#{area_id}%") }
end

get "/contacts" do
  @contacts = Contact.all
  erb :index
end

get "/areas" do
  @areas = VolunteerArea__c.all
  erb :area
end


get "/volunteers" do
  @volunteers = Volunteer__c.from_area(params[:area_id])
  erb :volunteer
end

