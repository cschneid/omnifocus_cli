module OmnifocusCLI
  class OmnifocusTask
    attr_accessor :sbTask
    def initialize(sbTask)
      @sbTask = sbTask
    end

    def name
      @sbTask.name
    end

    def note
      @sbTask.note
    end
  end
end
