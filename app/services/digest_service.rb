class DigestService
  SYSTEM_PROMPT = <<~PROMPT
    You are a feed digest generator.

    Create a concise digest from the provided chirps.

    Rules:
      - Use ONLY chirp IDs from the provided list
      - Max 3 themes
      - Max 5 dont_miss items
      - Return ONLY plain, valid JSON (no markdown) with this structure:

    {
      "themes": [
        { "title": "...", "chirp_ids": [1,2,3] }
      ],
      "dont_miss": [
        { "chirp_id": 12, "reason": "..." }
      ]
    }
  PROMPT

  def initialize(chirps:)
    @chirps = chirps
  end

  def call
    chat = RubyLLM.chat(model: "gpt-4.1-mini")

    response = chat.ask([
      { role: "system", content: SYSTEM_PROMPT },
      { role: "user", content: @chirps.to_json }
    ])

    JSON.parse(response.content)
  end

  def self.example_output
    {
      "themes" => [
        { "title" => "SpongeBob-themed humor and quotes", "chirp_ids" => [ 2, 4, 8, 10, 12, 15, 17, 22 ] },
        { "title" => "Melancholy and self-reflection", "chirp_ids" => [ 5, 11, 13, 14, 23 ] },
        { "title" => "Playful and quirky remarks", "chirp_ids" => [ 6, 7, 9, 16, 19, 21 ] }
      ],
      "dont_miss" => [
        { "chirp_id" => 12, "reason" => "A funny SpongeBob reference asking 'Is mayonnaise an instrument?'" },
        { "chirp_id" => 9, "reason" => "Insightful and well-liked quote: 'The inner machinations of my mind are an enigma.'" },
        { "chirp_id" => 5, "reason" => "A memorable line expressing humor and sadness: 'Goodbye everyone, I'll remember you all in therapy.'" },
        { "chirp_id" => 2, "reason" => "Popular SpongeBob reference 'Two words, SpongeBob. Na. Chos.' liked by many." },
        { "chirp_id" => 15, "reason" => "Bold and self-accepting line: 'I'm ugly and I'm proud!'" }
      ]
    }
  end
end
