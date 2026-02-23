# Technology Stack for ConvoContentBuddy

## Core Frameworks

- **Language**: C# .NET 10.0 (C# 14)
- **Runtime**: .NET 10.0
- **UI Framework**: Blazor WebAssembly 10
- **Backend Framework**: ASP.NET Core 10
- **Orchestration**: .NET Aspire 10

## AI/LLM Components

- **AI Runtime**: Microsoft.SemanticKernel
- **AI Extensions**: Microsoft.Extensions.AI
- **Primary Model**: Gemini 2.5 Flash (gemini-2.5-flash-preview-09-2025)
- **Embedding Model**: Gemini text-embedding-004
- **Search Enhancement**: Google Search Grounding via Gemini API

## Architecture

- **Architecture Pattern**: Microservices with 4-layer architecture
- **Redundancy Model**: Triple Modular Redundancy (TMR)
- **Service Communication**: SignalR with Redis backplane
- **Search Strategy**: Hybrid vector-graph search approach

## Databases/Storage

- **Vector Database**: Qdrant with gRPC client
  - Collection: leetcode_problems
  - Dimensions: 1536
  - Similarity: Cosine
- **Graph Database**: PostgreSQL with pgvector extension
  - Primary storage for problem metadata
  - Graph edges for problem relationships
- **Cache/Session Store**: Redis
  - SignalR backplane for multi-instance sync

## Logging/Observability

- **Distributed Tracing**: OpenTelemetry (OTLP)
- **Logging**: Serilog with structured logging
- **Metrics**: System.Diagnostics.Metrics
- **Health Checks**: Microsoft.Extensions.Diagnostics.HealthChecks
- **Monitoring**: Aspire Dashboard

## Resilience

- **Resilience Pipeline**: Microsoft.Extensions.Http.Resilience (Polly)
- **Retry Strategy**: Exponential Backoff (1s, 2s, 4s, 8s, 16s)
- **Circuit Breaker**: 30s break duration
- **Failover Tiers**: 
  - Tier 1: Gemini 2.5 Flash + Search Grounding
  - Tier 2: Alternate Model/Region
  - Tier 3: Deterministic Safe Mode

## Containerization/Infrastructure

- **Containerization**: Docker/Podman
- **Orchestration**: .NET Aspire AppHost
- **Configuration**: Aspire Hosting manifests
- **Local Development**: Docker Compose via Aspire

## Development & Build

- **IDE/Editor**: Visual Studio 2022 / VS Code
- **Project Format**: SDK-style projects
- **Package Management**: NuGet
- **Build System**: MSBuild via dotnet CLI
- **Solution Structure**: Modular .NET solution

## Testing

- **Unit Testing**: xUnit
- **Integration Testing**: xUnit with TestServer
- **End-to-End Testing**: Playwright or Selenium
- **Performance Testing**: BenchmarkDotNet
- **Test Coverage**: Coverlet

## Documentation

- **API Documentation**: Swagger/OpenAPI
- **Code Documentation**: XML documentation comments
- **Project Documentation**: Markdown files in docs/
- **Architecture Records**: ADRs (Architecture Decision Records)

## Security

- **Authentication**: .NET 10 Authentication/Authorization
- **API Security**: API Key management for Gemini
- **Data Protection**: .NET Data Protection API
- **Container Security**: Base image security scanning

## Styling & UI

- **Styling Framework**: Tailwind CSS
- **UI Components**: Blazor components with Tailwind
- **Real-time Updates**: SignalR
- **Speech Integration**: JavaScript interop with webkitSpeechRecognition

## Additional Libraries

- **HTTP Client**: HttpClient Factory with Polly
- **Configuration**: Microsoft.Extensions.Configuration
- **Dependency Injection**: Microsoft.Extensions.DependencyInjection
- **Options Pattern**: Microsoft.Extensions.Options
- **JSON Handling**: System.Text.Json

## Performance Requirements

- **Semantic Matching**: Sub-500ms response time
- **End-to-End Processing**: Under 2 seconds
- **Availability**: 99.9% uptime with TMR
- **Accuracy**: 95% problem identification accuracy

## Quality Targets

- **Code Coverage**: 80%+ unit test coverage
- **Performance**: All endpoints under 1s response
- **Reliability**: Automatic recovery from failures
- **Maintainability**: Clean architecture with separation of concerns