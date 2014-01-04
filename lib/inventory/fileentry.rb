class FileEntry
  attr_accessor :path, :name, :checksum

  def initialize(path, name)
    @path = path
    @name = name
  end

  def last_modified=(date)
    @last_modified = date.strftime("%FT%T%:z")
  end

  def last_modified
    DateTime.iso8601(@last_modified)
  end
end