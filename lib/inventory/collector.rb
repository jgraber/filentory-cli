require 'find'
require 'digest'
#require 'methadone/cli_logger'
require 'methadone'

class Collector
  include Methadone::CLILogging

  def collect(path)
    result = Array.new

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
    directory_name = File.dirname(file_path)
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
end