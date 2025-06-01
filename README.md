# win32-cryptprotect-wrapper

## Purpose

From Common Lisp on Windows, securely store and retrieve passwords using the built-in `CryptProtectData` and `CryptUnprotectData` APIs provided by Windows.

This leverages the Windows cryptographic services, which offer Per-user or Per-machine encryption contexts.

As a result, encrypted data is not portable outside the originating Windows system or user account. This protects plaintext credentials from leaking via backups or file theft.

You can combine this wrapper with libraries like [`cl-store`](https://github.com/sharplispers/cl-store) to store credentials in files with additional security.

Parts of this code were generated from ChatGPT 2025-04. Idea by Sebastian K. Glas, 2025

> **Disclaimer**  
> This is a **proof-of-concept**.  
> Do **not** use in production.  
> This code has **not** been security-audited.  
> Provided **as-is**, without warranty to the extent permitted by law.


---

## Example

```lisp
CL-USER> (ql:quickload :win32-cryptprotect-wrapper)

To load "win32-cryptprotect-wrapper":

Load 1 ASDF system:

win32-cryptprotect-wrapper

; Loading "win32-cryptprotect-wrapper"
................................................
[package win32-cryptprotect-wrapper]..

(:WIN32-CRYPTPROTECT-WRAPPER)

CL-USER> (win32-cryptprotect-wrapper:encrypt-password "12345")

#(1 0 0 0 208 140 157 223 ...)

CL-USER> (win32-cryptprotect-wrapper:decrypt-password *)

"12345"
