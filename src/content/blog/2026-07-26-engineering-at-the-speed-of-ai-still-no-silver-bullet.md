---
title: "Engineering at the Speed of AI, Still No Silver Bullet"
date: 2026-07-26T07:19:00-05:00
slug: engineering-at-the-speed-of-ai-still-no-silver-bullet
draft: false
author: gabrewer
comments: true
categories: ["AI", "Development", "Architecture"]
tags: ["post"]
---

I recently put together a presentation called **Engineering at the Speed of AI: Still No Silver Bullet**. It grew out of the same thinking behind my [AI Engineering Orchestration](https://github.com/gabrewer/ai-engineering-orchestration) repository: AI is changing software development, but not by making the hard parts disappear.

About 36 years ago, I remember sitting in a classroom at Michigan listening to Professor Elliot Soloway talk about fourth-generation languages and computer-aided software engineering tools. I remember thinking, *how is this going to change what I do?*

I have had that same thought several times since then: the internet, mobile, cloud, and now AI. Each shift changed the mechanics of building software. Each shift forced us to learn new patterns. But the bigger pattern is that every one of them raised the level of abstraction.

<!--more-->

We were able to build more. We were able to solve harder problems. And the work moved up.

AI feels like another one of those moments.

### AI Is Changing Coding, Not the Hard Part

AI is already writing code. It is building real features. Small teams are shipping faster than ever. That part is real.

But technology has never been the hard part of software engineering.

The hard part has always been the human part:

- Navigating ambiguity
- Resolving conflicting priorities
- Defining the right problem
- Understanding constraints
- Making hard tradeoffs
- Deciding what not to build

Fred Brooks made the distinction between accidental complexity and essential complexity. Accidental complexity is the stuff we create around the work: syntax, tooling, frameworks, wiring, boilerplate. Essential complexity is the problem itself: the domain, the constraints, the business reality, the tradeoffs.

AI is very good at reducing accidental complexity. It automates the mechanical, the repetitive, and the obvious.

But it does not remove essential complexity.

So what happens? You hit the hard part faster.

That is why this moment can feel overwhelming. The easy parts are getting compressed, and what is left is the work that requires judgment. It does not always feel like software engineering is getting easier. In some ways, it feels harder because there is less room to hide behind implementation effort.

### The Work Has Moved Up Again

We have seen this pattern before:

1. **Assembly** gave us raw machine-level control.
2. **Higher-level languages** moved us into better syntax and semantics.
3. **Frameworks** gave us reusable patterns and abstractions.
4. **Platforms and cloud** changed how we deployed and operated systems.
5. **AI** is now automating more of the design, coding, and review loop.

Each step removed some accidental complexity and exposed more essential complexity.

Grady Booch made a point recently that stuck with me: very little about software engineering has actually changed, but a lot has changed about coding. I think that is exactly right.

The discipline is still about understanding problems and building systems that hold up over time. What is changing is the level at which we operate.

I still build software, but I no longer write code, the same way I no longer write assembly. The code is still being written. I am just not always operating at that level.

### What This Looks Like in Practice

The loop I am using more often now looks like this:

> Define intent → provide constraints → orchestrate agents → evaluate outcomes → refine → repeat

Humans own intent, constraints, and evaluation. AI agents can handle more of the inner loop: research, planning, implementation, and review.

That sounds simple, but it changes the job.

The quality of the output depends heavily on the quality of the inputs: project context, role definitions, workflow rules, review gates, and escalation paths. A single prompt can help with a task. An orchestration system can shape how work flows through planning, implementation, adversarial review, triage, and verification.

This is why I am becoming more interested in orchestration than one-off prompting.

### Agents Need Roles, Not Vibes

One example from my own workflow is an `inspire` agent. Its job is not to write code. Its job is to act as a lateral thinking partner before a line of code is written.

It reframes problems. It applies unexpected lenses. It challenges assumptions. It uses tools like inversion, transplanting an idea from another domain, or pushing an idea to an extreme scale to see what breaks.

The goal is sharper problem definition upstream.

That matters because if you misunderstand the problem, AI will help you build the wrong thing faster.

For implementation work, I have been experimenting with more explicit team orchestration. A product designer expands a milestone into a concrete brief. A PM turns that into an actionable sprint plan. A domain modeler defines the concepts before implementation starts. Builders implement within scope. A destroyer attacks the work. A reviewer triages findings and decides what needs to be fixed.

The names matter less than the separation of responsibilities.

When every agent can do everything, boundaries blur. When roles are explicit, you can give each agent a narrower job, better constraints, and clearer success criteria. That makes the output easier to inspect and easier to trust.

### The Human Is Still the System Designer

I do not want autonomous agents making unbounded decisions in my codebase. I want agents operating inside a system I understand.

That means:

- Durable instructions live in the repository
- Plans are explicit
- Quality gates are defined before execution
- Review findings are written down
- Breadcrumbs explain significant decisions
- Small issues can be fixed automatically
- Big decisions escalate to a human

The point is not to remove judgment. The point is to spend judgment where it matters most.

There are moments now where I feel like a Star Trek captain trying to come up with new ways to say "engage." But the captain still decides where the ship is going.

That is the shift. The work did not go away. It moved up.

### Harnesses Are Different

This also changes how I think about tools. The reusable idea is orchestration, but the execution environment still matters.

Another thing I am trying to make visible in the repo is that the reusable ideas are not the same as the runtime details.

Claude Code, GitHub Copilot, opencode, and Pi all have different assumptions: tool models, prompt loading, subprocess behavior, state handling, permissions, and failure modes. Pretending there is one clean abstraction over all of them usually hides the parts that matter during real execution.

The orchestration patterns can be shared. The adapter details need to be honest.

That is why the repo includes tool-specific instructions alongside the broader team orchestration model. The workflow is the concept. The harness integration is the implementation detail.

### The Bottleneck Has Moved

For a long time, the bottleneck was:

> Can we build it?

Do we have the time? Do we have the people? Can we implement it?

AI changes that. It does not make everything free, but it dramatically changes the cost and speed of implementation. More often, the bottleneck becomes:

> Should we build it? Did we define it correctly?

That is a much more interesting bottleneck.

The value of an engineer shifts from writing every line of code to defining the system, clarifying the problem, setting constraints, making tradeoffs, and evaluating whether the result will hold up over time.

This is not exciting because things are merely faster. We have made things faster before.

What is different is leverage.

We can operate at a higher level. We can explore more ideas. We can build more ambitious systems. But only if we get better at the parts AI does not remove: judgment, context, taste, and responsibility.

### Still No Silver Bullet

I am intentionally not presenting [AI Engineering Orchestration](https://github.com/gabrewer/ai-engineering-orchestration) as the answer. The repo is a working system. Some of it will change. Some of it will be wrong. Some of it will be replaced as the tools improve.

That is fine.

The important part is treating AI-assisted development as an engineering system instead of a pile of clever prompts. If the work is moving from direct implementation to intent, constraints, orchestration, and evaluation, then those artifacts deserve the same care we used to put into code structure and build pipelines.

Every major shift in software engineering has raised the level of abstraction.

This feels like another one.

It is not the worst time to become a software engineer. It might be the most exciting time.

Not because the work is easier, but because the ceiling is higher.
