;;;; win32-cryptprotect-wrapper.lisp

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

(in-package #:win32-cryptprotect-wrapper)

(cffi:use-foreign-library "Crypt32.dll")

(defcstruct data-blob
  (cb-data :uint32)
  (pb-data :pointer))

(defcfun ("CryptProtectData" crypt-protect-data)
  :boolean
  (p-data-in (:pointer (:struct data-blob)))
   (sz-data-desc :pointer) 
   (p-optional-entropy :pointer)
   (pv-reserved :pointer)
   (p-prompt-struct :pointer)
   (dw-flags :uint32)
   (p-data-out (:pointer (:struct data-blob))))

(defcfun ("CryptUnprotectData" crypt-unprotect-data)
  :boolean
  (p-data-in (:pointer (:struct data-blob)))
   (ppsz-data-desc :pointer)            
   (p-optional-entropy :pointer)
   (pv-reserved :pointer)
   (p-prompt-struct :pointer)
   (dw-flags :uint32)
   (p-data-out (:pointer (:struct data-blob))))


(defun make-data-blob (octets)
  "Octet list to data_blob"
  (let* ((len (length octets))
         (buffer (cffi:foreign-alloc :uint8 :count len)))
    (loop for i below len
          for byte across octets
          do (setf (cffi:mem-aref buffer :uint8 i) byte))
    (let ((blob (cffi:foreign-alloc '(:struct data-blob))))
      (setf (cffi:foreign-slot-value blob '(:struct data-blob) 'cb-data) len
            (cffi:foreign-slot-value blob '(:struct data-blob) 'pb-data) buffer)
      blob)))

(defun blob-to-octets (blob)
  "Extract byte array from data_blob" 
  (let* ((len (cffi:foreign-slot-value blob '(:struct data-blob) 'cb-data))
         (ptr (cffi:foreign-slot-value blob '(:struct data-blob) 'pb-data))
         (vec (make-array len :element-type '(unsigned-byte 8))))
    (loop for i below len
          do (setf (aref vec i) (cffi:mem-aref ptr :uint8 i)))
    vec))


(defun encrypt-password (text)
  (let* ((bytes (babel:string-to-octets text :encoding :utf-8))
         (in-blob (make-data-blob bytes))
         (out-blob (cffi:foreign-alloc '(:struct data-blob))))
    (when (crypt-protect-data in-blob
                              (cffi:null-pointer) 
                              (cffi:null-pointer)
                              (cffi:null-pointer)
                              (cffi:null-pointer)
                              0
                              out-blob)
      (blob-to-octets out-blob))))

(defun decrypt-password (octets)
  (let* ((in-blob (make-data-blob octets))
         (out-blob (cffi:foreign-alloc '(:struct data-blob))))
    (when (crypt-unprotect-data in-blob
                                (cffi:null-pointer)
                                (cffi:null-pointer)
                                (cffi:null-pointer)
                                (cffi:null-pointer)
                                0
                                out-blob)
      (babel:octets-to-string (blob-to-octets out-blob)
                              :encoding :utf-8))))

