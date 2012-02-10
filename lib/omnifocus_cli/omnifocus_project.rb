module OmnifocusCLI
  class OmnifocusProject
    attr_accessor :sbProject

    def initialize(sbProject)
      @sbProject = sbProject
    end

    def created_at
      @sbProject.creationDate
    end

    def updated_at
      @sbProject.modificationDate
    end

    def start_date
      @sbProject.startDate
    end

    def end_date
      @sbProject.endDate
    end

    def completion_date
      @sbProject.completionDate
    end
    def estimated_minutes
      @sbProject.estimatedMinutes
    end

    def repetition
      @sbProject.repetition
    end

    def number_of_tasks
      @sbProject.numberOfTasks
    end

    def number_of_available_tasks
      @sbProject.numberOfAvailableTasks
    end

    def number_of_completed_tasks
      @sbProject.numberOfCompletedTasks
    end

    def omnifocus_id
      @sbProject.id 
    end

    def name
      @sbProject.name
    end

    def note
      @sbProject.note
    end

    def context
      OmnifocusCLI::OmnifocusProject.new(@sbProject.context)
    end

    def next_task
      OmnifocusCLI::OmnifocusTask.new(@sbProject.nextTask)
    end

    def root_task
      OmnifocusCLI::OmnifocusTask.new(@sbProject.rootTask)
    end

    def last_review_date
      @sbProject.lastReviewDate
    end

    def next_review_date
      @sbProject.nextReviewDate
    end

    # TODO: What does this return
    def review_interval
      @sbProject.reviewInterval
    end

    def completed?
      @sbProject.completed
    end

    def completed_by_children?
      @sbProject.completedByChildren
    end

    def sequential?
      @sbProject.sequential
    end

    def flagged?
      @sbProject.flagged
    end

    def blocked?
      @sbProject.blocked
    end

    def status
      @sbProject.status
    end

    def singleton_actions?
      @sbProject.singletonActionHolder
    end

    def default_singleton_action_holder?
      @sbProject.defaultSingletonActionHolder
    end

    def folder
      OmnifocusCLI::OmnifocusProject.new(@sbProject.folder)
    end

    def container
      @sbProject.container
    end

    def containing_document
      @sbProject.containingDocument
    end

    def location
      @sbProject.location
    end
  end
end
