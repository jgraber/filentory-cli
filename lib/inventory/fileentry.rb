class FileEntry
  attr_accessor :path, :name, :checksum, :size, :metadata

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

  def to_s
    @path + @name + " (" + @size.to_s + ") - " + @last_modified
  end
end