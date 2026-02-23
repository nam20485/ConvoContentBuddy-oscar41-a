# Workflow Execution Plan for Project Setup

## 1. Overview

**Workflow name**: Project Setup
**Workflow file reference**: `ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/project-setup.md`
**Project name**: ConvoContentBuddy
**Project description**: An autonomous background listener designed to assist users in real-time during technical interviews or coding sessions. It transcribes audio, analyzes intents, identifies algorithmic problems (like LeetCode), and retrieves solutions via the Gemini API.
**Total number of assignments**: 8
**High-level summary**: This workflow establishes the foundation for the ConvoContentBuddy project by setting up the repository infrastructure, creating a comprehensive application plan, establishing the project structure, creating documentation and summaries, and implementing validation and reporting mechanisms.

## 2. Project Context Summary

### Key Project Facts

- **Application Type**: AI-powered real-time programming interview assistant
- **Technology Stack**: .NET 10 (C# 14), ASP.NET Core 10, Blazor WebAssembly 10, .NET Aspire 10
- **AI/LLM Components**: Microsoft.SemanticKernel, Microsoft.Extensions.AI, Gemini 2.5 Flash
- **Data Storage**: Qdrant (vector search), PostgreSQL with pgvector (graph data), Redis (SignalR backplane)
- **Styling**: Tailwind CSS
- **Architecture**: 4-layer architecture with Triple Modular Redundancy (TMR)
- **Key Requirements**: Zero-interaction UI, real-time audio transcription, semantic problem identification, aerospace-grade resilience

### Architecture Highlights

- **Audio Input & Transcription Layer**: Browser-based Web Speech API
- **Context & Intent Analysis Layer ("The Brain")**: Semantic Kernel with Gemini 2.5 Flash
- **Resource Retrieval Layer**: Hybrid vector-graph search with Qdrant and PostgreSQL
- **Ambient UI Layer**: Blazor WASM with SignalR real-time updates

### Development Approach

- **Phased Implementation**: 5-phase approach from foundation through to ambient interface
- **Resilience Focus**: Aerospace-grade redundancy with N+2 failover
- **Performance Targets**: Sub-500ms semantic matching, under 2s end-to-end processing
- **Quality Standards**: 95% accuracy in problem identification, must survive single container failure

## 3. Assignment Execution Plan

### Assignment: create-workflow-plan

| Field | Content |
|---|---|
| **Assignment** | `create-workflow-plan`: Create Workflow Plan |
| **Goal** | Create a comprehensive workflow execution plan for the project-setup dynamic workflow that covers all assignments in execution order with goals, acceptance criteria, project-specific context, dependencies, and risks. |
| **Key Acceptance Criteria** | • Dynamic workflow file read and fully understood<br>• Every workflow assignment referenced traced and read completely<br>• All plan_docs/ documents read<br>• Workflow execution plan produced with all assignments documented<br>• Plan presented to stakeholder and approved<br>• Approved plan committed as plan_docs/workflow-plan.md |
| **Project-Specific Notes** | ConvoContentBuddy is a complex AI application with aerospace-grade resilience requirements. The plan must account for the 4-layer architecture, TMR implementation, and hybrid search approach. |
| **Prerequisites** | • Access to project-setup dynamic workflow file<br>• Access to all referenced workflow assignment files<br>• plan_docs/ directory with project specifications<br>• Read access to nam20485/agent-instructions repository |
| **Dependencies** | None (this is the first assignment) |
| **Risks / Challenges** | • Complexity of TMR and 4-layer architecture may require careful sequencing<br>• AI components and hybrid search approach add complexity to workflow planning<br>• Need to ensure all infrastructure components are properly orchestrated |
| **Events** | None |

### Assignment: init-existing-repository

| Field | Content |
|---|---|
| **Assignment** | `init-existing-repository`: Initiate Existing Repository |
| **Goal** | Initiate a new repository for the ConvoContentBuddy project, including creating administrative structures, configuring settings, and preparing for development. |
| **Key Acceptance Criteria** | • PR and new branch created (dynamic-workflow-project-setup)<br>• Git Project created for issue tracking<br>• Git Project linked to repository<br>• Project columns created: Not Started, In Progress, In Review, Done<br>• Labels imported for issue management<br>• Filenames changed to match project name |
| **Project-Specific Notes** | This is a complex AI project with multiple components that need proper tracking. The project board will be essential for managing the 5-phase development approach and tracking progress across the 4 architecture layers. |
| **Prerequisites** | • GitHub authentication with appropriate scopes (repo, project, read:project, read:user, user:email)<br>• GitHub CLI (gh) installed and authenticated<br>• Permissions to create repositories, manage labels, create milestones, and create branches/PRs |
| **Dependencies** | • create-workflow-plan (workflow plan must be approved first) |
| **Risks / Challenges** | • GitHub permissions may need verification for complex project setup<br>• Need to ensure proper integration between GitHub Projects and the repository<br>• File renaming must preserve DevContainer and workspace functionality |
| **Events** | None |

### Assignment: create-app-plan

| Field | Content |
|---|---|
| **Assignment** | `create-app-plan`: Create Application Plan |
| **Goal** | Create a comprehensive application plan for ConvoContentBuddy based on the filled-out application template and supporting documents, following the template from Appendix A. |
| **Key Acceptance Criteria** | • Application template thoroughly analyzed and understood<br>• Project structure documented according to guidelines<br>• Template from Appendix A used for the plan<br>• Detailed breakdown of all implementation phases<br>• All phases list important steps for completion<br>• All required components and dependencies planned<br>• Plan follows specified technology stack and design principles<br>• All mandatory requirements addressed (testing, documentation, containerization)<br>• All acceptance criteria from template addressed<br>• Risks and mitigations identified<br>• Code quality standards and best practices followed<br>• Plan documented in issue using Appendix A template<br>• Milestones created and issues linked<br>• Issue added to GitHub Project and assigned to appropriate milestone<br>• Appropriate labels applied |
| **Project-Specific Notes** | This is a PLANNING ONLY assignment. For ConvoContentBuddy, the plan must address: 4-layer architecture, TMR implementation, hybrid vector-graph search, Gemini 2.5 Flash integration, and 5-phase development approach. |
| **Prerequisites** | • Existing repository with proper project structure<br>• Access to plan_docs/ with application specifications<br>• Understanding of .NET 10 Aspire architecture |
| **Dependencies** | • init-existing-repository (repository must be established first) |
| **Risks / Challenges** | • Complex architecture with AI components requires careful planning<br>• TMR and aerospace-grade resilience needs detailed planning<br>• Must ensure all 5 development phases are properly sequenced<br>• Need to plan for hybrid search implementation complexity |
| **Events** | • pre-assignment-begin: gather-context<br>• on-assignment-failure: recover-from-error<br>• post-assignment-complete: report-progress |

### Assignment: create-project-structure

| Field | Content |
|---|---|
| **Assignment** | `create-project-structure`: Create Project Structure |
| **Goal** | Create the actual project structure and scaffolding for ConvoContentBuddy based on the comprehensive application plan, including solution structure, configuration files, and development environment foundation. |
| **Key Acceptance Criteria** | • Solution structure created following established guidelines<br>• All required project files and directories established<br>• Initial configuration files created (global.json, Docker, etc.)<br>• Basic CI/CD pipeline structure established<br>• Documentation structure created (README, docs folder, etc.)<br>• Development environment properly configured and validated<br>• Initial commit made with complete project scaffolding<br>• Stakeholder approval obtained for the project structure<br>• Repository summary document created (.ai-repository-summary.md) |
| **Project-Specific Notes** | For ConvoContentBuddy, the structure must support: .NET 10 Aspire orchestration, multiple services (API.Brain, UI.Web, Data.Seeder), and proper separation of the 4 architecture layers. |
| **Prerequisites** | • Complete application plan documented in issue or .md file<br>• Application template and supporting documents<br>• Understanding of .NET Aspire project structure |
| **Dependencies** | • create-app-plan (plan must be documented first) |
| **Risks / Challenges** | • Complex .NET Aspire orchestration with multiple services<br>• Need to establish proper structure for 4 architecture layers<br>• TMR implementation requires proper service setup from the beginning<br>• Must ensure proper configuration for AI components integration |
| **Events** | None |

### Assignment: create-repository-summary

| Field | Content |
|---|---|
| **Assignment** | `create-repository-summary`: Create Repository Summary |
| **Goal** | Create a custom summary of the ConvoContentBuddy repository in the .ai-repository-summary.md file that provides coding agents with the information needed to work efficiently in the repository. |
| **Key Acceptance Criteria** | • Repository summary file created at root (.ai-repository-summary.md)<br>• Summary follows formatting standards from ai-instructions-format.md<br>• File under 32K tokens (preferably 8-16K)<br>• High-level repository details included (what it does, size, type, languages, frameworks)<br>• Build and validation instructions documented<br>• Project layout and architecture details documented<br>• Instructions specific to the repository (not task-specific)<br>• Steps to create the summary properly followed (comprehensive inventory, command validation, etc.) |
| **Project-Specific Notes** | For ConvoContentBuddy, the summary must cover: .NET 10 Aspire orchestration, 4-layer architecture, TMR implementation, AI components (Semantic Kernel, Gemini), and hybrid search approach. |
| **Prerequisites** | • Complete project structure created<br>• All project files and documentation in place<br>• Understanding of repository structure and build processes |
| **Dependencies** | • create-project-structure (structure must be created first) |
| **Risks / Challenges** | • Complex architecture may be difficult to summarize concisely<br>• Need to balance detail with brevity to stay under token limits<br>• Must ensure build and validation commands are properly documented<br>• AI components and TMR add complexity to the summary |
| **Events** | None |

### Assignment: debrief-and-document

| Field | Content |
|---|---|
| **Assignment** | `debrief-and-document`: Debrief and Document Learnings |
| **Goal** | Perform a comprehensive debriefing session that captures key learnings, insights, and areas for improvement from the project setup phase, documenting findings in a structured format. |
| **Key Acceptance Criteria** | • Detailed report created following structured template<br>• Report documented in .md file format<br>• All required sections complete and comprehensive<br>• Report reviewed and approved by stakeholders<br>• Report committed and pushed to project repo |
| **Project-Specific Notes** | For ConvoContentBuddy, the debrief should focus on: challenges of setting up complex AI architecture, TMR implementation considerations, and lessons learned from the project setup phase. |
| **Prerequisites** | • Completion of all project setup assignments<br>• Access to all outputs and artifacts from setup phase<br>• Understanding of what worked well and what could be improved |
| **Dependencies** | • create-repository-summary (all setup assignments should be complete) |
| **Risks / Challenges** | • Complex project may have many learnings to document<br>• Need to ensure lessons are actionable for future phases<br>• Must balance detail with readability<br>• Need to identify specific improvements for workflow assignments |
| **Events** | None |

### Assignment: validate-assignment-completion

| Field | Content |
|---|---|
| **Assignment** | `validate-assignment-completion`: Validate Assignment Completion |
| **Goal** | Validate that each completed assignment has successfully met all its acceptance criteria and that all outputs are functional, ensuring quality before proceeding. |
| **Key Acceptance Criteria** | • All required files from assignment exist<br>• All verification commands pass (build, test, lint, etc.)<br>• Validation report created documenting results<br>• Pass/fail status determined<br>• If failed, specific remediation steps provided<br>• If any acceptance criterion is not met, the assignment is marked as failed |
| **Project-Specific Notes** | For ConvoContentBuddy, validation must ensure: .NET 10 solution builds correctly, Aspire orchestration works, and all infrastructure components are properly configured. |
| **Prerequisites** | • Assignment has just completed<br>• Assignment acceptance criteria are documented<br>• Assignment outputs are available for verification |
| **Dependencies** | • Any assignment that has just completed (runs in post-assignment-complete event) |
| **Risks / Challenges** | • Complex .NET Aspire project may have build complexities<br>• Multiple services and dependencies increase validation complexity<br>• Need to verify TMR implementation is properly configured<br>• AI components may require special validation considerations |
| **Events** | None |

### Assignment: report-progress

| Field | Content |
|---|---|
| **Assignment** | `report-progress`: Report Progress After Workflow Step Completion |
| **Goal** | Provide progress reporting, output capture, and validation checkpoints after each workflow step completes successfully, enabling visibility into workflow execution and facilitating recovery from interruptions. |
| **Key Acceptance Criteria** | • Generate structured progress report with step name, duration, and completion status<br>• Capture and record all step outputs for use in subsequent steps<br>• Validate that all expected outputs exist and meet format requirements<br>• Save workflow state to enable resume-from-checkpoint capability<br>• Provide optional user notifications for long-running workflows |
| **Project-Specific Notes** | For ConvoContentBuddy, progress reporting should highlight: completion of complex AI infrastructure setup, TMR implementation status, and readiness for the 5-phase development approach. |
| **Prerequisites** | • Workflow orchestrator actively executing dynamic workflow script<br>• Current workflow step completed successfully<br>• Access to step execution context and outputs |
| **Dependencies** | • Any assignment that has just completed (runs in post-assignment-complete event) |
| **Risks / Challenges** | • Complex project may have many outputs to track<br>• Need to ensure proper state management for checkpoint/resume<br>• Must provide clear progress indicators for multi-phase project<br>• AI components may add complexity to output validation |
| **Events** | None |

## 4. Sequencing Diagram

```
create-workflow-plan (pre-script-begin)
    ↓
init-existing-repository
    ↓
create-app-plan
    ↓
create-project-structure
    ↓
create-repository-summary
    ↓
debrief-and-document
    ↓
validate-assignment-completion ←┐
    ↓                         │
report-progress ←─────────────┘ (post-assignment-complete event)
```

## 5. Open Questions

1. **Branch Strategy**: The current plan assumes a single branch approach. Should we establish a branching strategy (e.g., main, develop, feature branches) to support the 5-phase development approach?

2. **Infrastructure Scaling**: The TMR implementation requires 3 replicas of the API.Brain service. Should this be validated during the create-project-structure assignment or left for later phases?

3. **AI Model Access**: The plan assumes Gemini 2.5 Flash API access is available. Should we include validation of API access and credentials as part of the setup phase?

4. **Testing Strategy**: The acceptance criteria mention comprehensive testing but don't specify when test projects should be created. Should they be part of the initial project structure or added in later phases?

5. **Documentation Level**: The technical design document and roadmap provide high-level guidance. Should more detailed technical specifications be created during the setup phase or as part of Phase 1 implementation?

---

**Prepared by**: Workflow Planning Agent  
**Date**: 2025-02-23  
**Status**: Ready for Review  
**Next Steps**: Stakeholder approval and commitment to repository