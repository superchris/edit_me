require File.dirname(__FILE__) + '/test_helper'
require 'content_item'

class ContentItemTest < Test::Unit::TestCase

  def setup
    @repo = flexmock("repo")
    EditMe::ContentItem.repo = @repo
    @content_item = EditMe::ContentItem.new("/foo/bar")
  end
  
  def test_content
    flexmock(File).should_receive(:read).with(
      File.join(RAILS_ROOT, "/foo/bar")).and_return "content"
    assert_equal "content", @content_item.content
  end

  def test_history
    @repo.should_receive("log.path").with("/foo/bar").and_return :history
    assert_equal :history, @content_item.history
  end

  def test_update
    file_mock = flexmock("file")
    file_mock.should_receive("<<").once.with("updated content")
    flexmock(File).should_receive(:open).once.with(
      File.join(RAILS_ROOT, "/foo/bar"), "w", Proc).and_return do |x, y, proc|
      proc.call file_mock
    end
    @repo.should_receive(:add).with("/foo/bar").once
    @repo.should_receive(:commit).with("message").once
    @content_item.update "updated content", "message"
  end

  def test_activate_revision
    @repo.should_receive(:checkout_file).with("1", "/foo/bar")
    @content_item.activate_revision("1")
  end
end
