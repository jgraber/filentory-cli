require 'streamio-ffmpeg'

class VideoExtractor

  def metadata_for_file(file_path)
    movie = FFMPEG::Movie.new(file_path)
    
    result = Hash.new
    
    methods = define_fields
    methods.each{|m| result[m] = movie.send(m)}
    
    result.delete_if { |k, v| v.nil? || v.to_s.empty?}
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
     "creation_time",
     "dar",
     "duration",
     "resolution",
     "rotation",
     "video_bitrate",
     "video_codec",
     "video_stream",
     "width",
     "height"]
  end

end