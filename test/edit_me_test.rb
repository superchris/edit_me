require File.dirname(__FILE__) + '/test_helper'
require 'edit_me'

class EditMeTest < Test::Unit::TestCase
  include EditMe::EditorHelper

  def test_default_include
    assert editable?("app/views/foo/bar.rhtml")
  end
  
  def test_editable_includes
    EditMe::Editable.includes << /foo/
    assert editable?("foo")
  end

  def test_editable_excludes
    EditMe::Editable.excludes << /bar/
    assert ! editable?("app/views/foo/bar.rhtml")
  end
end
