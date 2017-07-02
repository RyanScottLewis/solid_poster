$:.unshift(File.expand_path('../lib', __FILE__))
require 'image_factory'

# Constants

ROOT_PATH     = Pathname.new(__FILE__).dirname.relative_path_from(Pathname.pwd)
VECTOR_PATHS  = Pathname.glob(ROOT_PATH.join('source', '**', '*.svg'))
VECTOR_IMAGES = ImageFactory.call(*VECTOR_PATHS)

# Tasks
VECTOR_IMAGES.each do |image|
  directory image.input_path.dirname
  directory image.output_path.dirname

  dependencies = [image.input_path, image.input_path.dirname, image.output_path.dirname]
  file(image.output_path => dependencies) { image.export }
end

desc 'Build all raster images'
multitask build: VECTOR_IMAGES.map(&:output_path)

task default: :build
