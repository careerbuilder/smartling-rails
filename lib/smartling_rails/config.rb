module SmartlingRails
  class Config
    attr_accessor :api_key, :project_id, :locales

    def initialize
      #TODO source from yaml file
      puts "locales should source from a yaml file"
      @locales = {French: {smartling:'fr-FR', careerbuilder:'fr-fr'},
              German: {smartling:'de-DE', careerbuilder:'de-de'},
              Dutch: {smartling:'nl-NL', careerbuilder:'nl-nl'},
              Italian: {smartling:'it-IT', careerbuilder:'it-it'},
              Swedish: {smartling:'sv-SE', careerbuilder:'se-se'},
              Chinese: {smartling:'zh-CN', careerbuilder:'zh-cn'},
              Spanish: {smartling:'es-ES', careerbuilder:'es-es'},
              FrenchCanadian: {smartling:'fr-CA', careerbuilder:'fr-ca'},
              Greek: {smartling:'el-GR', careerbuilder:'gr-gr'}}
      import_env_variables()
    end

    def import_env_variables
      File.open(".env", "rb") do |f|
        f.each_line do |line|
          key_val = line.split("=")
          @api_key = key_val[1].chop if key_val[0] == 'SMARTLING_API_KEY'
          @project_id = key_val[1].chop if key_val[0] == 'SMARTLING_PROJECT_ID'
        end
      end
    end

  end
end
