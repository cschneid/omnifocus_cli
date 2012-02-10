module OmnifocusCLI
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
end
