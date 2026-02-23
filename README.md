# ConvoContentBuddy

An autonomous background listener designed to assist users in real-time during technical interviews or coding sessions. By seamlessly transcribing audio and analyzing intents, it identifies specific algorithmic problems being discussed and automatically retrieves optimal solutions, complexities, and logic—all without requiring manual user input.

## 🌟 Features

- **Zero-Interaction UI**: Dashboard updates organically without mouse/keyboard input
- **Live Transcript Feed**: Real-time visualization of recognized speech
- **Hybrid Vector-Graph Search**: Sub-second algorithmic matching using Cosine similarity
- **Active Problem Card & Solution Panel**: Code snippets with syntax highlighting that automatically adapt to conversation context
- **Triple Modular Redundancy**: Aerospace-grade resilience with N+2 failover
- **Multi-language Solutions**: Automatic retrieval of Python, Java, and C++ implementations
- **Real-time Updates**: SignalR-powered instant UI updates

## 🏗️ Architecture

ConvoContentBuddy employs a 4-layer architecture designed for high availability, real-time processing, and aerospace-grade resilience:

1. **Audio Input & Transcription Layer**: Browser-based Web Speech API
2. **Context & Intent Analysis Layer**: Semantic Kernel with Gemini 2.5 Flash
3. **Resource Retrieval Layer**: Hybrid vector-graph search with Qdrant and PostgreSQL
4. **Ambient UI Layer**: Blazor WASM with SignalR real-time updates

### System Components

- **ConvoContentBuddy.AppHost** — Aspire orchestration host for service discovery and infrastructure management
- **ConvoContentBuddy.ServiceDefaults** — Shared services configuration, OpenTelemetry, health checks, and resilience pipelines
- **ConvoContentBuddy.API.Brain** (x3 instances for TMR) — Intent analysis, hybrid retrieval coordination, and SignalR hub
- **ConvoContentBuddy.API.Transcription** — Audio transcription and processing
- **ConvoContentBuddy.API.VectorSearch** — Vector similarity search provider
- **ConvoContentBuddy.API.Gateway** — API gateway with load balancing and failover
- **ConvoContentBuddy.UI.Web** — Blazor WASM client interface with speech recognition and real-time dashboard
- **ConvoContentBuddy.Data.Seeder** — LeetCode data ingestion and knowledge base maintenance

## 🚀 Getting Started

### Prerequisites

- [.NET 10.0 SDK](https://dotnet.microsoft.com/download/dotnet/10.0)
- [Docker](https://docker.com) and [Docker Compose](https://docs.docker.com/compose/)
- [Git](https://git-scm.com)

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/ConvoContentBuddy.git
   cd ConvoContentBuddy
   ```

2. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Start the development environment**
   ```bash
   # Option 1: Using .NET Aspire (recommended)
   dotnet run --project src/ConvoContentBuddy.AppHost

   # Option 2: Using Docker Compose
   docker-compose -f docker/docker-compose.yml up -d
   ```

4. **Access the application**
   - Web UI: http://localhost:5000
   - Aspire Dashboard: http://localhost:8001
   - API Gateway: http://localhost:8013

### Development Workflow

1. **Running tests**
   ```bash
   dotnet test
   ```

2. **Building the solution**
   ```bash
   dotnet build -warnaserror
   ```

3. **Code formatting**
   ```bash
   dotnet format
   ```

## 🛠️ Technology Stack

- **Language**: C# .NET 10.0 (C# 14)
- **UI Framework**: Blazor WebAssembly 10
- **AI Runtime**: Microsoft.SemanticKernel, Microsoft.Extensions.AI
- **Primary Model**: Gemini 2.5 Flash (gemini-2.5-flash-preview-09-2025)
- **Architecture**: 4-layer microservices with TMR
- **Databases**: 
  - Qdrant (vector search)
  - PostgreSQL with pgvector (graph data)
  - Redis (SignalR backplane)
- **Logging/Observability**: Serilog, OpenTelemetry (OTLP)
- **Containerization**: Docker, .NET Aspire 10

## 📊 Performance Metrics

- **Semantic Matching**: Sub-500ms response time
- **End-to-End Processing**: Under 2 seconds
- **Problem Identification Accuracy**: 95% or higher
- **System Uptime**: 99.9% with TMR
- **Test Coverage**: 80%+ target

## 🔧 Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `ASPNETCORE_ENVIRONMENT` | Runtime environment | `Development` |
| `GEMINI_API_KEY` | Gemini API key for AI services | *Required* |
| `ConnectionStrings__Qdrant` | Qdrant vector database | `http://localhost:6333` |
| `ConnectionStrings__Postgres` | PostgreSQL connection | *See docker-compose.yml* |
| `ConnectionStrings__Redis` | Redis connection | `localhost:6379` |

### Application Settings

Configuration is managed through:
- `appsettings.json` - Base configuration
- `appsettings.{Environment}.json` - Environment-specific overrides
- Environment variables
- User secrets (for local development)

## 🧪 Testing

### Running Tests

```bash
# Run all tests
dotnet test

# Run specific test project
dotnet test tests/ConvoContentBuddy.API.Brain.Tests

# Run with code coverage
dotnet test --collect:"XPlat Code Coverage"
```

### Test Structure

- **Unit Tests**: tests/ConvoContentBuddy.*.Tests
- **Integration Tests**: tests/ConvoContentBuddy.Integration.Tests
- **End-to-End Tests**: tests/ConvoContentBuddy.E2E.Tests (to be implemented)

## 📦 Deployment

### Docker Deployment

```bash
# Build all images
docker build -f docker/Dockerfile.AppHost -t convobuddy/apphost .
docker build -f docker/Dockerfile.API.Brain -t convobuddy/api-brain .
docker build -f docker/Dockerfile.UI.Web -t convobuddy/ui-web .

# Or use docker-compose
docker-compose -f docker/docker-compose.yml up -d
```

### Kubernetes Deployment

Kubernetes manifests are available in the `deploy/k8s/` directory (to be implemented).

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow the established code style (enforced by `dotnet format`)
- Include XML documentation for all public APIs
- Write unit tests for new functionality
- Update documentation as needed

## 📄 Documentation

Detailed documentation is available in the `docs/` directory:

- [Architecture Overview](docs/architecture.md)
- [API Documentation](docs/api.md)
- [Development Guide](docs/development.md)
- [Deployment Guide](docs/deployment.md)
- [Troubleshooting](docs/troubleshooting.md)

## 🐛 Troubleshooting

### Common Issues

1. **Port conflicts**: Ensure ports 5000, 6333, 5432, and 6379 are available
2. **Gemini API issues**: Verify your API key is correctly configured
3. **Database connection issues**: Check that PostgreSQL and Redis are running

### Getting Help

- Create an issue on GitHub
- Check the [troubleshooting guide](docs/troubleshooting.md)
- Review existing issues and discussions

## 📄 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## 🙏 Acknowledgments

- [Microsoft Semantic Kernel](https://github.com/microsoft/semantic-kernel)
- [Gemini AI](https://ai.google.dev/)
- [Qdrant Vector Database](https://qdrant.tech/)
- [.NET Aspire](https://learn.microsoft.com/dotnet/aspire/)

---

For a complete understanding of the project, see the [repository summary](.ai-repository-summary.md).
