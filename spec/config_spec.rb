# frozen_string_literal: true

require 'helper'

describe InciScore::Config do
  it 'must return catalog data' do
    _(InciScore::Config::CATALOG).wont_be_empty
  end

  it 'must return hazards data' do
    _(InciScore::Config::HAZARDS).wont_be_empty
  end
end
