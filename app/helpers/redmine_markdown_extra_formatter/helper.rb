module RedmineMarkdownExtraFormatter
  module Helper
    unloadable

    def wikitoolbar_for(field_id)
      heads_for_wiki_formatter
      url = Engines::RailsExtensions::AssetHelpers.plugin_asset_path('redmine_markdown_extra_formatter', 'help', 'markdown_extra_syntax.html')
      help_link = l(:setting_text_formatting) + ': ' +
        link_to(l(:label_help), url,
        :onclick => "window.open(\"#{url}\", \"\", \"resizable=yes, location=no, width=300, height=640, menubar=no, status=no, scrollbars=yes\"); return false;")
        javascript_tag("var toolbar = new jsToolBar($('#{field_id}')); toolbar.setHelpLink('#{help_link}'); toolbar.draw();")
    end


    def initial_page_content(page)
      "#{page.pretty_title}\n#{'='*page.pretty_title.length}"
    end

    def heads_for_wiki_formatter
      unless @heads_for_wiki_formatter_included
        content_for :header_tags do
          javascript_include_tag('jstoolbar/jstoolbar') +
          javascript_include_tag('jstoolbar/markdown_extra', :plugin => 'redmine_markdown_extra_formatter') +          
          javascript_include_tag("jstoolbar/lang/jstoolbar-#{current_language}") +
          stylesheet_link_tag('jstoolbar')
        end
        @heads_for_wiki_formatter_included = true
      end
    end
    
  end
end
