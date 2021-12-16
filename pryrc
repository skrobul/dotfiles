Pry.config.editor = 'vim'


# Plugins
begin
  require 'awesome_print'
#   # The following line enables awesome_print for all pry output,
#   # and it also enables paging
Pry.config.print = proc {|output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)}
#   # If you want awesome_print without automatic pagination, use the line below
# Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError => err
   puts "gem install awesome_print  # <-- highly recommended"
end

if defined?(PryByebug)
  Pry.commands.alias_command 'co', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end
