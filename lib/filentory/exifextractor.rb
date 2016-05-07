require 'exifr'
require 'xmp'

class ExifExtractor

  # Extracts the metadata of a file at a given path in the file system.
  def metadata_for_file(file_path)
    img = EXIFR::JPEG.new(file_path)

    xmpValues = Hash.new

    extract_xmp_meta_data(img, xmpValues)
    extract_exif_main_meta_data(img, xmpValues)       
    extract_gps_infos(img, xmpValues)

    xmpValues.delete_if { |k, v| v.nil? || v.to_s.empty?}
  rescue => error
    puts "metadata_for_file #{file_path} failed: #{error}"
    Hash.new
  end

  # Check if ExifExtractor handles the file extension.
  # Example: ExifExtractor.handles? ".jpg" => returns true
  def self.handles?(file_extension)
    [".jpg", ".jpeg", ".tiff"].include? file_extension
  end

  private
  def extract_xmp_meta_data(img, xmpValues)
    xmp = XMP.parse(img)
    xmp.namespaces.each do |namespace_name|
      namespace = xmp.send(namespace_name)
      extract_namespace_attributes(namespace, xmpValues)
    end
  rescue => error
    #puts error
  end

  def extract_namespace_attributes(namespace, xmpValues)
    namespace.attributes.each do |attr|
      begin
        returnval = namespace.send(attr)#.inspect
        #puts "returnval: #{returnval}"
        answer = returnval.scrub("*")
        xmpValues["#{namespace_name}.#{attr}"] = answer.strip.to_s[0...250]
      rescue => error
        #puts error
      end
    end
  end

  def extract_exif_main_meta_data(img, xmpValues)
    xmpValues["exif.model"] = cleanup_description(img.model)
    xmpValues["exif.make"] =  cleanup_description(img.make)
    xmpValues["exif.artist"] = cleanup_description(img.artist)
    xmpValues["exif.date_time"] = format_date(img.date_time)
    xmpValues["exif.date_time_original"] = format_date(img.date_time_original)
    xmpValues["exif.width"] = img.width
    xmpValues["exif.height"] = img.height 
  rescue => error
    #puts error
  end

  def cleanup_metadata(value)
    value.scrub("*").strip unless value.nil?
  end

  def cleanup_description(value)
    cleanup_metadata(value.force_encoding('UTF-8')).to_s[0...250]  unless value.nil?
  end

  def extract_gps_infos(img, xmpValues)
    if img.gps
      
      if !img.gps.latitude.nil? && !img.gps.latitude.nan? then
        xmpValues["exif.gps.latitude"] = img.gps.latitude
      end

      if !img.gps.longitude.nil? && !img.gps.longitude.nan? then
        xmpValues["exif.gps.longitude"] = img.gps.longitude
      end
      
      if !img.gps.altitude.nil? && !img.gps.altitude.nan? then
        xmpValues["exif.gps.altitude"] = img.gps.altitude
      end
    end
  end

  def format_date(date)
    date.strftime("%FT%T+00:00") unless date.nil?
  rescue
      nil
  end
end