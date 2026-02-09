require "ruby_llm"

RubyLLM.configure do |config|
  config.openai_api_key = Rails.application.credentials.dig(:open_ai, :api_key)
end
