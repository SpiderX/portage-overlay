(require "asdf")

(push (uiop/os:getcwd) asdf:*central-registry*)

(asdf:load-system "hu.dwim.uri.test")

(uiop:quit (if (hu.dwim.uri.test::test) 0 1))
