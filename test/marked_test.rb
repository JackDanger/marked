require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class MarkedTest < Test::Unit::TestCase

  def expect_log string
    Marked.expects(:log).with ' ' + Marked.pad(string)
  end

  def expect_unpadded_log string
    Marked.expects(:log).with string
    Rails.logger.expects(:debug).with " / FINISHED MARKING"
  end


  context "logging" do
    setup {
      Rails.logger.expects(:debug).with "\nMARKED  #{__FILE__}:24"
      Marked.expects(:print).with       "\nMARKED  #{__FILE__}:24"
      Rails.logger.expects(:debug).with "#{Marked.pad ' '}this should be printed"
      Marked.expects(:print).with       "#{Marked.pad ' '}this should be printed"
      Rails.logger.expects(:debug).with " / FINISHED MARKING"
    }
    should "goes to two outputs" do
      mark "this should be printed"
    end
  end
  context "printing and logging a single argument" do
    setup {
      expect_unpadded_log "\nMARKED  #{__FILE__}:33"
      expect_log "this should be printed"
    }
    should "return its argument" do
      assert_equal "this should be printed", mark("this should be printed")
    end
  end
  context "printing and logging multiple arguments" do
    setup {
      expect_unpadded_log "\nMARKED  #{__FILE__}:43"
      expect_log "this should be printed"
      expect_log "this too"
    }
    should "return its last argument" do
      assert_equal "this too", mark("this should be printed", "this too")
    end
  end
  context "printing and logging non-strings" do
    setup {
      expect_unpadded_log "\nMARKED  #{__FILE__}:53"
      expect_log({:a =>'a'})
      expect_log [1, 2, 3]
    }
    should "return its last argument as object" do
      assert_equal [1,2,3], mark({:a => 'a'}, [1,2,3])
    end
  end
  context "printing and logging blocks" do
    setup {
      @obj = {}
      @obj.expects(:called!).returns('returned!').once
      expect_unpadded_log "\nMARKED  #{__FILE__}:65"
      expect_log "first arg"
      expect_log "returned!"
    }
    should "return its last argument as object" do
      assert_equal 'returned!', mark('first arg') { @obj.called! }
    end
  end
  context "#pad" do
    should "prepend 7 spaces" do
      assert_equal (" "*7)+'padme',
                   Marked.pad('padme')
    end
  end
end
