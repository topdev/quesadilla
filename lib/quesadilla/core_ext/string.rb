# String additions
class String
  # Truncate method from ActiveSupport.
  # @param truncate_at [Fixnum] number of characters to truncate after
  # @param options [Hash] optional options hash
  # @option options separator [String] truncate text only at a certain separator strings
  # @option options omission [String] string to add at the end to endicated truncated text. Defaults to '...'
  # @return [String] truncated string
  def q_truncate(truncate_at, options = {})
    return dup unless length > truncate_at

    # Default omission to '...'
    options[:omission] ||= '...'

    # Account for the omission string in the truncated length
    truncate_at -= options[:omission].length

    # Calculate end index
    stop = if options[:separator]
      rindex(options[:separator], truncate_at) || truncate_at
    else
      truncate_at
    end

    # Return the trucnated string plus the omission string
    self[0...stop] + options[:omission]
  end
end
