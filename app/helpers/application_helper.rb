require 'Redcarpet'
module ApplicationHelper

  def markdown(text)

    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new( renderer )

    return markdown.render(text).html_safe
  end
end
