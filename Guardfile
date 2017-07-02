$:.unshift(File.expand_path('../lib', __FILE__))
require 'pmap'
require 'image_factory'

guard :shell do
  watch(%r{source/.*.svg}) do |match|
    path   = match[0]
    images = ImageFactory.call(path)

    images.peach(6, &:export) # Parallel each with 6 threads
    
    nil
  end
end
