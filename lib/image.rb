require "image_exporter"
require "conversion_helpers"

# An image structure defining input/output paths and output dimensions
class Image

  include ConversionHelpers

  def initialize(attributes={})
    attributes = attributes.to_h

    attributes.each { |attribute, value| send("#{attribute}=", value) }
  end

  attr_reader :input_path

  def input_path=(value)
    @input_path = convert_pathname(value)
  end

  attr_reader :output_path

  def output_path=(value)
    @output_path = convert_pathname(value)
  end

  attr_reader :width

  def width=(value)
    @width = value.to_i
  end

  attr_reader :height

  def height=(value)
    @height = value.to_i
  end

  def export
    ImageExporter.call(self)
  end

end
