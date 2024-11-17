(require "asdf")

(push (uiop/os:getcwd) asdf:*central-registry*)

(asdf:load-system "hu.dwim.syntax-sugar.test")

(uiop:quit (if (hu.dwim.syntax-sugar.test::test) 0 1))
