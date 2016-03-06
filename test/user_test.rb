require_relative 'test_helper'
require_relative '../models/user'

describe User do
  it 'should be connected to test DB' do
    User.create name: 'Joe'
    assert 'Joe', User.first.name
  end
end
