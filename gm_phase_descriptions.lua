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
    i. setup "missions remaining until rescue" track.
    ii. build a deck of size %i, with 1 joker.
    iii. from that deck, deal 4 cards to each player.
    iv. generate and place mission cards until their total difficulty > %i
    v. narrate the current situation.
    vi. delete this card - a more useful one is below.
    ]],
    number_of_dynamic_terms = 2,
  },
  Briefing={
    title="1: Briefing",
    summary=[[
    i. blindfold everyone (resolution button)
    ii. Deal a Joker to the current thing, if they don't already have one.
    iii. deal to players until everyone holds 4 cards.
    iv. take off blindfolds.
    v. add mission cards until the difficulty is high enough.
    vi. narrate the new situation.
    ]],
    number_of_dynamic_terms = 0,
  },
  Assignments={
    title="2: Assignments",
    summary=[[
    i. players discuss, in general terms, what they intend to do.
    ii. at some point, intervene to stop the discussion.
    iii. instruct the players to place their tokens on the missions they will work on.
    ]],
    number_of_dynamic_terms = 0,
  },
  Work={
    title="3: Work",
    summary=[[
    i. each player commits 2-3 cards to the task they put their token on.
    i.a at this point the Thing may play their Joker as part of their work.
    ]],
    number_of_dynamic_terms = 0,
  },
Debrief={
    title="4: Debrief",
    summary=[[
    for each task,
    i. gather all the cards played on it into a deck.
    ii. put the deck onto the card-counter index card.
    iii. decide if the status of the task is "No Progress", "Partially Complete" or "Complete".
    iv. return the deck to the task-card and narrate the new situation - DO NOT disclose success-numbers.
    v. if a task is complete, place it in the Mission Bag, and put its action cards on the discard table.
    ]],
    number_of_dynamic_terms = 0,
  },
  Isolation={
    title="5: Isolation",
    summary=[[
    instruct the players that:
    i. if any player wants to isolate another player, they can call for a vote.
    ii. if a second layer supports the first, then players will vote on the matter.
     - if there is a vote, each player places 0-1 cards near the completion tracker.
     - if the number of successes played is >= {#players / 2} then the isolation takes place.
    iii. if someone was isolated, remind the players of the isolation rules.
    ]],
    number_of_dynamic_terms = 0,
  },
  Assimilation={
    title="6: Assimilation",
    summary=[[
    i. blindfold all the players (reslution button)
    ii. then say, "If you assimilated someone in the current round, take your
      blindfold off and indicate them with your mouse." ALWAYS DO THIS.
    iii. if the Thing did play a joker, and does specify someone, that person is assimilated.
    iv. next turn, that person will receive a joker.
    ]]
  }
}
