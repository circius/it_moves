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
2: shuffle the action cards ('R') then get %i action cards ('cut') and add an assimilation.
3: shuffle the new deck, then deal 4 cards to each player. ('deal')
4: generate and place task cards until their total difficulty > %i; add status indicators.
5: narrate the current situation.
6: delete this card - a more useful one is below.
]],
    number_of_dynamic_terms = 2,
  },
  Briefing={
    title="1: Briefing",
    summary=[[
1: Ensure that everyone is blindfolded.
2: Deal an assimilate card to the current Lurker, if they don't already have one.
3: deal to players until everyone holds 4 cards.
4: take off blindfolds.
5: add task cards until total difficulty on the table is >= #players * 2
6: add a status indicator to each new task card.
7: advance the completion track and narrate the new situation.
    ]],
    number_of_dynamic_terms = 0,
  },
  Assignments={
    title="2: Assignments",
    summary=[[
1: players discuss, in general terms, what task the intend to commit to.
2: at some point, intervene to stop the discussion.
3: instruct the players to place their tokens on the tasks they will work on.
    ]],
    number_of_dynamic_terms = 0,
  },
  Work={
    title="3: Work",
    summary=[[
1: instruct the players each to commit 2-3 cards, face down, at their location.
1a: at this point the Thing may play their Assimilation card as part of their work.
    ]],
    number_of_dynamic_terms = 0,
  },
Debrief={
    title="4: Debrief. For each task:",
    summary=[[
1: gather all the cards played on it into a deck.
2: put the deck onto the card-counter index card.
3: set the status indicator to "No Progress", "Partially Complete" or "Complete". 
4: return the deck to the task-card and narrate the new situation - DO NOT disclose success-numbers.
5: if a task is complete, place it in the Finished Task bag, and put its action cards on the discard table.
    ]],
    number_of_dynamic_terms = 0,
  },
  Assimilation={
    title="5: Assimilation",
    summary=[[
1: blindfold all the players (resolution button)
2: then say, "If you assimilated someone in the current round, take your blindfold off and indicate them with your mouse." ALWAYS DO THIS.
3: if the Lurker did play an assimilation card, and does specify someone, that person is now the current Lurker.
4: next turn, that person will receive an assimilation card.
5: then say, "If you are not currently wearing a blindfold, blindfold yourself."
]]
  },
  Isolation={
    title="6: Isolation. Instruct the players that:",
    summary=[[
1: they should remove their blindfolds.
2: Anyone that wants to isolate someone needs a seconder.
3: If a vote is force, each player may place an action card near the completion tracker.
4: If the number of successes played is >= {#players / 2} then the isolation takes place.
5: If someone was isolated, place their token in the isolation tent, and remind of rules.
]],
    number_of_dynamic_terms = 0,
  }
}
