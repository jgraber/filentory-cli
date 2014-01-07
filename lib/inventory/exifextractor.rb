require 'exifr'
require 'xmp'

class ExifExtractor

  def self.metadata_for_file(file_path)
    img = EXIFR::JPEG.new(file_path)
    xmp = XMP.parse(img)
    
    xmpValues = Hash.new
    xmp.namespaces.each do |namespace_name|
        namespace = xmp.send(namespace_name)
        namespace.attributes.each do |attr|
        begin
        xmpValues["#{namespace_name}.#{attr}"] = namespace.send(attr)#.inspect
        rescue
        end
      end
    end   
    
    xmpValues["exif.model"] =  img.model
    xmpValues["exif.artist"] = img.artist
    xmpValues["exif.date_time"] = img.date_time
    xmpValues["exif.date_time_original"] = img.date_time_original
    xmpValues["exif.width"] = img.width
    xmpValues["exif.height"] = img.height
    
    if img.gps
      xmpValues["exif.gps.latitude"] = img.gps.latitude
      xmpValues["exif.gps.longitude"] = img.gps.longitude
      xmpValues["exif.gps.altitude"] = img.gps.altitude
    end
    
    xmpValues.delete_if { |k, v| v.nil? || v.to_s.empty?}
  rescue => error
    Hash.new
  end

end