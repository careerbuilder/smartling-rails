require 'spec_helper'

module SmartlingRails
  describe 'helpers' do
    
    describe 'print_msg' do
      it 'calls puts when padding not asked for' do
        allow($stdout).to receive(:puts) { "mock puts" }
        SmartlingRails.print_msg 'hello world'
        expect($stdout).to have_received(:puts).once
        expect($stdout).to have_received(:puts).with('hello world')
      end
      it 'calls puts twice when padding asked for' do
        allow($stdout).to receive(:puts) { "mock puts" }
        SmartlingRails.print_msg 'hello world', true
        expect($stdout).to have_received(:puts).twice
        expect($stdout).to have_received(:puts).with()
        expect($stdout).to have_received(:puts).with('hello world')
      end
    end
    
  end
end
 