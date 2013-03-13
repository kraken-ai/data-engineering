require 'simplecov'
SimpleCov.start 'rails'

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  def delete_items(items); items.each{|item| delete_all_models(item)}; end
  def delete_all_models(model); model.humanize.constantize.all.each{|obj| obj.delete}; end
end

def create_user
  User.create({email: "test@user.com", password: "password"})
end

def user; User.first || create_user; end
