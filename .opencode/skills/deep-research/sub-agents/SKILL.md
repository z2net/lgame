---
name: deep-research
description: Autonomous web research, analysis, and synthesis with multi-agent planning. Use for 'deep research', 'research topic', 'analyze this topic', 'investigate', or when you need comprehensive, structured research output with planning.
---

# Deep Research Skill

An advanced research capability that uses multi-agent planning to conduct thorough investigations, analysis, and synthesis of topics, websites, or questions.

## What it does

- **Multi-agent planning**: Breaks research into research → analysis → synthesis phases
- **Multi-source research**: Gathers information from at least 3 independent sources
- **Web search integration**: Uses Firecrawl search for comprehensive web research
- **Structured output**: Returns organized, synthesized research findings
- **Context normalization**: Extracts intent, URLs, and constraints from prompts

## When to use it

Use this skill when you need:
- Deep research on a topic with multiple perspectives
- Structured analysis of websites or documentation
- Comprehensive investigation requiring planning and synthesis
- Multi-step research workflows

## Trigger keywords

"deep research", "research topic", "analyze this", "investigate", "comprehensive analysis", "thorough research"

## How it works

### 1. Prompt Normalization

Extract and structure:
- **Intent**: What kind of research (search/analyze/summarize)
- **URL**: Optional target for analysis
- **Constraints**: Any limits on scope or format
- **Canonical form**: Standardized research question

### 2. Planning Layer

Break research into sub-tasks:

| Phase | Agent | Responsibility |
|-------|-------|----------------|
| Research | ResearchAgent | Gather from 3+ sources |
| Analysis | AnalysisAgent | Synthesize findings |
| Synthesis | SynthesisAgent | Create final output |

### 3. Execution Layer

ResearchAgent:
  - Search web for relevant information
  - Collect articles, documentation, sources
  - Return structured research data

AnalysisAgent:
  - Cross-reference findings across sources
  - Identify patterns, themes, key insights
  - Enrich context with discovered information

SynthesisAgent:
  - Combine all research results
  - Create cohesive summary/report
  - Attribute sources properly

### 4. Synthesis Layer

- Aggregate findings into comprehensive report
- Ensure at least 3 sources are used
- Structure output with clear citations

## Example workflow

User: "Research quantum computing breakthroughs 2024"

→ Planner creates tasks:
  1. ResearchAgent: Search for latest articles (sources A, B, C)
  2. AnalysisAgent: Compare and analyze findings
  3. SynthesisAgent: Combine into report

→ Executes with multi-source search
→ Returns synthesized research report with 3+ citations

## Research Quality Requirements

1. **Minimum 3 sources**: Always gather from at least 3 independent sources
2. **Cross-reference**: Verify findings across multiple sources
3. **Diverse sources**: Mix of news, academic, and technical sources when possible

## Capabilities

- Autonomous web crawling and content extraction
- Multi-step research with verification
- Topic analysis with source attribution
- Structured output as JSON or markdown

## Limitations

- Requires internet connectivity for web search
- May take multiple turns for complex research tasks
- Best for topics requiring breadth of sources
