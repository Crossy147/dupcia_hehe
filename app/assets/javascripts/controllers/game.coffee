@App.controller 'GameCtrl', ($scope, $http, $location, $routeParams, socket) ->
  $scope.game = []

  tableId = $routeParams.id
  socket.open(tableId, 'user_id')

  socket.listen().then null, null, (data) ->
    console.log data

  $scope.deal = () ->
    $http(method: 'GET', url: '/game/deal')
    .success (data, status) ->
      table = new Table('table',
          cardWidth: 168
          cardHeight: 244
          cardScale: 0.7
          imageGrid: '/assets/images/wikipedia-cards.png'
          nextCardDisplacementH: 40
          nextCardDisplacementV: 40)
      ###
          TODO: data should be more interesting
      ###
      table.setPlayers(
          north: new Player('dangerous player', Card.makeInvisibleHand(13))
          south: new Player('best player', [ new Card('ACE', 'DIAMONDS'),
                                             new Card('ACE', 'DIAMONDS'),
                                             new Card('TWO', 'CLUBS') ])
          east: new Player('stupid player', Card.makeInvisibleHand(13))
          west: new Player('cowboy from united states', Card.makeInvisibleHand(13)))
      table.draw()
      return

  $scope.$on '$destroy', ->
    socket.close()
