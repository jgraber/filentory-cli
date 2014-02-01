# FileEntry is used as a simple container to store information 
# about the file like metadata, size or checksum.
class FileEntry
  attr_accessor :path, :name, :checksum, :size, :metadata

  def initialize(path, name)
    @path = path
    @name = name
  end

  # Set the last_modified date. It uses the date.strftime method 
  # to convert it in a ISO 8601 format to be radable in JSON.
  def last_modified=(date)
    @last_modified = date.strftime("%FT%T%:z")
  end

  # Get the last_modified date 
  def last_modified
    DateTime.iso8601(@last_modified)
  end

  # Overrides to_s to get a human readable output.
  def to_s
    @path + @name + " (" + @size.to_s + ") - " + @last_modified
  end
end