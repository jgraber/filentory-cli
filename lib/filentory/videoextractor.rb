require 'streamio-ffmpeg'

class VideoExtractor

  # Extracts the metadata of a file at a given path in the file system.
  def metadata_for_file(file_path)
    movie = FFMPEG::Movie.new(file_path)
    
    result = Hash.new
    
    methods = define_fields
    methods.each{|m| result[m] = movie.send(m)}
    add_creation_time(movie, result)

    result.delete_if { |k, v| v.nil? || v.to_s.empty?}
  end

  # Check if VideoExtractor handles the file extension.
  # Example: VideoExtractor.handles? ".mov" => returns true
  def self.handles?(file_extension)
    [".avi", ".mpeg", ".mov", ".mp4", ".flv"].include? file_extension
  end

  private
  def define_fields
    ["audio_bitrate",
     "audio_channels",
     "audio_codec",
     "audio_sample_rate",
     "audio_stream",
     "bitrate",
     "colorspace",
     "dar",
     "duration",
     "resolution",
     "rotation",
     "video_bitrate",
     "video_codec",
     "video_stream",
     "width",
     "height",
     "valid?"]
  end

  def add_creation_time(movie, result)
    created = movie.send("creation_time")
    result["creation_time"] = format_date(created)
  end

  def format_date(date)
    date.strftime("%FT%T+00:00") unless date.nil?
  end
end