require 'spec_helper'
include Apivore::RspecBuilder

context "API testing scenarios" do
  before do
    apivore_setup '/services/{id}.json', 'get', '200' do
      {'id' => 1}
    end

    apivore_setup '/services.json', 'post', '204' do
      {"_data" => {'name' => 'hello world'}}
    end

    apivore_setup '/services/{id}.json', 'put', '204' do
      {'id' => 1}
    end

    apivore_setup '/services/{id}.json', 'delete', '204' do
      {'id' => 1}
    end

    apivore_setup '/services/{id}.json', 'patch', '204' do
      {'id' => 1}
    end
  end

  describe "passing doc", :type => :request do
    validate("/swagger-doc.json")
  end

  describe "unimplemented path in doc", :type => :request do
    validate("/02_unimplemented_path.json")
  end

  describe "mismatched property type", :type => :request do
    validate("/03_mismatched_type_response.json")
  end

  describe "unexpected http response", :type => :request do
    validate("/04_unexpected_http_response.json")
  end

  describe "extra properties", :type => :request do
    validate("/05_extra_properties.json")
  end

  describe "missing required", :type => :request do
    validate("/06_missing_required_property.json")
  end

  describe "missing non-required", :type => :request do
    validate("/07_missing_non-required_property.json")
  end
end
