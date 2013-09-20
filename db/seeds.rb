class SeedDB

  def self.add_users(num)
    
    num.times do
      user = User.new( name: Faker::Name.name,
                       email: Faker::Internet.email,
                       password: Faker::Base.regexify(/[a-zA-Z0-60]{9}/) )
      user.save
    end

  end

  def self.create_deck(deck_title, cards)

    deck = Deck.new( title: deck_title,
                     active: true )

    deck.save

    cards.each do |c|
      card = Card.new( question: c[:q],
                answer: c[:a])
      deck.cards << card
    end

  end

end


# SeedDB.add_users(10)


# cards = [ {q: "What's the capital of Norway?", a: "Oslo" },
#           {q: "What's the capital of Sweden?", a: "Stockholm"},
#           {q: "What's the capital of Denmark?", a: "Copenhagen"},
#           {q: "What's the capital of England?", a: "London"},
#           {q: "What's the capital of Iceland?", a: "Reykavik"} ]

# SeedDB.create_deck("Capitol cities of the world", cards)

cards2 = [ {q: "What's the largest state in the US by land area?", a: "Alaska" },
           {q: "What's the largest state in the US by population?", a: "Califorina"},
           {q: "What's the smallest state in the US by land area?", a: "Rhode Island"},
           {q: "What's the smalles state in the US by population?", a: "Wyoming"}]

SeedDB.create_deck("Some questions about the US", cards2)
