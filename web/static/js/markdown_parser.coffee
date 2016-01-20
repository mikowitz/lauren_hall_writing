MarkdownParser = class MarkdownParser
  constructor: (markdown) ->
    @markdown = markdown

  parse: ->
    $.ajax("/markdown",
      data:
        markdown: @markdown
      dataType: "json",
      method: "GET",
      success: (resp) ->
        console.log(resp.html)
        # $("#preview").html(resp.html)
    )

module.exports =
  MarkdownParser: MarkdownParser
