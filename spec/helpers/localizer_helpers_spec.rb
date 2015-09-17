# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'spec_helper'

module SmartlingRails
  describe 'helpers' do

    describe 'print_msg' do
      it 'calls puts when padding not asked for' do
        allow($stdout).to receive(:puts) { 'mock puts' }
        SmartlingRails.print_msg 'hello world'
        expect($stdout).to have_received(:puts).once
        expect($stdout).to have_received(:puts).with('hello world')
      end
      it 'calls puts twice when padding asked for' do
        allow($stdout).to receive(:puts) { 'mock puts' }
        SmartlingRails.print_msg 'hello world', true
        expect($stdout).to have_received(:puts).twice
        expect($stdout).to have_received(:puts).with
        expect($stdout).to have_received(:puts).with('hello world')
      end
    end

  end
end
