require 'exifr'
require 'xmp'

class ExifExtractor

  def metadata_for_file(file_path)
    img = EXIFR::JPEG.new(file_path)

    xmpValues = Hash.new

    extract_xmp_meta_data(img, xmpValues)
    extract_exif_main_meta_data(img, xmpValues)       
    extract_gps_infos(img, xmpValues)

    xmpValues.delete_if { |k, v| v.nil? || v.to_s.empty?}
  rescue => error
    Hash.new
  end

  private
  def extract_xmp_meta_data(img, xmpValues)
    xmp = XMP.parse(img)
    xmp.namespaces.each do |namespace_name|
        namespace = xmp.send(namespace_name)
        namespace.attributes.each do |attr|
        begin
        xmpValues["#{namespace_name}.#{attr}"] = namespace.send(attr)#.inspect
        rescue
        end
      end
    end   
  end

  def extract_exif_main_meta_data(img, xmpValues)
    xmpValues["exif.model"] =  img.model
    xmpValues["exif.artist"] = img.artist
    xmpValues["exif.date_time"] = format_date(img.date_time)
    xmpValues["exif.date_time_original"] = format_date(img.date_time_original)
    xmpValues["exif.width"] = img.width
    xmpValues["exif.height"] = img.height
  end


  def extract_gps_infos(img, xmpValues)
    if img.gps
      xmpValues["exif.gps.latitude"] = img.gps.latitude
      xmpValues["exif.gps.longitude"] = img.gps.longitude
      xmpValues["exif.gps.altitude"] = img.gps.altitude
    end
  end

  def format_date(date)
    date.strftime("%FT%T+00:00") unless date.nil?
  end
end