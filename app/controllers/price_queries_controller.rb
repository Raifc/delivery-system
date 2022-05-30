class PriceQueriesController < ApplicationController
  before_action :authenticate_admin!

  def calculate_prices

    height = params.fetch(:height).to_i
    width = params.fetch(:width).to_i
    depth = params.fetch(:depth).to_i
    weight = params.fetch(:weight).to_i
    distance = params.fetch(:distance).to_i
    volume = height * width * depth
    @results = []
    @companies = Company.all.where("status = 1")

    @companies.each do |company|
      company_hash = {}
      price = company.prices.find_by("min_volume <= ? AND max_volume >= ? AND min_weight <= ? AND max_weight >= ?", volume, volume, weight, weight)
      next unless price.present?

      delivery_time = company.delivery_times.find_by("min_distance <= ? AND max_distance >= ?", distance, distance)
      rate = price.km_value
      final_price = distance * rate

      days_to_delivery = if delivery_time.present?
                           delivery_time.business_days
                         else
                           'Not Given'
                         end

      company_hash[:company_name] = company.trading_name
      company_hash[:price] = final_price / 100
      company_hash[:delivery_time] = days_to_delivery

      @results << company_hash
    end

  end

  private

  def calculate_prices_params
    params.require(:data).permit(:height, :width, :depth, :weight, :distance)
  end

end
