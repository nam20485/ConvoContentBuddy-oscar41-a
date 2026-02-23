# Architecture Design for ConvoContentBuddy

## Overview

ConvoContentBuddy employs a 4-layer architecture designed for high availability, real-time processing, and aerospace-grade resilience. The system acts as an autonomous background listener that assists users during technical interviews or coding sessions by transcribing audio, analyzing intents, identifying algorithmic problems, and retrieving optimal solutions.

## Architectural Layers

### 1. Audio Input & Transcription Layer

**Responsibility**: Capture and transcribe continuous audio streams from the user's microphone.

**Components**:
- **Speech Recognition**: Browser-based Web Speech API (webkitSpeechRecognition)
- **Audio Processing**: Silence filtering and active conversation buffer management
- **Transcript Formatting**: Timestamped text segment generation

**Technology**:
- JavaScript Web Speech API
- Browser-native speech recognition
- Client-side audio processing

**Key Features**:
- Continuous audio stream capture
- Real-time transcription with timestamps
- Silence detection and filtering
- Buffer management for active conversations

### 2. Context & Intent Analysis Layer ("The Brain")

**Responsibility**: Analyze transcript buffers to identify intents and determine the specific algorithmic problem being discussed.

**Components**:
- **Semantic Analysis Engine**: Microsoft.SemanticKernel with Gemini 2.5 Flash
- **Intent Recognition**: Problem identification from conversational descriptions
- **Transcript Processing**: Buffer management and keyword detection
- **LLM Integration**: Gemini API for intent analysis

**Technology**:
- Microsoft.SemanticKernel
- Microsoft.Extensions.AI
- Gemini 2.5 Flash model
- .NET 10 Aspire service orchestration

**Key Features**:
- Problem identification from conversational descriptions
- Keyword-triggered analysis (e.g., "array", "pointer", "sum")
- Context-aware intent recognition
- Programming language detection

### 3. Resource Retrieval Layer

**Responsibility**: Execute a hybrid search chain to retrieve problem solutions, complexities, and related information.

**Components**:
- **Vector Search Provider**: Qdrant gRPC client for semantic similarity search
- **Graph Traversal Provider**: PostgreSQL with pgvector for relationship expansion
- **Hybrid Retriever Service**: Coordinates vector search, graph expansion, and LLM verification
- **Search Grounding**: Google Search integration via Gemini API

**Technology**:
- Qdrant vector database with gRPC
- PostgreSQL with pgvector extension
- Gemini 2.5 Flash with Search Grounding
- Hybrid search orchestration

**Key Features**:
- Sub-500ms semantic vector matching
- Graph-based problem relationship traversal
- LLM verification of search results
- Multi-language code retrieval (Python, Java, C++)

### 4. Ambient UI Layer

**Responsibility**: Provide a zero-interaction, real-time interface that displays solutions and information organically as the conversation evolves.

**Components**:
- **Blazor WASM Application**: Main client interface
- **SignalR Client**: Real-time updates from server
- **Speech Interop**: JavaScript integration for Web Speech API
- **Autonomous Controller**: Client-side buffering and debounced posting

**Technology**:
- Blazor WebAssembly 10
- SignalR with Redis backplane
- JavaScript interop for Web Speech API
- Tailwind CSS for styling

**Key Features**:
- Zero-interaction UI design
- Real-time transcript visualization
- Dynamic solution card rendering
- Automatic content updates without user input

## Triple Modular Redundancy (TMR) Implementation

### Redundancy Strategy

ConvoContentBuddy implements aerospace-grade resilience through Triple Modular Redundancy at the API layer:

1. **Primary Instance**: Main processing instance
2. **Secondary Instance**: Hot standby for failover
3. **Tertiary Instance**: Additional redundancy for N+2 availability

### Failover Mechanism

**ModelFailoverManager** implements a three-tiered approach:

- **Tier 1 (Primary)**: Gemini 2.5 Flash + Search Grounding
- **Tier 2 (Fallback)**: Alternate model/region (e.g., Azure OpenAI)
- **Tier 3 (Safe Mode)**: Deterministic local fallback with low confidence flag

### State Preservation

- **SignalR State**: Redis backplane ensures connection continuity during failover
- **Session Data**: Distributed state management across instances
- **Health Monitoring**: Automatic detection and failover for failed instances

## Microservices Architecture

### Service Components

1. **ConvoContentBuddy.AppHost**
   - Aspire orchestration host
   - Service discovery and configuration
   - Infrastructure resource management

2. **ConvoContentBuddy.ServiceDefaults**
   - Shared services configuration
   - OpenTelemetry and health checks
   - Resilience pipeline definitions

