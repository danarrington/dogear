# frozen_string_literal: true

require 'spec_helper'

describe Bookmark do
  it 'is valid with page' do
    expect(build(:bookmark)).to be_valid
  end

  it 'is invalid without page' do
    expect(build(:bookmark, page: nil)).to be_invalid
  end
end
