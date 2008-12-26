# ContentEditor
module ActionView
  module TemplateHandlers
    class ERB < TemplateHandler
      def compile(template)
        src = ::ERB.new("<% __in_erb_template=true %> <%=link_to_edit%>#{template.source}", nil, erb_trim_mode, '@output_buffer').src

        # Ruby 1.9 prepends an encoding to the source. However this is
        # useless because you can only set an encoding on the first line
        RUBY_VERSION >= '1.9' ? src.sub(/\A#coding:.*\n/, '') : src
      end
    end
  end
end

module EditMe
  module EditorHelper
    def editing?
      session[:editing]
    end
    def link_to_edit
      if editing?
        %{<a href="/edit_me/#{template.relative_path}"><img src="/images/edit.png" /></a>}
      end
    end
  end

  module Routing #:nodoc:
    module MapperExtensions
      def edit_me
        @set.add_route "edit_me/activate/:revision/*path", :controller => "edit_me", :action => "activate_revision",
          :conditions => { :method => :get }

        @set.add_route "edit_me/edit_mode", :controller => "edit_me", :action => "edit_mode"

        @set.add_route "edit_me/*path", :controller => "edit_me", :action => "edit",
          :conditions => { :method => :get }

        @set.add_route "edit_me/*path", :controller => "edit_me", :action => "update",
          :conditions => { :method => :put }
      end
    end
  end
end

require 'content_item'

ActionView::Base.send :include, EditMe::EditorHelper
ActionController::Base.view_paths << File.join(File.dirname(__FILE__), "app", "views")
ActionController::Routing::RouteSet::Mapper.send :include, EditMe::Routing::MapperExtensions

EditMe::ContentItem.repo = Git.open(RAILS_ROOT)

%w{ controllers }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

