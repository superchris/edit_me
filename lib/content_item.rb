# To change this template, choose Tools | Templates
# and open the template in the editor.

module EditMe
  class ContentItem
    class << self
      attr_accessor :repo
    end

    attr_accessor :path

    def initialize(path)
      self.path = path
    end

    def full_path
      File.join(RAILS_ROOT, path)
    end

    def content
      File.read(full_path)
    end

    def repo
      self.class.repo
    end
    
    def history
      repo.log.path(path)
    end

    def update(content, message)
      File.open(full_path, "w") do |file|
        file << content
      end
      repo.add path
      repo.commit(message)
    end

    def activate_revision(sha)
      repo.checkout_file(sha, path)
    end
  end
end
