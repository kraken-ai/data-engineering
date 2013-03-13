class Datafile
  extend ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Conversion

  validates :filename, :presence => {:message => "was empty - please select a file to upload"}

  attr_accessor :filename, :path

  def initialize(filename = nil)
    @filename = filename
  end

  def persisted?; false; end
end
