class MatchMarketOutcomeName
  def self.call(text, match, market_id, specifiers = {})
    cache_key = ["match_#{match.id}_market_#{market_id}_#{text}#{specifiers.to_a.flatten.join('/')}_name"]
    Rails.cache.fetch(cache_key) do
      @match = match
      text_with_replacements = text.dup
      text.scan(::Market::NAME_REGEX).each do |m|
        # Calculate value to be replaced in market or outcome name from specifiers passed
        replacing_value = calculate_replacing_value(m[1], specifiers)
        text_with_replacements.gsub!(m[0], replacing_value) if replacing_value
      end
      text_with_replacements
    end
  end

  def self.comp
    # return @competitors if @competitors.present?
    competitors = {}
    team_info = @match.team_info || []
    team_info.each do |c|
      info = c[1]
      competitor = info[:qualifier].casecmp('home').zero? ? '$competitor1' : '$competitor2'
      competitors[competitor] = info[:acronym]
    end
    competitors
  end

  # Check operator present in passed text and replace accordingly with value in specifiers hash
  # May need to add {(X+/-c)} and {%player} types too in future

  def self.calculate_replacing_value(text_to_be_replaced, specifiers)
    splitted_text_array = text_to_be_replaced.split(/\W+/)
    operator = text_to_be_replaced[0] if splitted_text_array.size > 1
    text_without_operator = splitted_text_array.last
    case operator
    when '$'
      comp[text_to_be_replaced]
    when '-'
      (-specifiers[text_without_operator].to_f).to_s
    when '+'
      specifiers[text_without_operator]
    when '!'
      specifiers[text_without_operator].to_i.ordinalize
    else
      specifiers[text_without_operator]
    end
  end
end
