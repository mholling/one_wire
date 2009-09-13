module OneWire
  class Directory
    include Retry
    # include Enumerable
    
    def initialize(path, options = {})
      @path = path
      dirall = options.has_key?(:dir_all) ? options[:dirall] : Config.dirall
      @entries = dirall ?
        with_retry { Transaction.dirall(path) }.response.data.split(",") :
        with_retry { Transaction.dir(path) }.response.map { |r| r.data }
    end
    
    def directories
      @directories ||= @entries.collect do |entry|
        begin
          Directory.new(entry)
        rescue Errno::ENOTDIR
          nil
        end
      end.compact
    end
    
    def members
      @members ||= @entries - directories.map { |directory| directory.path }
    end
    
    attr_reader :path
    
    def ls
      [ "+ " + @path.split("/").last.to_s ] +
      members.map { |member| "  . " + member.split("/").last } +
      directories.map { |directory| "  - " + directory.path.split("/").last }
    end
    
    def tree
      [ "+ " + @path.split("/").last.to_s ] +
      members.map { |member| "  . " + member.split("/").last } +
      directories.map { |directory| directory.tree.map { |line| "  #{line}"} }.flatten
    end
    
    def to_s
      ls.join("\n")
    end
    
    def inspect
      to_s
    end
  end
end
