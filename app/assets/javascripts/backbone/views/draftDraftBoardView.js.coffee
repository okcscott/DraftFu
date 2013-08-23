class DraftFu.Views.DraftDraftBoardView extends Backbone.View
  template: JST['draft_draftboard']

  initialize: ->
  render: (rosters)->
    @template(rosters: rosters)