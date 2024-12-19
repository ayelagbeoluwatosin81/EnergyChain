;; Energy Production Data Contract

(define-map energy-production-data uint {
  producer: principal,
  energy-amount: uint,
  timestamp: uint
})

(define-map producer-total-energy principal uint)

(define-data-var production-counter uint u0)

(define-public (record-energy-production (energy-amount uint))
  (let
    (
      (production-id (+ (var-get production-counter) u1))
      (current-total (default-to u0 (map-get? producer-total-energy tx-sender)))
    )
    (map-set energy-production-data production-id {
      producer: tx-sender,
      energy-amount: energy-amount,
      timestamp: block-height
    })
    (map-set producer-total-energy tx-sender (+ current-total energy-amount))
    (var-set production-counter production-id)
    (ok production-id)
  )
)

(define-read-only (get-energy-production (production-id uint))
  (ok (unwrap! (map-get? energy-production-data production-id) (err u404)))
)

(define-read-only (get-total-energy-production (producer principal))
  (ok (default-to u0 (map-get? producer-total-energy producer)))
)

