require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class MarkerTest < Test::Unit::TestCase
  context "printing and logging a single argument" do
    setup {
      Rails.logger.expects(:debug).with("<MARK>")
      Rails.logger.expects(:debug).with("this should be printed")
      Rails.logger.expects(:debug).with("</MARK>")
      Marker.expects(:print).with("this should be printed")
    }
    should "return its argument" do
      assert_equal "this should be printed", mark("this should be printed")
    end
  end
  context "printing and logging multiple arguments" do
    setup {
      Rails.logger.expects(:debug).with("<MARK>")
      Rails.logger.expects(:debug).with("this should be printed")
      Rails.logger.expects(:debug).with("this too")
      Rails.logger.expects(:debug).with("</MARK>")
      Marker.expects(:print).with("this should be printed")
      Marker.expects(:print).with("this too")
    }
    should "return its last argument" do
      assert_equal "this too", mark("this should be printed", "this too")
    end
  end
  context "printing and logging non-strings" do
    setup {
      Marker.expects(:log).with("<MARK>")
      Marker.expects(:log).with({:a =>'a'})
      Marker.expects(:log).with([1, 2, 3])
      Marker.expects(:log).with("</MARK>")
      Marker.expects(:print).with({:a => 'a'})
      Marker.expects(:print).with([1, 2, 3])
    }
    should "return its last argument as object" do
      assert_equal [1,2,3], mark({:a => 'a'}, [1,2,3])
    end
  end
  context "printing and logging blocks" do
    setup {
      @obj = {}
      @obj.expects(:called!).returns('returned!').once
      Rails.logger.expects(:debug).with("<MARK>")
      Rails.logger.expects(:debug).with("first arg")
      Rails.logger.expects(:debug).with("returned!")
      Rails.logger.expects(:debug).with("</MARK>")
      Marker.expects(:print).with("first arg")
      Marker.expects(:print).with("returned!")
    }
    should "return its last argument as object" do
      assert_equal 'returned!', mark('first arg') { @obj.called! }
    end
  end
end
