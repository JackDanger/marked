Marked
=

[http://github.com/JackDanger/marked](http://github.com/JackDanger/marked)

DESCRIPTION
==

Ruby debugging often consists of printing out objects at various points in your code to inspect their current values. Do it fast and easy with Marked. the `mark()` method exists in global scope and always returns the values you pass into it, allowing your code to run as normal but giving you intermediate feedback.

USAGE
== 

Before:

    class User < ActiveRecord::Base
      def some_method
        complex_result
      end
    end

How do you tell what the value of `complex_result` is inside this method?
How do you tell if this method even ran?
You write tests. Okay, but after that, if you're tracking down a bug?

    class User < ActiveRecord::Base
      def some_method
        mark complex_result
      end
    end

And you'll get the value of `complex_result` printed to your console and to the Rails log (if it exists)

Can take multiple arguments, always returning the last:


    class User < ActiveRecord::Base
      def some_method
        mark self, 'complex result: ', complex_result
      end
    end

Also handles blocks smoothly, returning the block's result as if there were no block.

    class User < ActiveRecord::Base
      def some_method
        mark self, 'complex result: ' do
          complex_result
        end
      end
    end



INSTALL
==

    * gem install marked


Copyright 2011 Jack Danger Canty. Patches welcome, forks celebrated