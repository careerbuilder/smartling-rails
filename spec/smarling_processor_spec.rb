require 'spec_helper'

module SmartlingRails
  describe SmartlingProcessor do
    let(:SmartlingProcessor) { SmartlingProcessor.new }
    describe 'get_file_statuses' do
      it 'should loop over locales and check each status' do
        expect(1).to eq 2
      end
    end
  end
end
 