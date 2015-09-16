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
  describe SmartlingFile do
    before do
      @raw_yaml = "---\nde-DE:\n    test: \n"
      @corrected_yaml = "de-de:\n  test:\n"
      @locale = { 'smartling' => 'de-DE', 'custom' => 'de-de' }
    end
    let(:smartling_file) { SmartlingFile.new(@raw_yaml, @locale) }

    describe 'initialize' do
      it 'sets file_contents' do
        expect(smartling_file.file_contents).to eq @raw_yaml
      end
      it 'sets locale_codes' do
        expect(smartling_file.locale_codes).to eq @locale
      end
    end

    describe 'fix_tab_size' do
      let(:smartling_file) { SmartlingFile.new("root:\n    sub:\n        sub_sub:", nil) }
      it 'changes four space tabs to two spaced' do
        smartling_file.fix_tab_size
        expect(smartling_file.file_contents).to eq "root:\n  sub:\n    sub_sub:"
      end
    end

    describe 'fix_space_after_tree_node' do
      let(:smartling_file) { SmartlingFile.new("root:\n  sub: \n    sub_sub:", nil) }
      it 'changes four space tabs to two spaced' do
        smartling_file.fix_space_after_tree_node
        expect(smartling_file.file_contents).to eq "root:\n  sub:\n    sub_sub:"
      end
    end

    describe 'fix_first_line_dashes' do
      let(:smartling_file) { SmartlingFile.new("---\nroot:\n  sub:\n    sub_sub: ---", nil) }
      it 'changes four space tabs to two spaced' do
        smartling_file.fix_first_line_dashes
        expect(smartling_file.file_contents).to eq "root:\n  sub:\n    sub_sub: ---"
      end
    end

    describe 'fix_locale_root_node' do
      let(:smartling_file) { SmartlingFile.new("de-DE:\n  sub:\n    sub_sub: de-DE", @locale) }
      it 'changes four space tabs to two spaced' do
        smartling_file.fix_locale_root_node
        expect(smartling_file.file_contents).to eq "de-de:\n  sub:\n    sub_sub: de-DE"
      end
    end

    describe 'fix_all_issues' do
      it 'fixes all the problems with the smartling yaml file' do
        smartling_file.fix_file_issues
        expect(smartling_file.file_contents).to eq @corrected_yaml
      end
    end

    describe 'print_contents' do
      it 'calls puts with the file_contents' do
        allow($stdout).to receive(:puts) { 'mock puts' }
        smartling_file.print_contents
        expect($stdout).to have_received(:puts).once
        expect($stdout).to have_received(:puts).with(@raw_yaml)
      end
    end
  end
end
