require 'find'
require 'digest'
require 'pathname'
require 'methadone'

class Collector
  include Methadone::CLILogging

  def collect(path)
    result = Array.new
    @pathname = Pathname.new(path)

    Find.find(path) do |file|
      if File.directory?(file)
        info "skipping #{file}"
        next
      end
      result << extract_file_infos(file)
    end

    result
  end


  private
  def extract_file_infos(file_path)
    directory_name = create_relative_path(file_path)
    file_name = File.basename(file_path)

    begin
      entry = FileEntry.new(directory_name, file_name)
      entry.last_modified= File.atime(file_path)
      entry.size = File.size(file_path)
      entry.checksum = Digest::SHA2.file(file_path).hexdigest
    rescue => file_error
      error ("error with file '#{file_path}': #{file_error}")
    end
    entry
  end

  def create_relative_path(file_path)
    pathname_for_file = Pathname.new(file_path)
    relative_path = pathname_for_file.relative_path_from(@pathname)
    relative_path.dirname.to_s
  end
end