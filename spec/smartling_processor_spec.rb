require 'spec_helper'

module SmartlingRails
  describe SmartlingProcessor do
    
    let(:processor) { SmartlingRails::SmartlingProcessor.new}
    let(:my_smartling) {double('my_smartling', :status => nil)}
    let(:mock_french_locale) { {smartling: 'fr-FR', careerbuilder: 'fr-fr'} }
    let(:mock_raw_french_yaml) { "---\nfr-FR:\n    test: \n        hello: 'bonjour'" }
    let(:mock_raw_smartling_file) { SmartlingRails::SmartlingFile.new(mock_raw_french_yaml, mock_french_locale) }
    before {
      SmartlingRails.configure { |config| config.rails_app_name = 'mock-app' }
      processor.my_smartling = my_smartling
    }

    describe 'initialize' do
      it 'xxx' do
      end
    end

    describe 'get_file_statuses' do
      it 'loops over locales and checks each one' do
        processor.should_receive(:check_file_status).at_least(SmartlingRails.configuration.locales.count).times
        processor.get_file_statuses
      end
    end

    describe 'supported_locales' do
      it 'should return an output friendly array of supported locales' do
        expect(processor.supported_locales).to eq ["French fr-FR", "German de-DE", "Dutch nl-NL", "Italian it-IT", "Swedish sv-SE", "Chinese zh-CN", "Spanish es-ES", "FrenchCanadian fr-CA", "Greek el-GR"]
      end
    end

    describe 'check_file_status' do
      it 'gracefully handles lack of smartling credentials' do
        allow($stdout).to receive(:puts) { "mock puts" }
        allow(my_smartling).to receive(:status) { raise "Missing parameters: [:apiKey, :projectId]" }
        processor.check_file_status('fr-FR')
        expect($stdout).to have_received(:puts).with('Missing parameters: [:apiKey, :projectId]')
      end
      it 'knows when processing is comlete' do
        allow($stdout).to receive(:puts) { "mock puts" }
        result = {"fileUri"=>"/files/adam-test-resume-[ver-interim-translations]-en-us-.yml", "lastUploaded"=>"2015-02-21T19:56:23", "stringCount"=>161, "fileType"=>"yaml", "wordCount"=>664, "callbackUrl"=>nil, "approvedStringCount"=>161, "completedStringCount"=>161}
        allow(my_smartling).to receive(:status).and_return(result)
        processor.check_file_status('fr-FR')
        expect($stdout).to have_received(:puts).with('fr-FR completed: true (161 / 161)')
      end
      it 'knows when processing is not comlete' do
        allow($stdout).to receive(:puts) { "mock puts" }
        result = {"fileUri"=>"/files/adam-test-resume-[ver-interim-translations]-en-us-.yml", "lastUploaded"=>"2015-02-21T19:56:23", "stringCount"=>161, "fileType"=>"yaml", "wordCount"=>664, "callbackUrl"=>nil, "approvedStringCount"=>10, "completedStringCount"=>16}
        allow(my_smartling).to receive(:status).and_return(result)
        processor.check_file_status('fr-FR')
        expect($stdout).to have_received(:puts).with('fr-FR completed: false (16 / 161)')
      end
    end

    describe 'put_files' do
      it 'calls upload_english_file' do
        allow(processor).to receive(:upload_english_file) { "mock puts" }
        processor.put_files()
        expect(processor).to have_received(:upload_english_file).once
      end
    end

    describe 'upload_english_file' do
      it 'calls smartling upload with the correct files and types' do
        processor.should_receive(:`).at_least(1).times.with("git branch").and_return("* mock-branch\n  master\n  update-readme")
        allow($stdout).to receive(:puts) { "mock puts" }
        allow(my_smartling).to receive(:upload).and_return('')
        processor.upload_english_file()
        expect(my_smartling).to have_received(:upload).once.with('config/locales/en-us.yml', '/files/adam-test-resume-[mock-branch]-en-us.yml', 'YAML')
      end
    end

    describe 'local_file_path_for_locale' do
      it 'correctly defines the local file path besed on hostsite' do
        expect(processor.local_file_path_for_locale('de-de')).to eq "config/locales/de-de.yml"
        expect(processor.local_file_path_for_locale('en-ca')).to eq "config/locales/en-ca.yml"
      end
    end

    describe 'upload_file_path' do
      it 'returns the constructed path for smartling' do
        allow(processor).to receive(:get_current_branch).and_return("mock-branch")
        expect(processor.upload_file_path).to eq "/files/[mock-app]-[mock_branch]-en-us.yml"
      end
    end

    describe 'get_files' do
      it 'should call fetch_fix_and_save_file_for_locale for each locale' do
        processor.should_receive(:fetch_fix_and_save_file_for_locale).at_least(SmartlingRails.configuration.locales.count).times
        processor.get_files
      end
    end

    describe 'fetch_fix_and_save_file_for_locale' do
      it 'calls get_file_for_locale' do
        allow(processor).to receive(:get_file_for_locale).and_return(mock_raw_smartling_file)
        allow(processor).to receive(:save_to_local_file).and_return('')
        processor.fetch_fix_and_save_file_for_locale(mock_french_locale)
        expect(processor).to have_received(:get_file_for_locale).with(mock_french_locale)
      end
      it 'calls fix_file_issues on the smartling_file' do
        allow(processor).to receive(:get_file_for_locale).and_return(mock_raw_smartling_file)
        allow(processor).to receive(:save_to_local_file).and_return('')
        processor.fetch_fix_and_save_file_for_locale(mock_french_locale)
        expect(mock_raw_smartling_file).to have_received(:fix_file_issues)
      end
      it 'retrieves the file from smartling' do
        allow(processor).to receive(:get_file_for_locale).and_return(mock_raw_smartling_file)
        allow(processor).to receive(:save_to_local_file).and_return('')
        processor.fetch_fix_and_save_file_for_locale(mock_french_locale)
        expect(processor).to have_received(:save_to_local_file)
      end
    end

    describe 'get_file_for_locale' do
      it 'initializes a smartling_file object' do
        smartling_file = processor.get_file_for_locale(SmartlingRails.locales[:French])
        expect(smartling_file.file_contents).to eq ''
        expect(smartling_file.locale_codes).to eq mock_french_locale
      end

      it 'initializes a smartling_file object' do
        allow(my_smartling).to receive(:download).and_return('file from smartling')
        smartling_file = processor.get_file_for_locale(SmartlingRails.locales[:French])
        expect(smartling_file.file_contents).to eq 'file from smartling'
      end
    end

    describe 'save_to_local_file' do
      it 'calls file open with the right params' do
        allow(File).to receive(:open)
        processor.save_to_local_file('file contnents', 'fr-fr')
        expect(File).to have_received(:open)
      end
    end

    describe 'get_current_branch' do
      it 'returns the branch name indicated by * from the "git brach" command' do
        processor.should_receive(:`).at_least(1).times.with("git branch").and_return("* adding-tests\n  master\n  update-readme")
        expect(processor.get_current_branch).to eq 'adding-tests'
      end
    end
    
  end
end
 