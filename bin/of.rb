require 'rubygems'
require 'trollop'
require 'omnifocus'

SUB_COMMANDS = %w(context project inbox)
global_opts = Trollop::options do
  banner <<-EOS
Command Line Interface to Omnifocus

Usage:
       omnifocus.rb [options]

where [options] are:
EOS
  stop_on SUB_COMMANDS
end

cmd = ARGV.shift # get the subcommand
cmd_opts = case cmd
  when "context" # dump list of tasks
    puts OmnifocusCLI::Presenters::TreePresenter.new.display(:contexts)
  when "folder" # dump list of folders
    puts OmnifocusCLI::Presenters::NestedPresenter.new.display(:folders)
  when "inbox"   # list all tasks in inbox
    puts OmnifocusCLI::Presenters::ListPresenter.new(Omnifocus::Root.new.inbox_tasks).display{|task| task.name}
  else
    Omnifocus::Root.new.create_task(([cmd] + ARGV).join(" "))
  end




