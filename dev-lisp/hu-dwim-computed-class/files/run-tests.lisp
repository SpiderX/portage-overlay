(require "asdf")

(push (uiop/os:getcwd) asdf:*central-registry*)

(asdf:load-system "hu.dwim.computed-class.test")

(uiop:quit (if (hu.dwim.computed-class.test::test) 0 1))
