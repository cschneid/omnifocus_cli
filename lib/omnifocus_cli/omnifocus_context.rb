module OmnifocusCLI
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
end
