# win32-cryptprotect-wrapper

Your Situation: From Common Lisp on Windows, you would like to store credentials better than just plain-text in a file.

Purpose: 
From Common Lisp store and retrieve passwords via the Windows CryptProtectData API.
This will use the built-in cryptographic functions from windows.
They provide a security context per-user or per machine. 

Consequence: a file alone will not leak the encrypted information.
This protects unencrypted backups at the file level or isolated stolen files.
The windows installation is required for decryption. 

You could combine this with cl-store and save the credentials in a file with this additional protection.

**This is a proof-of-concept. Do not use in production.
This code has not been security-audited.
This proof-of-concept comes with no warranty to the extent permitted by law.**

Parts of this code were generated from ChatGPT 2025-04.
Idea by Sebastian Glas, 2025
   
Tested on SBCL & Windows 11

Example

`CL-USER> (ql:quickload :win32-cryptprotect-wrapper)

To load "win32-cryptprotect-wrapper":

Load 1 ASDF system:

win32-cryptprotect-wrapper

; Loading "win32-cryptprotect-wrapper"

..................................................

[package win32-cryptprotect-wrapper]..

(:WIN32-CRYPTPROTECT-WRAPPER)

CL-USER> (win32-cryptprotect-wrapper:encrypt-password "12345")

#(1 0 0 0 208 140 157 223 1 21 209 17 140 122 0 192 79 194 151 235 1 0 0 0 240
  53 24 84 45 249 134 77 151 81 137 70 71 210 162 171 0 0 0 0 2 0 0 0 0 0 16
  101 0 0 0 1 0 0 32 0 0 0 148 188 189 82 89 121 167 199 231 71 84 99 254 120 3
  191 139 108 168 6 184 163 236 18 200 6 6 122 242 167 174 151 0 0 0 0 14 128 0
  0 0 2 0 0 32 0 0 0 212 109 219 9 118 96 110 254 75 188 74 137 193 204 3 181
  213 245 244 75 247 89 229 195 158 138 238 66 147 52 61 40 16 0 0 0 232 79 240
  98 72 51 35 82 222 92 43 12 235 101 44 168 64 0 0 0 62 239 31 238 16 51 0 198
  246 64 98 94 207 74 151 84 216 10 92 225 250 138 146 113 138 185 245 102 213
  7 135 213 85 148 89 99 120 5 31 164 111 249 124 193 90 11 253 218 133 134 192
  19 228 105 168 206 160 161 39 225 3 116 243 70)
  
CL-USER> (win32-cryptprotect-wrapper:decrypt-password *)

"12345"

CL-USER>` 

## License

BSD

