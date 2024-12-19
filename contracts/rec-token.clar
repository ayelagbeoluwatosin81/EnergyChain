;; REC Token Contract

(define-fungible-token rec-token)

(define-data-var token-uri (string-utf8 256) u"https://example.com/rec-token-metadata")

(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender contract-caller) (err u403))
    (ft-mint? rec-token amount recipient)
  )
)

(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) (err u403))
    (ft-transfer? rec-token amount sender recipient)
  )
)

(define-read-only (get-balance (account principal))
  (ok (ft-get-balance rec-token account))
)

(define-read-only (get-token-uri)
  (ok (var-get token-uri))
)

(define-public (set-token-uri (new-uri (string-utf8 256)))
  (begin
    (asserts! (is-eq tx-sender contract-caller) (err u403))
    (ok (var-set token-uri new-uri))
  )
)

