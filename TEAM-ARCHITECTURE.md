# Agentic Team Architecture Spec

A reusable blueprint for orchestrating a team of AI agents to execute a PRD and produce clean, tested, well-documented code.

## Philosophy

You are the team lead. The agents are your crew. You define the "what" and "why" — the agents handle the "how." The system starts conservative (phased, sequential) and earns more autonomy over time as breadcrumbs prove good judgment.

## The Team

### Team Lead / Coordinator

The brain of the operation. Every other agent reports to this one.

- Reads the PRD and owns the execution plan
- Orchestrates all other agents — decides what runs, when, and in what order
- Manages the dependency graph across Sprints and Tasks
- Makes the escalation call: small issues get auto-fixed, big ones get flagged for the human
- Generates the morning briefing from breadcrumbs when work completes
- Starts conservative (phased execution like a pipeline) and loosens toward parallel execution as trust builds

### PM Agent

Turns the PRD into an actionable Sprint plan.

- Reads the PRD and produces Sprints composed of Tasks
- Each Task is either **prescriptive** (specific implementation instructions) or **goal-oriented** (desired outcome, agent decides approach)
- Collaborates with the Team Lead to clarify scope, sequencing, and dependencies
- Flags ambiguity in the PRD rather than guessing

### Domain Modeler

Defines the domain before anyone writes code.

- Produces the domain model: entities, aggregates, value objects, events, commands
- For event-sourced systems, defines the event catalog — the foundational contract everything else builds on
- Runs early in each Sprint before builders touch anything
- Collaborates with the PM Agent to ensure Tasks align with the domain model

### API Developer

Defines and builds the contract between frontend and backend.

- Produces API specifications (endpoints, request/response shapes, error contracts)
- Both frontend and backend builders work against this contract — it prevents drift
- Runs after the Domain Modeler and before the builders
- Updates the contract when domain changes require it

### Frontend Builder

Owns the client-side application.

- Builds components, routes, pages, client-side state, and API client code
- Works against the API contract — never invents endpoints
- Leaves breadcrumbs for every significant UI decision (component structure, state management approach, UX tradeoffs)

### Backend Builder

Owns the server-side application.

- Builds API endpoints, domain logic, data access, authentication, infrastructure
- Works against the API contract and domain model
- Leaves breadcrumbs for every architectural decision (patterns chosen, libraries used, performance considerations)

### Destroyer

Stress-tests completed work. The adversarial half of the immune system.

- Reviews code for correctness, security, edge cases, and adherence to the domain model and API contract
- Writes adversarial tests — tries to break things
- Flags issues with clear descriptions of what's wrong and why it matters
- Does NOT fix issues — reports them to the Review Agent
- Leaves breadcrumbs documenting what was tested, what survived, and what broke

### Review Agent

Triages destroyer findings and drives resolution.

- Works with the Team Lead to assess each issue the Destroyer raises
- Routes issues to the appropriate builder for fixes
- Verifies fixes after builders address them
- Applies the escalation threshold: small issues (style, naming, minor refactors) get auto-resolved; big issues (architectural concerns, security, fundamental approach problems) get escalated to the human
- Leaves breadcrumbs documenting the triage decision and resolution for every issue

## Execution Flow

### Phase 1 — Planning

The PM Agent reads the PRD and produces the Sprint plan. It collaborates with the Team Lead to finalize sequencing and dependencies. Output: a set of Sprints, each containing ordered Tasks with clear acceptance criteria.

### Phase 2 — Per-Sprint Execution

For each Sprint, the following sequence runs:

**Step 1: Domain Modeling**
The Domain Modeler defines or updates the domain model for this Sprint's scope. Events, aggregates, and entities are locked before building begins.

**Step 2: API Contract**
The API Developer defines or updates the API contract for this Sprint's Tasks. Frontend and backend builders will both code against this contract.

**Step 3: Build**
Frontend and Backend Builders execute Tasks. Independent Tasks can run in parallel (at the Coordinator's discretion). Dependent Tasks run sequentially. Each builder leaves breadcrumbs for every decision.

**Step 4: Destroy**
The Destroyer reviews all completed work from this Sprint. Writes adversarial tests. Tries to break things. Reports findings.

**Step 5: Review & Resolve**
The Review Agent triages Destroyer findings with the Team Lead. Small issues get routed to builders for auto-fix. Big issues get escalated. Fixes are verified before the Sprint is marked complete.

**Step 6: Sprint Complete**
The Team Lead marks the Sprint done and moves to the next one.

### Phase 3 — Morning Briefing

After all Sprints complete (or when the overnight window ends), the Team Lead generates a summary from the breadcrumb trail:

- **What was done** — Sprints completed, Tasks finished, code produced
- **Decisions made** — key choices the agents made and their reasoning, especially for goal-oriented Tasks
- **Issues encountered** — what the Destroyer found, how it was resolved, and anything escalated for human review
- **Current state** — what's complete, what's in progress, what's next

## Breadcrumb Protocol

Every agent follows the same breadcrumb format for every significant action:

- **Who** — which agent
- **What** — what was done or decided
- **Why** — the reasoning behind the choice
- **Alternatives considered** — what else was on the table and why it was rejected
- **Confidence** — how sure the agent is about this call (high/medium/low)

Low-confidence breadcrumbs are candidates for escalation. The Review Agent and Team Lead use confidence signals to calibrate the auto-fix vs. escalate threshold.

## Trust & Autonomy Model

The system starts conservative and evolves:

**Conservative (default):**
- Strictly phased execution — no overlap between build and destroy phases
- Sequential Task execution within each phase
- Low escalation threshold — most non-trivial issues flagged for human review
- Coordinator follows the playbook exactly

**Moderate (earned):**
- Parallel Task execution within build phase for clearly independent Tasks
- Higher escalation threshold — only architectural and security concerns flagged
- Coordinator can reorder Tasks within a Sprint if dependencies allow

**Autonomous (high trust):**
- Overlapping phases — next Sprint's planning can begin while current Sprint is in review
- Builders can propose API contract changes directly (API Developer reviews)
- Destroyer findings below a severity threshold get auto-resolved without Team Lead involvement
- Coordinator can adjust Sprint scope based on what it learns during execution

Trust level is configured by the human and informed by breadcrumb review. Reading the breadcrumbs and seeing good decisions is how trust is built.

## Task Definition

Each Task in the Sprint plan includes:

- **Name** — short, descriptive
- **Type** — prescriptive or goal-oriented
- **Description** — what needs to be done (prescriptive: specific instructions; goal-oriented: desired outcome)
- **Acceptance criteria** — how to know it's done
- **Dependencies** — which Tasks must complete first
- **Sprint** — which Sprint it belongs to
- **Assigned to** — which builder agent owns it

## Adapting to a New Project

To use this architecture on a different project:

1. Write or generate a PRD for the new project
2. Update the tech stack context so builders know what frameworks and tools to use
3. Adjust the trust level based on your confidence in the agents for this domain
4. Run the pipeline — the team structure, execution flow, and breadcrumb protocol are project-agnostic
