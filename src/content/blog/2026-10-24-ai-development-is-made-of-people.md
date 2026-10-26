---
title: "AI Development Is Made of People!"
date: 2026-10-24T19:49:20-04:00
slug: ai-development-is-made-of-people
draft: true
author: gabrewer
comments: true
categories: ["AI", "Development", "Leadership"]
tags: ["post"]
---

Most conversations about AI in software development start with developers writing code faster.

At [Lessi AI](https://www.lessi.ai) and the [American Board of Emergency Medicine](https://www.abem.org), we're pushing that boundary outward. Business analysts are using AI to explore requirements, develop product requirements documents (PRDs), and define acceptance criteria before implementation begins.

The goal isn't to turn business analysts into developers. It's to help them shape the software with the business knowledge they already bring—and help business and engineering agree on what to build.

<!--more-->

In my [previous post](/blog/ai-engineering-orchestration-making-the-shift-real), I wrote about treating AI-assisted development as an engineering system rather than a collection of prompts. We're now extending that approach beyond engineering, starting with how we define what to build.

As BAs participate more directly in shaping the software, engineers bring their technical judgment into more of those conversations. Connecting business intent to technical decisions, guiding agent execution, and evaluating the result expand their impact beyond the code they personally write. That's what I want from this process: more meaningful work between people, not fewer reasons to interact.

### The Business Knows a Thing or Two

A business analyst brings something a coding agent doesn't have on its own: an understanding of the business, the people using the application, and why a change matters.

We're having BAs work with brainstorming AI skills to turn that understanding into a PRD. The skill is a thinking partner, not just a document generator. It amplifies their business knowledge by connecting it with context from the codebase and how the application is implemented. Together, those perspectives help BAs explore the request, surface assumptions, identify edge cases, and make the intended behavior explicit.

Instead of describing a change in isolation, BAs can examine how the application currently behaves. What already exists? Which workflows use the same behavior? What should change, and what needs to stay exactly as it is?

That gives us a better basis for acceptance criteria: observable behavior in a defined context, including cases where the new behavior should not apply. Code provides evidence about the current system; BAs and developers then discuss what that evidence means for the proposed change.

### Whose PRD Is It, Anyway?

We started with developers creating the PRDs and reviewing them with BAs. The documents got reviewed, but the BAs didn't really feel ownership of the issues. That helped us see why BAs needed to lead discovery and PRD creation, with developers contributing technical context rather than handing over a document for agreement.

BAs and developers review the PRD together to agree on the problem, intended behavior, scope, and acceptance criteria. The PRD defines what we intend to build and why; the sprint plan describes how we will deliver it.

A polished document can still hide a decision nobody actually made.

That's what I want us to catch in the review. Does this describe the intended business behavior? Does it clearly distinguish what needs to change from what needs to stay the same? Are the acceptance criteria specific enough to evaluate? Which questions still need a human decision?

For me, the value isn't simply a faster PRD. It's how much deeper business and engineering can go together before implementation starts. Assumptions are there to question. Edge cases have been explored. Requirements are grounded in the existing application, with acceptance criteria to test and open questions to resolve.

### Code Review with No Code!

Once BAs and developers agree on the requirements and acceptance criteria and resolve any blocking questions, the focus shifts from what to build to how to build it. Developers use AI planning skills to create sprint plans as GitHub issues.

These plans go beyond task lists. They describe dependencies, affected areas of the codebase, assigned agent roles, acceptance criteria, and the verification expected for each task.

Developers review the plan much as they would review code, challenging the approach before implementation begins:

- Does this plan deliver the approved PRD?
- Are we changing the right parts of the system and accounting for existing workflows?
- Are the dependencies in the right order?
- Will the proposed tests demonstrate the intended behavior?
- Has the plan added complexity or scope we never agreed to?

We're still learning what to look for in these reviews, and this is where engineering expertise matters. A detailed plan can look convincing while missing a dependency, overlooking an existing workflow, or proposing the wrong approach. Engineers bring the system knowledge and technical judgment to challenge those gaps before agents turn the plan into code.

This is engineering work, before the code exists.

We can catch gaps and shape the implementation while changing direction is still relatively cheap. As agents make execution faster, the judgment we apply to their instructions matters even more.

### Cry Havoc and Let Slip the Agents of Code!

After the plan is approved, a team of agents executes it. Builders implement the work. A destroyer challenges the result through adversarial testing and inspection. A reviewer evaluates the implementation and findings, routes fixes, and identifies decisions that need human attention.

Separating those roles matters. The agent that built something shouldn't be the only perspective evaluating whether it's correct.

The agents use skills tailored to the existing system—its architecture, conventions, and established patterns—alongside general skills for implementation, testing, and review. Different skills can also use different models, chosen for the work involved rather than assuming one model is the best fit for every task.

We're also figuring out how to let developers experiment with new AI tools without losing the collaboration benefits of shared agents and skills. We want people to bring new ideas back to the team, but we don't want individual experimentation to fragment the way we work together. We haven't settled that balance yet.

Verification depends on the change. A documentation update doesn't need the same checks as a change to permissions, persistence, or a user-facing workflow. GitHub issues hold the plan, progress, findings, and verification evidence so developers can inspect what the agent team did during implementation.

When agents encounter a requirement gap or an architectural choice the plan doesn't address, they bring it back to the developer. The developer applies their judgment, and the agents incorporate that guidance into the implementation and continue the work.

### Show Me the Evidence

The completed work becomes a pull request reviewed by AI and the developer. The review connects the implementation back to the original intent: Does it meet the acceptance criteria? Did it preserve behavior we said would remain unchanged? What do the tests prove, and what hasn't been checked?

Agents can generate code faster than developers can thoroughly review it, making line-by-line human inspection a bottleneck. AI review, automated tests, and adversarial testing help examine that implementation at a scale human reading alone can't cover.

Developers still need to inspect consequential decisions, sensitive boundaries, and areas where the evidence is weak. At the PR, they consider the complete change alongside test results, agent findings, and AI review.

The decision to move forward is still theirs.

Our PR reviews are sometimes spotty. Having a review step in the workflow doesn't guarantee a thorough review, and making that practice consistent is still work we need to do.

We're putting more emphasis on whether the running software behaves as intended. Code review and automated checks help assess the implementation; testing the application against the agreed acceptance criteria helps establish whether it delivers what we set out to build.

### It Runs. But Does It Work?

After deployment to our Dev instance, the engineering team peer reviews and tests the running application. Engineers check the delivered behavior against the requirements and acceptance criteria—not leaving that judgment to agents or relying on BAs to discover gaps we should have caught.

Reviewing the running application in Dev still isn't a natural part of the process for every developer. We're working to make it a habit, not just a checkpoint on paper.

Does the workflow make sense? Does it behave as the BA and developer understood it would? Did we miss something that wasn't obvious from the plan or code?

Engineering addresses defects and missing behavior and decides when the change is ready for deployment to the QA instance. BAs then test it against the business requirements and acceptance criteria. That business perspective builds on engineering verification rather than substituting for it. The agreed criteria carry through both stages.

### Are We There Already?

We've seen changes move from an agreed PRD to a Dev deployment in hours or days, sometimes within the same day. That's what we're seeing in practice, not a turnaround time we can promise for every change. Scope, existing complexity, unresolved decisions, and verification needs all affect the timeline.

Human availability can also be the bottleneck. Someone still needs to review the PRD, approve the plan, evaluate the implementation, and test the software. AI can shorten the work between those checkpoints, but people's schedules determine when those reviews happen.

What matters to me is getting working software into the hands of the business sooner. After engineering verifies the change in Dev, deployment to the QA instance gives BAs an earlier opportunity to show us where the implementation missed the mark. That shortens the cycle between implementation, feedback, and correction.

### Who’s Running This Asylum?

The skills, agent instructions, and review gates are part of the system we're building. They need feedback from everyone participating in it—not just engineering.

The ownership gaps, uneven reviews, and experimentation questions aren't separate from that work. They're feedback about where the process needs to improve.

We need to trace that feedback through the process. Was the intent unclear in the PRD? Did the sprint plan lose a requirement? Did implementation miss something the plan specified? Did review fail to challenge the right behavior?

The answer determines what we refine: a skill, an agent's instructions, a handoff, or the evidence required at a review gate. Sometimes we need to simplify a step that creates ceremony without helping anyone make a better decision.

I don't want us to fix the defect and stop there. What would help the next team member or agent avoid it? We need to update the shared instructions and check whether the change actually helps. The goal is clearer guidance, not a longer list of instructions.

### We’re Going to Need a Bigger Team

Listening to the HBR podcast episode [“Why Great Teams Don’t Need to Like Each Other”](https://hbr.org/podcast/2026/10/why-great-teams-dont-need-to-like-each-other), I was struck by a concern about AI pulling us away from human interaction.

I want this process to take us in the opposite direction.

BAs and developers explore requirements together, challenge assumptions, and evaluate the working software. AI brings more detail, implementation context, and unanswered questions into those conversations. The opportunity isn't just to automate work between people. It's to amplify what they can accomplish together.

This also makes the software engineer's role more meaningful in new ways. Engineers connect business intent to technical decisions, shape how agents work within the system, and judge whether the evidence supports moving forward. Their impact extends beyond the code they personally write: they help the organization make better decisions about what to build, how to build it, and whether it solves the problem.

We're still refining how we do this. Feedback from the whole team helps us improve both the software and the process that produces it. AI amplifies engineers' contribution by helping them apply their technical judgment to decisions across the organization.

In earlier posts, I said the work was moving up. I'm also seeing it move outward, beyond the engineering team, to the people who help decide what the software needs to do in the first place.
