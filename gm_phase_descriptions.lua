gm_phase_descriptions = {
  Pre_Setup={
    title="-1: Pre-setup",
    summary=[[
      There are too few players to start the game! Only %i are seated at the table, and we need a minimum of %i.
    ]],
    number_of_dynamic_terms = 2
  },
  Setup={
    title="0: Setup",
    summary=[[
    1: tell the setup button how many players there are, then hit the button.
    2: shuffle the action cards, then get %i action cards (right-click -> 'cut') and add a joker.
    3: shuffle the new deck, then deal 4 cards to each player. (right-click -> 'deal')
    4: generate and place mission cards until their total difficulty > %i
    5: narrate the current situation.
    6: delete this card - a more useful one is below.
    ]],
    number_of_dynamic_terms = 2,
  },
  Briefing={
    title="1: Briefing",
    summary=[[
    1: blindfold everyone (resolution button)
    2: Deal a Joker to the current thing, if they don't already have one.
    3: deal to players until everyone holds 4 cards.
    4: take off blindfolds.
    5: add mission cards until the difficulty is high enough.
    6: narrate the new situation.
    ]],
    number_of_dynamic_terms = 0,
  },
  Assignments={
    title="2: Assignments",
    summary=[[
    1: players discuss, in general terms, what they intend to do.
    2: at some point, intervene to stop the discussion.
    3: instruct the players to place their tokens on the missions they will work on.
    ]],
    number_of_dynamic_terms = 0,
  },
  Work={
    title="3: Work",
    summary=[[
    1: each player commits 2-3 cards to the task they put their token on.
    1a: at this point the Thing may play their Joker as part of their work.
    ]],
    number_of_dynamic_terms = 0,
  },
Debrief={
    title="4: Debrief. For each task:",
    summary=[[
    1: gather all the cards played on it into a deck.
    2: put the deck onto the card-counter index card.
    3: decide if the status of the task is "No Progress", "Partially Complete" or "Complete".
    4: return the deck to the task-card and narrate the new situation - DO NOT disclose success-numbers.
    5: if a task is complete, place it in the Mission Bag, and put its action cards on the discard table.
    ]],
    number_of_dynamic_terms = 0,
  },
  Isolation={
    title="5: Isolation. Instruct the players that:",
    summary=[[
    1: if any player wants to isolate another player, they can call for a vote.
    2: if a second layer supports the first, then players will vote on the matter.
     - if there is a vote, each player places 0-1 cards near the completion tracker.
     - if the number of successes played is >= {#players / 2} then the isolation takes place.
    3: if someone was isolated, remind the players of the isolation rules.
    ]],
    number_of_dynamic_terms = 0,
  },
  Assimilation={
    title="6: Assimilation",
    summary=[[
    1: blindfold all the players (resolution button)
    2: then say, "If you assimilated someone in the current round, take your blindfold off and indicate them with your mouse." ALWAYS DO THIS.
    3: if the Thing did play a joker, and does specify someone, that person is assimilated.
    4: next turn, that person will receive a joker.
    ]]
  }
}
