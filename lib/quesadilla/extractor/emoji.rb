# encoding: UTF-8

module Quesadilla
  class Extractor
    # Extract named emoji.
    #
    # This module has no public methods.
    module Emoji
    private

      require 'named_emoji'

      # Emoji colon-syntax regex
      EMOJI_COLON_REGEX = %r{:([a-zA-Z0-9_\-\+]+):}.freeze

      def replace_emoji
        codes = {}

        # Replace codes with shas
        i = 0
        while match = @original_text.match(Markdown::CODE_REGEX)
          original = match[0]
          key = Digest::SHA1.hexdigest("#{original}-#{i}")
          codes[key] = original
          @original_text.sub!(original, key)
          i += 1
        end

        # Replace emojis
        while match = @original_text.match(EMOJI_COLON_REGEX)
          sym = match[1].downcase.to_sym
          next unless NamedEmoji.emojis.keys.include?(sym)
          @original_text.sub!(match[0], NamedEmoji.emojis[sym])
        end

        # Unreplace codes
        codes.each do |key, value|
          @original_text.sub!(key, value)
        end
      end
    end
  end
end
