;;;; win32-cryptprotect-wrapper 

;; Purpose: 
;; From Common Lisp store and retrieve passwords via the Windows CryptProtectData API
;; This will use the built-in cryptographic functions from windows.
;; They provide a security context per-user or per machine. 
;;
;; This is a proof-of-concept. Do not use in production.
;; This code has not been security-audited.
;; This proof-of-concept comes with no warranty to the extent permitted by law.
;;
;; Parts of this code were generated from ChatGPT 2025-04.
;; Idea by Sebastian Glas, 2025
;; 
;; Tested on SBCL & Windows 11

(asdf:defsystem #:win32-cryptprotect-wrapper
  :description "A tiny wrapper around win32-cryptprotect-api"
  :author "ChatGPT with Sebastian K. Glas, 2025"
  :license  "BSD"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "win32-cryptprotect-wrapper"))
  :depends-on (:cffi))
