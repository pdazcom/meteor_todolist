# server/methods/delete_board_image.coffee
# подключаем библиотеку для работы с файлами
fs = Meteor.npmRequire 'fs'

Meteor.methods
  deleteBoard: (boardId) ->
    board = BoardsCollection.findOne(boardId)
    if board.owner != @userId
      throw new Meteor.Error 'notAuthorized', 'Not authorized'
    img = []
    img.push board.background?.url.replace /.*\/([^\/]+)$/, "\$1"
    img.push board.background?.thumb.replace /.*\/([^\/]+)$/, "\$1"
    _.each img, (v)->
      path  = Meteor.getUploadFilePath v
      if fs.existsSync(path)
        fs.unlinkSync path

    # удаляем доску и таски, если есть
    board.removeTasks (err) ->
      if err
        throw new Meteor.Error 'dbError', 'Database error'
      board.remove (err) ->
        if err
          throw new Meteor.Error 'dbError', 'Database error'
        return true