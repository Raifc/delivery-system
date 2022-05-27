class PriceQueriesController < ApplicationController
  before_action :authenticate_admin!

  def calculate_prices

    height = params.fetch(:height).to_i
    width = params.fetch(:width).to_i
    depth = params.fetch(:depth).to_i
    weight = params.fetch(:weight).to_i
    distance = params.fetch(:distance).to_i
    volume = height * width * depth
    @result = [] #transformar result em hash
    @companies = Company.all.where("status = 1")

    @companies.each do |company|
      partial_result = []
      price = company.prices.find_by("min_volume <= ? AND max_volume >= ? AND min_weight <= ? AND max_weight >= ?", volume, volume, weight, weight)
      delivery_time = company.delivery_times.find_by("min_distance <= ? AND max_distance >= ?", distance, distance)
      next unless price.present?
      rate = price.km_value
      final_price = distance * rate

      days_to_delivery = if delivery_time.present?
                           delivery_time.business_days
                         else
                           'Not Given'
                         end

      partial_result << company.trading_name
      partial_result << final_price
      partial_result << days_to_delivery

      @result << partial_result
    end
  end

  private

  def calculate_prices_params
    params.require(:data).permit(:height, :width, :depth, :weight, :distance)
  end

end
