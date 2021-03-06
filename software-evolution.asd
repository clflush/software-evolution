(defsystem :software-evolution
  :description "programmatic modification and evaluation of extant software"
  :long-description "A common interface abstracts over multiple
types of software objects including abstract syntax trees parsed from
source code, LLVM IR, compiled assembler, and linked ELF binaries.
Mutation and evaluation methods are implemented on top of this
interface supporting Search Based Software Engineering (SBSE)
techniques."
  :version "0.0.0"
  :author "Eric Schulte <schulte.eric@gmail.com>"
  :licence "GPL V3"
  ;; :homepage "http://eschulte.github.io/software-evolution/index.html"
  :source-control (:git "git://github.com/eschulte/software-evolution")
  :depends-on (alexandria
               metabang-bind
               curry-compose-reader-macros
               split-sequence
               cl-ppcre
               elf
               software-evolution-utility)
  :in-order-to ((test-op (test-op software-evolution-test)))
  :components
  ((:module base
            :pathname ""
            :components
            ((:file "package")
             (:file "software-evolution" :depends-on ("package"))))
   (:module software
            :depends-on (base)
            :pathname "software"
            :components
            ((:file "lisp")
             (:file "simple")
             (:file "asm" :depends-on ("simple"))
             (:file "elf")
             (:file "elf-mips" :depends-on ("elf"))
             (:file "elf-x86" :depends-on ("elf"))
             (:file "ast")
             (:file "cil" :depends-on ("ast"))
             (:file "clang" :depends-on ("ast"))
             (:file "llvm" :depends-on ("ast"))))))