3. **ConvoContentBuddy.API.Brain** (x3 instances for TMR)
   - Intent analysis and processing
   - Hybrid retrieval coordination
   - SignalR hub for real-time updates

4. **ConvoContentBuddy.UI.Web**
   - Blazor WASM client interface
   - Speech recognition integration
   - Real-time dashboard display

5. **ConvoContentBuddy.Data.Seeder**
   - LeetCode data ingestion
   - Vector and graph database seeding
   - Knowledge base maintenance

### Infrastructure Components

1. **Qdrant** (Vector Store)
   - Semantic embeddings storage
   - High-performance similarity search
   - Problem vector fingerprints

2. **PostgreSQL** (Graph Store)
   - Problem metadata storage
   - Graph relationships with pgvector
   - Complexity crawling data

3. **Redis** (SignalR Backplane)
   - Real-time message distribution
   - Cross-instance state synchronization
   - Session persistence

## Data Flow

### Main Processing Flow

1. **Audio Capture**: Browser microphone captures audio via Web Speech API
2. **Transcription**: Audio is converted to text with timestamps
3. **Buffer Management**: Transcripts are buffered and analyzed
4. **Intent Analysis**: Gemini API identifies the problem being discussed
5. **Hybrid Search**: Vector similarity + graph expansion + LLM verification
6. **Solution Retrieval**: Code solutions in multiple languages
7. **Real-time Display**: Solutions appear automatically in the UI

### Hybrid Search Chain

1. **Vector Search**: Qdrant finds semantically similar problems
2. **Graph Expansion**: PostgreSQL retrieves related problems
3. **LLM Verification**: Gemini confirms the problem match
4. **Search Grounding**: Google Search enhances accuracy
5. **Solution Assembly**: Multi-language code solutions compiled

## Resilience Patterns

### Health Monitoring

- **Liveness Probes**: Check if services are running
- **Readiness Probes**: Verify services can handle requests
- **Dependency Health**: Check database and external API connectivity
- **Automatic Recovery**: Restart failed services within 5 seconds

### Circuit Breaker Pattern

- **Failure Detection**: Monitor for consecutive failures
- **Circuit State**: Closed, Open, Half-Open states
- **Break Duration**: 30 seconds before attempting recovery
- **Fallback Actions**: Graceful degradation when services unavailable

### Retry Strategy

- **Exponential Backoff**: 1s, 2s, 4s, 8s, 16s delays
- **Jitter**: Randomized delay to prevent thundering herd
- **Context Awareness**: Different retry policies for different failure types
- **Retry Budget**: Limit total retry attempts to prevent system overload

## Performance Considerations

### Latency Targets

- **Semantic Matching**: Sub-500ms response time
- **End-to-End Processing**: Under 2 seconds total
- **UI Updates**: Real-time with minimal perceived delay
- **Failover Detection**: Sub-second detection and switching

### Scalability Factors

- **Horizontal Scaling**: API instances can be scaled independently
- **Database Scaling**: Qdrant and PostgreSQL support clustering
- **Load Balancing**: Aspire handles service distribution
- **Resource Limits**: Configurable resource constraints per service

### Caching Strategy

- **Vector Cache**: Frequently accessed problem vectors
- **Graph Cache**: Related problem relationships
- **Session Cache**: User session data and state
- **Response Cache**: LLM responses with TTL

## Security Architecture

### API Security

- **Authentication**: API key-based for Gemini access
- **Authorization**: Role-based access control
- **Rate Limiting**: Prevent abuse of AI services
- **Input Validation**: Sanitize all inputs to prevent injection

### Data Security

- **Encryption**: Data at rest and in transit
- **Privacy**: Minimal user data collection
- **Compliance**: GDPR and data protection regulations
- **Audit Logging**: Complete audit trail of all actions

### Infrastructure Security

- **Container Security**: Secure base images and vulnerability scanning
- **Network Security**: Service-to-service communication security
- **Secrets Management**: Secure storage of API keys and credentials
- **Monitoring**: Security event detection and alerting

## Deployment Architecture

### Local Development

- **Aspire Orchestration**: Single-command startup of all services
- **Docker Compose**: Containerized local development environment
- **Service Discovery**: Automatic service registration and discovery
- **Hot Reload**: Development-time code changes without restart

### Production Deployment

- **Container Orchestration**: Kubernetes or similar platform
- **Infrastructure as Code**: Declarative infrastructure definitions
- **GitOps Workflow**: Automated deployments from Git
- **Multi-Environment**: Dev, staging, and production environments

### Monitoring & Observability

- **Distributed Tracing**: End-to-end request tracing
- **Metrics Collection**: Performance and health metrics
- **Structured Logging**: Queryable logs with correlation IDs
- **Alerting**: Automated alerts for critical conditions