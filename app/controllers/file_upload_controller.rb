require 'data_reader'

class FileUploadController < ApplicationController
  before_filter :authenticate_user!

  def new
    @datafile = Datafile.new
  end

  def create
    @datafile = Datafile.new(params[:filename])

    if @datafile.valid?
      uploaded_io = params[:filename]
      uploaded_io = uploaded_io.tempfile if uploaded_io.respond_to?('tempfile')

      objects = DataReader.new.object_graph(uploaded_io, current_user.id)
      persist_object_graph(objects)

      @total_sales = find_total_sales
      render :complete
    else
      render :new
    end
  end

  def complete
    @total_sales = find_total_sales
  end

private
  def find_total_sales
    total_sales = 0.0

    begin
      total_sales = Company.find(current_user.id).total_sales
    rescue
      Rails.logger.warn("coulnd't find that company, probably not setup yet...")
    end

    total_sales
  end

  def persist_object_graph(objects)
    begin
      Company.create({:open_id => objects[:company][:company_id]})
      Purchaser.create_purchasers(objects[:purchasers])
      Merchant.create_merchants(objects[:merchants])
      Item.create_items(objects[:items])
      Order.create_orders(objects[:orders], objects[:company][:company_id])
    rescue => e
      Rails.logger.error("ERROR: couldn't save translated CSV data")
      Rails.logger.error(e.backtrace)
    end
  end

end
