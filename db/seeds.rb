#encoding: utf-8

class SeedDB
  def self.add_users(num)
    num.times do
      user = User.new( name: Faker::Name.name,
                       email: Faker::Internet.email,
                       password: "test", #Faker::Base.regexify(/[a-zA-Z0-60]{9}/) )
                       password_confirmation: "test")
      user.save
    end
  end

  def self.create_deck(deck_title, cover_image_url, cards)
    deck = Deck.new( title: deck_title,
                     image_url: cover_image_url,
                     active: true )

    deck.save

    cards.each do |c|
      card = Card.new( question: c[:q],
                answer: c[:a])
      deck.cards << card
    end
  end

  def self.create_game(user_id, deck_id)

    game = Game.create( user_id: user_id, deck_id: deck_id )

    cards = game.deck.cards

    wrong_answer = [TRUE,TRUE,TRUE,FALSE]
    rand_not_finish = [0,0,0,0,1,2,3]

    cards_to_not_answer = rand_not_finish.sample

    cards_to_not_answer.times do
      cards.pop
    end

    cards.each do |card|
      answer  = card.answer
      correct = wrong_answer.sample
      answer = answer + "???" unless correct

      Response.create( game_id: game.id,
                       guess: answer,
                       correct: correct
                      )
    end

  end



end


SeedDB.add_users(10)


cards = [ {q: "What's the capital of Norway?", a: "Oslo" },
          {q: "What's the capital of Sweden?", a: "Stockholm"},
          {q: "What's the capital of Denmark?", a: "Copenhagen"},
          {q: "What's the capital of England?", a: "London"},
          {q: "What's the capital of Iceland?", a: "Reykjavik"} ]

SeedDB.create_deck("Capitol cities of the world", "/images/world_caps.jpg", cards)

cards = [ {q: "What's the largest state in the US by land area?", a: "Alaska" },
          {q: "What's the largest state in the US by population?", a: "California"},
          {q: "What's the smallest state in the US by land area?", a: "Rhode Island"},
          {q: "What's the smalles state in the US by population?", a: "Wyoming"}]

SeedDB.create_deck("Some questions about the US", "/images/americana.jpg", cards)

cards = [ {q: "1 + 3", a: "4" },
          {q: "5 - 1", a: "4"},
          {q: "2 * 2", a: "4"},
          {q: "8 / 2", a: "4"},
          {q: "4 + 0", a: "4"},
          {q: "9 - 5", a: "4"},
          {q: "15 - 15 + 4", a: "4"},
          {q: "4 + 4 - 4", a: "4"},
          {q: "(9 * 1) - 5", a: "4"},
          {q: "10 - 6", a: "4"},
          {q: "15 - 11", a: "4"},
          {q: "-4 + 8", a: "4"},
          {q: "5 - 1", a: "4"},
          {q: "4 * 1", a: "4"},
          {q: "6 + 2 - 4", a: "4"},
          {q: "5 - 2 + 1", a: "4"},
          {q: "(4 * 0) + 4", a: "4"},
          {q: "3 + 1", a: "4"}]

SeedDB.create_deck("Simple math", "/images/math.jpg", cards)

cards = [ {q: "Write this word PNEUMONO­ULTRA­MICRO­SCOPIC­SILICO­VOLCANO­KONIOSIS", a: "PNEUMONO­ULTRA­MICRO­SCOPIC­SILICO­VOLCANO­KONIOSIS" },
          {q: "Write this word HEPATICO­CHOLANGIO­CHOLECYST­ENTERO­STOMIES", a: "HEPATICO­CHOLANGIO­CHOLECYST­ENTERO­STOMIES" },
          {q: "Write this word SUPER­CALI­FRAGI­LISTIC­EXPI­ALI­DOCIOUS", a: "SUPER­CALI­FRAGI­LISTIC­EXPI­ALI­DOCIOUS" },
          {q: "Write this word FLOCCI­NAUCINI­HILIPIL­IFICATION", a: "FLOCCI­NAUCINI­HILIPIL­IFICATION" },
          {q: "Write this word ANTI­DIS­ESTABLISH­MENT­ARIAN­ISM", a: "ANTI­DIS­ESTABLISH­MENT­ARIAN­ISM" },
          {q: "Write this word HONORI­FICABILI­TUDINI­TATIBUS", a: "HONORI­FICABILI­TUDINI­TATIBUS" },
          {q: "Write this word ELECTRO­ENCEPHALO­GRAPHICALLY", a: "ELECTRO­ENCEPHALO­GRAPHICALLY" }]

SeedDB.create_deck("Typing out the longest words", "/images/words.jpg", cards)

cards = [ {q: "A shorthand property for all the animation properties below, except the animation-play-state property", a: "animation" },
          {q: "Specifies a name for the @keyframes animation", a: "animation-name" },
          {q: "Specifies how many seconds or milliseconds an animation takes to complete one cycle", a: "animation-duration" },
          {q: "Specifies the speed curve of the animation", a: "animation-timing-function" },
          {q: "Specifies when the animation will start", a: "animation-delay" }, ]

SeedDB.create_deck("CSS Properties", "/images/css3.jpg", cards)

cards = [ {q: "Represents a collection of metadata about the document, including links to, or definitions of, scripts and style sheets.", a: "head" },
          {q: "Defines the title of the document, shown in a browser's title bar or on the page's tab. It can only contain text and any contained tags are not interpreted.", a: "title" },
          {q: "Defines the base URL for relative URLs in the page.", a: "base" },
          {q: "Used to link JavaScript and external CSS with the current HTML document", a: "link" },
          {q: "Defines metadata that can't be defined using another HTML element.", a: "meta" }, ]

SeedDB.create_deck("HTML5 Elements", "/images/html5.jpg", cards)


# cards = [ {q: "", a: "" },
#           {q: "", a: "" },
#           {q: "", a: "" },
#           {q: "", a: "" },
#           {q: "", a: "" }, ]

# SeedDB.create_deck("CSS Properties", "/images/xxx.jpg", cards)


User.all.each do |user|
  num_plays = rand(4)+1

  num_plays.times do
    random_deck = rand(Deck.count)+1
    SeedDB.create_game(user.id,random_deck)
  end

end







