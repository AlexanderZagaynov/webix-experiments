# frozen_string_literal: true

class Currency < ApplicationRecord
  def to_s
    @to_s = "#{name} (#{id})" unless defined? @to_s and (changes.keys & %w[name id]).empty?
    @to_s
  end
end
