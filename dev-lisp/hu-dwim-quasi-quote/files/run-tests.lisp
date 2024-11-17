(require "asdf")

(push (uiop/os:getcwd) asdf:*central-registry*)

(asdf:load-system "hu.dwim.quasi-quote.test")

(uiop:quit (if (hu.dwim.quasi-quote.test::test) 0 1))
