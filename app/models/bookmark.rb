# frozen_string_literal: true

class Bookmark < ApplicationRecord
  belongs_to :book

  validates :page, presence: true, numericality: true
end
