module SmartlingRails
  class SmartlingFile
    attr_accessor :file_contents, :locale_codes

    def initialize(file_contents, locale_codes)
      @file_contents = file_contents
      @locale_codes = locale_codes
    end

    def fix_file_issues
      puts 'Fixing Issues:'
      fix_tab_size()
      fix_space_after_tree_node()
      fix_first_line_dashes()
      fix_locale_root_node()
    end
    
    def fix_tab_size
      puts '  fixing tabs from 4 spaces to 2 space'
      @file_contents.gsub!('    ', '  ')
    end

    def fix_space_after_tree_node
      puts '  removing space after branch root : \\n to :\\n'
      @file_contents.gsub!(/: \n/,":\n")
    end

    def fix_first_line_dashes
      puts '  remove "---" from first line'
      if @file_contents.lines.first.match(/---\n/)
        @file_contents.sub!(/---\n/,"")
        puts '  yes, replaced dashes'
      end

    end
    
    def fix_locale_root_node
      puts '  converting smartling locale code to CB locale code'
      @file_contents.sub!(locale_codes['smartling'],locale_codes['custom'])
    end
    
    def print_contents
      puts @file_contents
    end
  end
end
