module SmartlingRails
  #def self.command_aliases
  #  {
  #    "s" => "status",
  #    "g" => "get",
  #    "p" => "put",
  #    "h" => "--help"
  #  }
  #end

  def self.print_msg(msg, padding = false)
    puts if padding
    puts msg
  end

  #def self.command_is(value)
  #  return @command == command_aliases[value]
  #end

end
