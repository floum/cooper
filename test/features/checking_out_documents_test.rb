require 'test_helper'

describe 'Checking Out Documents' do
  # cooper document with one key example
  class RevisionedObject
    include Cooper::Document

    revision_field :key, type: String
  end
end
