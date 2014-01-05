require 'find'
require 'digest'

class Collector

  def collect(path)
    result = Array.new

    Find.find(path) do |file|
      next if File.directory?(file)
      result << extract_file_infos(file)
    end

    result
  end


  private
  def extract_file_infos(file_path)
    directory_name = File.dirname(file_path)
    file_name = File.basename(file_path)

    entry = FileEntry.new(directory_name, file_name)
    entry.last_modified= File.atime(file_path)
    entry.size = File.size(file_path)
    entry.checksum = Digest::SHA2.file(file_path).hexdigest

    entry
  end
end