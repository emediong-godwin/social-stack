;; SocialStack Protocol
;;
;; Title: SocialStack - Blockchain-Native Community Discourse Platform
;;
;; Summary: A revolutionary social infrastructure protocol that creates sustainable
;; community economies through cryptographic incentives, democratized content
;; governance, and transparent value distribution mechanisms built on Bitcoin's
;; foundational security model.
;;
;; Description: SocialStack establishes a new paradigm for digital communities by
;; implementing economic consensus mechanisms that reward authentic participation
;; while deterring malicious actors. The protocol features stake-weighted governance,
;; creator monetization through gated premium discussions, algorithmic reputation
;; systems, and community-driven content curation. By requiring economic commitment
;; for platform participation, SocialStack creates a self-regulating ecosystem
;; where quality discourse emerges naturally through aligned economic incentives
;; between all stakeholders - creators, curators, and community members.

;; ERROR CONSTANTS

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_OWNER_ONLY (err u100))
(define-constant ERR_NOT_FOUND (err u101))
(define-constant ERR_UNAUTHORIZED (err u102))
(define-constant ERR_INSUFFICIENT_BALANCE (err u103))
(define-constant ERR_INVALID_AMOUNT (err u104))
(define-constant ERR_THREAD_LOCKED (err u105))
(define-constant ERR_ALREADY_VOTED (err u106))
(define-constant ERR_INVALID_TIP (err u107))
(define-constant ERR_SELF_TIP (err u108))
(define-constant ERR_THREAD_NOT_PREMIUM (err u109))
(define-constant ERR_INSUFFICIENT_STAKE (err u110))
(define-constant ERR_INVALID_PARENT_REPLY (err u111))

;; PROTOCOL CONFIGURATION

(define-data-var thread-counter uint u0)
(define-data-var reply-counter uint u0)
(define-data-var min-stake-amount uint u1000000) ;; 1 STX minimum stake requirement
(define-data-var platform-fee-rate uint u250) ;; 2.5% platform sustainability fee
(define-data-var platform-treasury principal CONTRACT_OWNER)

;; CORE DATA STRUCTURES

;; Thread Registry - Premium Content Management System
(define-map threads
  { thread-id: uint }
  {
    author: principal,
    title: (string-utf8 256),
    content: (string-utf8 2048),
    is-premium: bool,
    premium-price: uint,
    created-at: uint,
    upvotes: uint,
    downvotes: uint,
    tips-received: uint,
    is-locked: bool,
    reply-count: uint,
  }
)

;; Reply System - Hierarchical Discussion Architecture
(define-map replies
  { reply-id: uint }
  {
    thread-id: uint,
    author: principal,
    content: (string-utf8 1024),
    created-at: uint,
    upvotes: uint,
    downvotes: uint,
    tips-received: uint,
    parent-reply-id: (optional uint),
  }
)

;; Reputation Engine - Community Standing Metrics
(define-map user-reputation
  { user: principal }
  {
    total-upvotes: uint,
    total-downvotes: uint,
    threads-created: uint,
    replies-created: uint,
    tips-sent: uint,
    tips-received: uint,
    staked-amount: uint,
    reputation-score: uint,
  }
)

;; Voting System - Democratic Content Curation Engine
(define-map thread-votes
  {
    thread-id: uint,
    voter: principal,
  }
  { vote-type: bool }
)

(define-map reply-votes
  {
    reply-id: uint,
    voter: principal,
  }
  { vote-type: bool }
)