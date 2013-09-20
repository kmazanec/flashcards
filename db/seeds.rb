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
          {q: "What's the capital of Iceland?", a: "Reykavik"} ]

SeedDB.create_deck("Capitol cities of the world", cards)

cards2 = [ {q: "What's the largest state in the US by land area?", a: "Alaska" },
           {q: "What's the largest state in the US by population?", a: "Califorina"},
           {q: "What's the smallest state in the US by land area?", a: "Rhode Island"},
           {q: "What's the smalles state in the US by population?", a: "Wyoming"}]

SeedDB.create_deck("Some questions about the US", cards2)


User.all.each do |user|
  num_plays = rand(4)+1

  num_plays.times do
    random_deck = rand(Deck.count)+1
    SeedDB.create_game(user.id,random_deck)
  end

end







