class CurrenciesController < ApplicationController
  DEFAULT_LIMIT = 25
  LARGEST_LIMIT = 100

  def index
    @start = params[:start].to_i.abs
    @limit = params[:count].to_i.abs
    @limit = @limit.zero? ? DEFAULT_LIMIT : [@limit, LARGEST_LIMIT].min
    @first_time = !params[:continue]

    @currencies = Currency.unscoped.order(:id).offset(@start).limit(@limit)

    output =
    {
      data: @currencies.map do |currency|
        {
          id:    currency.id,
          name:  currency.name,
          value: currency.to_s,
        }
      end,
      pos: @start,
    }
    output.merge! total_count: @currencies.unscoped.count if @first_time

    render json: output
  end
end
