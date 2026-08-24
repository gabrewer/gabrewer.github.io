---
title: "AI Engineering Orchestration: Making the Shift Real"
date: 2026-08-23T07:30:00-05:00
slug: ai-engineering-orchestration-making-the-shift-real
draft: false
author: gabrewer
comments: true
categories: ["AI", "Development", "Architecture"]
tags: ["post"]
---

In my last post, [Engineering at the Speed of AI, Still No Silver Bullet](/blog/engineering-at-the-speed-of-ai-still-no-silver-bullet), I wrote about the work moving up again.

AI is changing coding. It is compressing the mechanical parts of software development. But it is not removing the hard parts: defining the right problem, setting constraints, making tradeoffs, and evaluating whether the result is actually good.

My [AI Engineering Orchestration](https://github.com/gabrewer/ai-engineering-orchestration) repo is the living, breathing realization of that idea.

It is not a demo repository. It is not a polished framework. It is where I am collecting the agents, skills, instructions, and orchestration patterns I am using as I learn how to build systems with AI.

<!--more-->

The presentation was the thesis. The repo is the lab.

### From Prompting to Engineering Systems

A lot of AI-assisted development still starts and ends with prompts. That is useful, but it is not enough.

A prompt can help you get one answer. An engineering system needs repeatability, roles, boundaries, verification, and a way to improve over time.

That is the shift I am trying to capture in the repo.

Instead of treating AI as one generic assistant, I am treating AI-assisted development as a workflow that can be designed:

- What roles should exist?
- What context should each role receive?
- What decisions should be made before implementation starts?
- What quality gates should happen before work is accepted?
- What should be automated?
- What should always escalate back to a human?

Those questions are now part of the engineering work.

### What Is in the Repo

The repo is organized around the artifacts that make orchestration possible:

- **Workflow docs** — setup paths for new projects and existing codebases
- **Team orchestration instructions** — the planning and execution contract for how work moves through the system
- **Agent-generation instructions** — rules for creating a project-specific team instead of copying generic prompts everywhere
- **Canonical worker contracts** — specialized roles for product design, planning, domain modeling, API work, building, testing, adversarial review, independent review, and commits
- **Tool adapters** — harness-specific instructions for Claude Code, GitHub Copilot, opencode, and Pi
- **Projects and experiments** — places to test the ideas against real work, including PiLoop

The exact structure will change. That is intentional. This is a working system, not a finished product.

What matters is that the artifacts are visible and versioned. The way the AI system behaves should not live only in my head or in a chat transcript. It should live next to the code, where it can be reviewed, changed, and improved.

One concrete experiment in the repo is **PiLoop**, a Pi-native orchestration workflow. That distinction matters. The reusable orchestration ideas can move between tools, but the runtime details are specific: prompt and skill loading, subprocess behavior, RPC events, state handling, permissions, and failure modes. PiLoop is where I am exploring what orchestration looks like when it is built honestly around one harness instead of pretending every harness works the same way.

### Roles Matter

One of the strongest patterns I keep coming back to is role separation.

When I ask one AI assistant to do everything, the boundaries get fuzzy. It plans a little, codes a little, reviews its own work a little, and often convinces itself that everything is fine.

That is not how good teams work.

Good teams separate concerns. Product thinking is different from planning. Domain modeling is different from implementation. Implementation is different from adversarial review. Review is different from triage.

The repo makes those boundaries explicit.

A product designer can expand a rough milestone into a concrete brief. A PM can turn that into ordered work. A domain modeler can define the concepts before implementation starts. Builders can work within scoped tasks. A destroyer can attack the result. A reviewer can decide what needs to be fixed and what should be escalated.

The point is not that these exact roles are perfect. The point is that roles give the system shape.

### Constraints Are the New Leverage

If AI makes implementation cheaper, constraints become more valuable.

The better the constraints, the better the output:

- Stay inside this architecture
- Do not invent endpoints
- Do not modify tests unless assigned
- Leave breadcrumbs for significant decisions
- Only fix issues in files touched by this task
- Escalate anything that changes public contracts
- Verify with the project’s real build and test commands

Those constraints are not bureaucracy. They are how you keep speed from turning into chaos.

This is especially important as agents become more capable. The more powerful the tool, the more important the guardrails.

### Humans Still Own Judgment

The repo is not about removing humans from software development. It is about moving human attention to the highest-leverage parts of the system.

I want agents to help with research, planning, implementation, and review. I do not want them making unbounded product or architectural decisions without oversight.

The human still owns:

- Intent
- Context
- Priorities
- Tradeoffs
- Acceptance criteria
- Risk tolerance
- Final judgment

That is the part of the work AI does not eliminate.

In fact, as the implementation loop gets faster, judgment matters more. If the system can build the wrong thing quickly, then defining the right thing becomes the bottleneck.

### The Repo Is Also a Learning Tool

One reason I made the repo public is that I do not have this fully figured out.

I am learning in public. I expect the patterns to evolve. Some of the instructions will get sharper. Some agents will disappear. Some workflows will collapse into simpler forms. Others will become more formal as the need becomes obvious.

That is the point.

The repo gives me a place to capture what is working, what is not working, and what needs to be tried next.

It also gives other engineers something concrete to react to. Not a keynote idea. Not a vague prediction. Real files, real prompts, real workflows, real tradeoffs.

### The Work Moved Up. This Is What That Looks Like.

In the presentation, I said the old bottleneck was often:

> Can we build it?

The new bottleneck is increasingly:

> Should we build it? Did we define it correctly?

[AI Engineering Orchestration](https://github.com/gabrewer/ai-engineering-orchestration) is my attempt to build around that new bottleneck.

It is a way to make intent explicit. It is a way to encode constraints. It is a way to separate roles. It is a way to review outcomes. It is a way to keep humans in the loop where human judgment matters most.

The work did not go away.

It moved up.

This repo is where I am figuring out how to work at that new level.
