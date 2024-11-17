(require "asdf")

(push (uiop/os:getcwd) asdf:*central-registry*)

(asdf:load-system "hu.dwim.serializer.test")

(uiop:quit (if (hu.dwim.serializer.test::test) 0 1))
