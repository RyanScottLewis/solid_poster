require "image"
require "conversion_helpers"

# Generate Image instances from a given path
class ImageFactory

  include ConversionHelpers

  def self.call(*input_paths)
    new.call(*input_paths)
  end

  def call(*input_paths)
    images = []

    input_paths.each do |input_path|
      input_path, output_dir, filename = explode_input_path(input_path)

      if icon?(input_path)
        images += generate_icons(input_path, output_dir, filename)
      else
        images << generate_poster(input_path, output_dir, filename)
      end
    end

    images
  end

  protected

  def explode_input_path(input_path)
    input_path = convert_pathname(input_path)
    output_dir = input_path.dirname.sub('source', 'images')
    filename   = input_path.basename(input_path.extname).to_s

    [input_path, output_dir, filename]
  end

  def icon?(path)
    path.dirname.basename.to_s == 'icons'
  end

  def generate_icons(input_path, output_dir, filename)
    (5..10).map do |power|
      size        = 2 ** power
      output_path = output_dir.join("#{filename}-#{size}.png")

      Image.new(input_path: input_path, output_path: output_path, width: size, height: size)
    end
  end

  def generate_poster(input_path, output_dir, filename)
    output_path = output_dir.join("#{filename}.png")

    Image.new(input_path: input_path, output_path: output_path, width: 1920)
  end

end
