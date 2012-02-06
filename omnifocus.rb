require "rubygems"
require 'trollop'

framework 'Foundation'
framework 'ScriptingBridge'

bridge_file = 'Omnifocus.bridgesupport'
load_bridge_support_file bridge_file

class Omnifocus
  attr_accessor :omnifocus

  def initialize
    bundle_id = 'com.omnigroup.OmniFocus'
    @omnifocus = SBApplication.applicationWithBundleIdentifier(bundle_id)
  end

  def document
    @omnifocus.defaultDocument
  end

  def inbox_tasks
    document.inboxTasks.map{ |task| OmnifocusCLI::OmnifocusTask.new(task) }
  end

  def folders
    document.folders.map{ |folder| OmnifocusCLI::OmnifocusFolder.new(folder) }
  end

  def contexts
    document.contexts.map{ |context| OmnifocusCLI::OmnifocusContext.new(context) }
  end
end

module OmnifocusCLI
  class OmnifocusTask
    attr_accessor :sbTask
    def initialize(sbTask)
      @sbTask = sbTask
    end

    def name
      @sbTask.name
    end
  end

  class OmnifocusFolder
    attr_accessor :sbFolder

    def initialize(sbFolder)
      @sbFolder = sbFolder
    end

    def name
      @sbFolder.name
    end

    def note
      @sbFolder.note
    end

    def hidden?
      @sbFolder.hidden
    end

    def effectively_hidden?
      @sbFolder.effectively_hidden
    end

    def container
      @sbFolder.container
    end

    def containing_document
      @sbFolder.containingDocument
    end

    def created_at
      @sbFolder.creationDate
    end

    def updated_at
      @sbFolder.modificationDate
    end

    def folders
      @sbFolder.folders.map{ |folder| OmnifocusCLI::OmnifocusFolder.new(folder) }
    end
  end

  class OmnifocusContext
    attr_accessor :sbContext

    def initialize(sbContext)
      @sbContext = sbContext
    end

    def omnifocus_id
      @sbContext.id 
    end

    def name
      @sbContext.name
    end

    def note
      @sbContext.note
    end

    def allows_next_action?
      @sbContext.allowsNextAction
    end

    def hidden?
      @sbContext.hidden
    end

    def effectively_hidden?
      @sbContext.effectivelyHidden
    end

    def contexts
      @sbContext.contexts.map{ |context| OmnifocusCLI::OmnifocusContext.new(context) }
    end

    def available_tasks
      @sbContext.availableTasks.map{ |task| OmnifocusCLI::OmnifocusTask.new(task) }
    end

    def remainingTasks
      @sbContext.remainingTasks.map{ |task| OmnifocusCLI::OmnifocusTask.new(task) }
    end

    def available_next_task_count
      @sbContext.availableNextTaskCount
    end

    def remaining_task_count
      @sbContext.RemainingTaskCount
    end

    def container
      @sbContext.container
    end

    def containing_document
      @sbContext.containingDocument
    end

    def location
      @sbContext.location
    end
  end

  module Presenters
    class NestedPresenter
      attr_accessor :root
      def initialize(root=Omnifocus.new.document)
        @root = root
      end

      def display(nesting_method, print_method=:name)
        __display(@root, nesting_method, print_method, 0).join("\n")
      end

      def __display(node, nesting_method, print_method, nesting_level)
        children = node.send(nesting_method)
        [print_node(node, print_method, nesting_level)] + children.map { |child| __display(child, nesting_method, print_method, (nesting_level + 2)) }
      end

      def print_node(node, print_method, nesting_level)
        spaces = " " * nesting_level
        spaces + node.send(print_method)
      end
    end
  end
end

opts = Trollop::options do
  version "0.01 (c) 2012 Chris Schneider"
  banner <<-EOS
Command Line Interface to Omnifocus

Usage:
       omnifocus.rb [options]

where [options] are:
EOS

  opt :contexts, "Display Contexts"
  opt :folders,  "Display Folders"
end

puts OmnifocusCLI::Presenters::NestedPresenter.new.display(:contexts) if opts[:contexts]
puts OmnifocusCLI::Presenters::NestedPresenter.new.display(:folders)  if opts[:folders]

