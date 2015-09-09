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
