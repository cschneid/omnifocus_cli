require "rubygems"
require 'trollop'

require File.dirname(__FILE__) + '/omnifocus_cli/omnifocus_project'
require File.dirname(__FILE__) + '/omnifocus_cli/omnifocus_context'
require File.dirname(__FILE__) + '/omnifocus_cli/omnifocus_folder'
require File.dirname(__FILE__) + '/omnifocus_cli/omnifocus_task'
require File.dirname(__FILE__) + '/omnifocus_cli/presenters/list_presenter'
require File.dirname(__FILE__) + '/omnifocus_cli/presenters/tree_presenter'

framework 'Foundation'
framework 'ScriptingBridge'

bridge_file = File.dirname(__FILE__) + '/../Omnifocus.bridgesupport'
load_bridge_support_file bridge_file

module Omnifocus
  VERSION="0.01"

  class Root
    attr_accessor :omnifocus

    def initialize
      bundle_id = 'com.omnigroup.OmniFocus'
      @omnifocus = SBApplication.applicationWithBundleIdentifier(bundle_id)
    end

    def create_task(arg, as_single_task=false)
      tasks = omnifocus.defaultDocument.inboxTasks
      task = omnifocus.classForScriptingClass("task").alloc.initWithProperties({:name=>arg})
      tasks.addObject(task)
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

    def projects
      document.projects.map{ |project| OmnifocusCLI::OmnifocusProject.new(project) }
    end
  end
end

