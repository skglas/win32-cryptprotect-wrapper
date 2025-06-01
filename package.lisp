;;;; package.lisp
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

(defpackage #:win32-cryptprotect-wrapper
  (:use #:cl #:cffi)
  (:export
   #:encrypt-password
   #:decrypt-password ))
