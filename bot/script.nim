import telebot

when false:
  @admin:
    /stats -> (answered, used/all)
    /addpoet [poet]
    /reset [tgid]
    /backup

  @user:
    /start
    -> greeting

    block loop:
      case [senMyInputs, wannaAnswer]
      of 1:
        -> user.puzzle.shuffled
        -> user.puzzle.logs

      of 2:
        -> doubtSolvedProblemD
        -> sendToProveD

        if msg.removeSpaces == user.puzzle.initial.removeSpaces:
          -> congratsD
          -> weWillInformYou

          break loop

        else:
          -> "no dear, that's not the answer"
          continue loop
