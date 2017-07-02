require "open3"

# Calls Inkscape from the command-line to convert SVG vector images to PNG raster images using a Image structure
class ImageExporter

  def self.call(image)
    new(image).call
  end

  def initialize(image)
    @image = image
  end

  def call
    command = build_command

    run_command(command)
  end

  protected

  def build_command
    command = []

    command << 'inkscape'
    command << '--without-gui'
    command << "--export-width #{@image.width}"   unless @image.width.nil?
    command << "--export-height #{@image.height}" unless @image.height.nil?
    command << "--export-png '#{@image.output_path.expand_path}'"
    command << "'#{@image.input_path.expand_path}'"

    command.join(' ')
  end

  def run_command(command)
    puts("Started: #{@image.input_path} > #{@image.output_path}")
    stdout, stderr, status = Open3.capture3(command)

    if status.success?
      puts("Finished: #{@image.input_path} > #{@image.output_path}")
    else
      puts("Error: #{@image.input_path} > #{@image.output_path}")

      message = stderr.lines.map { |line| "  #{line}" }.join # Indent the error lines
      puts message
    end
  end

end
