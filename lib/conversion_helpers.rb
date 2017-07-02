require "pathname"

# Simple helper mixin for converting values
module ConversionHelpers

  protected

  def convert_pathname(value)
    value.is_a?(Pathname) ? value : Pathname.new(value)
  end

end
