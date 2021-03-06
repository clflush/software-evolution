;; repair using software evolution
(require :software-evolution)
(in-package :software-evolution)

(load #P"repair.lisp")

(defvar *asm*
  (progn
    (unless (probe-file "gcd.s")
      (shell "gcc -S gcd.c"))
    (from-file (make-instance 'asm) "gcd.s")))

;; Add the good and bad path information to gcd
;; (apply-path original :neg (samples-from-oprofile-file "sample.neg"))
;; (apply-path original :pos (samples-from-oprofile-file "sample.pos"))

#+run
(sb-thread:make-thread
 (lambda ()
   (setf (fitness *asm*) (test-suite *asm*))
   (setf *population* (loop :for i :below 100 :collect (copy *asm*)))
   (let ((*max-population-size* 100))
     (store (evolve #'test-suite :target 12) "results-asm.store"))))
