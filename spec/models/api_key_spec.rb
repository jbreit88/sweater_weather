require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:token) }

  end

  describe 'relationships' do
    it { should belong_to(:user) }
  end
end
