# SocialStack Protocol

> A revolutionary blockchain-native community discourse platform built on Stacks

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Clarity Version](https://img.shields.io/badge/Clarity-3.0-blue.svg)](https://docs.stacks.co/clarity/)
[![Stacks](https://img.shields.io/badge/Built%20on-Stacks-purple.svg)](https://www.stacks.co/)

## Overview

SocialStack is a revolutionary social infrastructure protocol that creates sustainable community economies through cryptographic incentives, democratized content governance, and transparent value distribution mechanisms built on Bitcoin's foundational security model.

The protocol establishes a new paradigm for digital communities by implementing economic consensus mechanisms that reward authentic participation while deterring malicious actors. Through stake-weighted governance, creator monetization via gated premium discussions, algorithmic reputation systems, and community-driven content curation, SocialStack creates a self-regulating ecosystem where quality discourse emerges naturally through aligned economic incentives.

## Key Features

### 🔐 **Economic Participation Model**

- **Stake-to-Participate**: Minimum STX staking requirement (1 STX default) ensures economic commitment
- **Time-locked Stakes**: Prevents gaming through required lock periods
- **Progressive Reputation**: Algorithmic scoring based on community contributions

### 💰 **Creator Monetization**

- **Premium Content Gates**: Thread creators can set access prices for exclusive discussions
- **Direct STX Payments**: Seamless micropayments between users and creators
- **Platform Sustainability**: Automatic 2.5% fee distribution to protocol treasury

### 🗳️ **Democratic Governance**

- **Upvote/Downvote System**: Community-driven content curation
- **Anti-Spam Mechanisms**: Economic barriers prevent low-quality submissions
- **Thread Locking**: Community moderation capabilities

### 🏆 **Reputation & Incentives**

- **Multi-dimensional Scoring**: Considers upvotes, content creation, and participation
- **NFT Milestones**: On-chain achievement system for community recognition
- **Content Amplification**: Community-driven thread boosting mechanisms

### 🌐 **Hierarchical Discussions**

- **Threaded Conversations**: Support for nested reply structures
- **Premium Access Control**: Gated content with automatic access management
- **Content Attribution**: Immutable authorship and creation timestamps

## Architecture

### Core Data Structures

```clarity
;; Thread Management
define-map threads { thread-id: uint } { ... }

;; Reply System  
define-map replies { reply-id: uint } { ... }

;; Reputation Engine
define-map user-reputation { user: principal } { ... }

;; Voting System
define-map thread-votes { thread-id: uint, voter: principal } { ... }
define-map reply-votes { reply-id: uint, voter: principal } { ... }

;; Economic Layer
define-map user-stakes { user: principal } { ... }
define-map premium-access { thread-id: uint, user: principal } { ... }
```

### Error Handling

The protocol implements comprehensive error handling with descriptive constants:

- `ERR_INSUFFICIENT_STAKE` (u110): User hasn't met minimum staking requirement
- `ERR_THREAD_NOT_PREMIUM` (u109): Attempting to access premium content without payment
- `ERR_THREAD_LOCKED` (u105): Thread is locked for new replies
- `ERR_INVALID_PARENT_REPLY` (u111): Invalid reply threading

## Installation & Setup

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) >= 2.0.0
- [Node.js](https://nodejs.org/) >= 18.0.0
- [Git](https://git-scm.com/)

### Quick Start

1. **Clone the repository**

   ```bash
   git clone https://github.com/emediong-godwin/social-stack.git
   cd social-stack
   ```

2. **Install dependencies**

   ```bash
   npm install
   ```

3. **Run contract validation**

   ```bash
   clarinet check
   ```

4. **Execute test suite**

   ```bash
   npm test
   ```

5. **Start development environment**

   ```bash
   clarinet console
   ```

## Usage Examples

### Basic Thread Creation

```clarity
;; Create a public discussion thread
(contract-call? .social-stack create-thread 
  u"Welcome to SocialStack!" 
  u"This is our first community discussion thread. Let's build something amazing together!"
  false  ;; not premium
  u0     ;; no price
)
```

### Premium Content Creation

```clarity
;; Create premium content with 100,000 microSTX access fee
(contract-call? .social-stack create-thread
  u"Advanced DeFi Strategies"
  u"Exclusive insights into advanced DeFi yield farming techniques..."
  true      ;; premium content
  u100000   ;; 0.1 STX access fee
)
```

### Replying to Discussions

```clarity
;; Reply to thread #1
(contract-call? .social-stack create-reply
  u1  ;; thread-id
  u"Great initiative! Looking forward to contributing to this community."
  none ;; no parent reply (top-level reply)
)
```

### Accessing Premium Content

```clarity
;; Purchase access to premium thread
(contract-call? .social-stack purchase-premium-access u2)
```

## API Reference

### Public Functions

#### `create-thread`

Creates a new discussion thread.

**Parameters:**

- `title` (string-utf8 256): Thread title
- `content` (string-utf8 2048): Thread content
- `is-premium` (bool): Whether thread requires payment
- `premium-price` (uint): Access price in microSTX

**Returns:** `(response uint uint)` - Thread ID on success

#### `create-reply`

Creates a reply to an existing thread.

**Parameters:**

- `thread-id` (uint): Target thread identifier
- `content` (string-utf8 1024): Reply content
- `parent-reply-id` (optional uint): Parent reply for threading

**Returns:** `(response uint uint)` - Reply ID on success

#### `purchase-premium-access`

Purchases access to premium content.

**Parameters:**

- `thread-id` (uint): Premium thread identifier

**Returns:** `(response bool uint)` - Success confirmation

### Read-Only Functions

#### `get-thread`

Retrieves thread information by ID.

#### `get-user-reputation`

Returns comprehensive reputation metrics for a user.

#### `has-premium-access`

Checks if user has access to premium thread.

#### `get-thread-count` / `get-reply-count`

Returns total thread and reply counts.

## Development

### Testing

The project uses Vitest with Clarinet SDK for comprehensive testing:

```bash
# Run all tests
npm test

# Run tests with coverage report
npm run test:report

# Watch mode for development
npm run test:watch
```

### Contract Validation

```bash
# Check contract syntax and analysis
clarinet check

# Interactive REPL for testing
clarinet console
```

### Project Structure

```
social-stack/
├── contracts/
│   └── social-stack.clar     # Main protocol contract
├── tests/
│   └── social-stack.test.ts  # Test suite
├── settings/
│   ├── Devnet.toml          # Development configuration
│   ├── Testnet.toml         # Testnet configuration
│   └── Mainnet.toml         # Mainnet configuration
├── Clarinet.toml            # Project configuration
├── package.json             # Dependencies and scripts
└── README.md               # This file
```

## Configuration

### Staking Parameters

- **Minimum Stake**: 1 STX (1,000,000 microSTX)
- **Platform Fee**: 2.5% of premium content purchases
- **Reputation Scoring**: Weighted algorithm favoring quality contributions

### Network Settings

Configure network-specific parameters in `settings/` directory:

- `Devnet.toml`: Local development
- `Testnet.toml`: Stacks testnet deployment  
- `Mainnet.toml`: Production deployment

## Economic Model

### Tokenomics

1. **Participation Stakes**: Users stake STX to participate, creating economic commitment
2. **Creator Revenue**: 97.5% of premium content fees go directly to creators
3. **Protocol Sustainability**: 2.5% platform fee funds ongoing development
4. **Reputation Incentives**: Higher reputation unlocks additional platform benefits

### Fee Structure

| Action | Cost | Distribution |
|--------|------|-------------|
| Thread Creation | Gas only | N/A |
| Premium Access | Creator-defined | 97.5% Creator, 2.5% Protocol |
| Staking | User-defined | Locked in contract |
| Voting | Gas only | N/A |

## Security Considerations

### Economic Security

- Minimum staking requirements prevent spam and low-effort content
- Time-locked stakes prevent rapid gaming of reputation systems
- Premium content gates create sustainable creator economics

### Technical Security  

- Input validation on all user-submitted content
- Proper access control for premium content
- Comprehensive error handling and edge case management
- Immutable content attribution and timestamps

### Governance Security

- Democratic voting systems with economic weight
- Community-driven moderation capabilities
- Transparent reputation calculation algorithms

## Roadmap

### Phase 1: Core Protocol ✅

- [x] Basic thread and reply functionality
- [x] Premium content system
- [x] Reputation engine
- [x] Voting mechanisms

### Phase 2: Enhanced Features 🚧

- [ ] Advanced moderation tools
- [ ] NFT milestone system implementation
- [ ] Content boost mechanisms
- [ ] Cross-thread relationship mapping

### Phase 3: Ecosystem Expansion 📋

- [ ] Frontend web application
- [ ] Mobile applications
- [ ] API gateway for third-party integrations
- [ ] Advanced analytics and insights

### Phase 4: Decentralization 🔮

- [ ] Governance token launch
- [ ] DAO governance implementation
- [ ] Cross-chain bridge integrations
- [ ] Decentralized content hosting

## Contributing

We welcome contributions from the community! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details on:

- Code standards and formatting
- Testing requirements
- Pull request process
- Issue reporting guidelines

### Development Workflow

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Add comprehensive tests
5. Ensure all tests pass (`npm test`)
6. Commit your changes (`git commit -m 'Add amazing feature'`)
7. Push to your branch (`git push origin feature/amazing-feature`)
8. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built on [Stacks](https://www.stacks.co/) blockchain
- Powered by [Clarinet](https://github.com/hirosystems/clarinet) development toolkit
- Inspired by the Bitcoin community's commitment to decentralization
- Special thanks to the Stacks developer community
