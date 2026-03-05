# CV Design Specification

This document contains all design decisions for the CV project.

## Table of Contents

1. [ATS Compatibility](#ats-compatibility)
2. [Visual Design](#visual-design)
3. [Content Guidelines](#content-guidelines)
4. [Improvement Roadmap](#improvement-roadmap)

---

## ATS Compatibility

### Overview

Applicant Tracking Systems (ATS) scan resumes before human recruiters see them. 97.8% of Fortune 500 companies and 75% of all companies use ATS. Understanding their limitations is critical for job applications.

### Current ATS Score: 5/10

**Strengths:**
- Clear chronological format (ATS-preferred)
- Standard section headings (Experience, Education, Projects, Certificates)
- Quantifiable achievements (13PB data, 10K DAU, 30% reduction)
- Clear job titles

**Weaknesses:**
- Visual elements that break parsing (see below)
- Missing Professional Summary section
- No dedicated Skills section
- PDF format may parse worse than .docx

### Elements That Break ATS Parsing

| Element | Location | Problem |
|---------|----------|---------|
| Profile picture | Header | ATS cannot read images |
| FontAwesome icons | Contact info | Icons are invisible to ATS |
| Company logos | Experience entries | Images disrupt text parsing |
| Styled skill tags | After each role | Complex boxes may not parse |
| Grid layouts | Header, entries | Can scramble reading order |

### Hidden Text (White Font) - DO NOT USE

Some candidates hide keywords using white text or tiny fonts. This is a bad idea:

1. **High detection rates** - ManpowerGroup detects hidden text in ~10% of resumes
2. **Context evaluation** - Modern ATS check WHERE keywords appear, not just count them
3. **Blacklisting risk** - Getting caught = blocked from ALL future roles at that company
4. **41% awareness** - So many people use this that companies actively build detection

**Verdict:** Never use hidden text. Use legitimate keyword optimization instead.

### ATS Optimization Strategy

For maximum ATS compatibility, consider maintaining two versions:

1. **`main.typ`** - Current beautiful design for:
   - Direct delivery to humans
   - Networking events
   - Referrals
   - Portfolio/website

2. **`main-ats.typ`** (future) - Plain version for:
   - Online job applications
   - ATS-heavy companies
   - Cold applications

### Recommended ATS Improvements

#### Priority 1: Add Professional Summary

Add after header, before Experience. This is the #1 location for keywords:

```
Blockchain Engineer with 3+ years of experience in Web3 development,
distributed systems, and data infrastructure. Proven track record
delivering production indexers for major blockchain networks including
Celo, Filecoin, and Zilliqa. Expertise in Elixir, Rust, and PostgreSQL.
```

#### Priority 2: Add Dedicated Skills Section

Consolidate all skills into one scannable section:

```
Languages: Elixir, Rust, Python, Scala, Solidity
Databases: PostgreSQL, ClickHouse, GreenPlum, Hadoop
Infrastructure: Docker, Ansible, Terraform, Grafana
Blockchain: Web3, Smart Contracts, Indexing, Cross-chain Protocols
```

#### Priority 3: Keyword Optimization

- Include target job title prominently ("Blockchain Engineer")
- Add acronym expansions: "Site Reliability Engineering (SRE)", "CI/CD"
- Mirror exact phrasing from job postings

### ATS-Friendly Version Checklist

When creating an ATS version:

- [ ] Remove profile picture
- [ ] Remove company logos
- [ ] Replace FontAwesome icons with text labels (Email:, Phone:, GitHub:)
- [ ] Convert skill tags to plain comma-separated lists
- [ ] Use single-column layout
- [ ] Export as .docx if possible

### Key Statistics

- 97.8% of Fortune 500 companies use ATS
- 99.7% of recruiters use keyword filters
- 88% of employers filter out candidates who don't match job descriptions
- Candidates with job title in resume are 10.6x more likely to get interviews
- Target match rate: 65-75% keyword match

---

## Visual Design

### Design Philosophy

The current design prioritizes visual appeal for human readers. This is appropriate for:
- Networking and referrals
- Portfolio presentation
- Direct delivery to hiring managers

### Color Scheme

- **Accent color:** `#7b477e` (purple tint)
- **Light background:** `#f3eaf4` (light purple for skill tags)
- **Text:** Dark gray

### Typography

- **Body font:** Source Sans Pro / Source Sans 3
- **Header font:** Roboto
- **Base size:** 11pt

### Profile Picture

- Size: 3.625cm x 3.625cm
- No border radius (square)
- Positioned in header grid

### Skill Tags

- Light purple fill with accent border
- 3pt border radius
- 8pt font size
- Horizontal layout with 4pt gaps

---

## Content Guidelines

### Quantifiable Achievements

Always include metrics where possible:
- Data scale (13PB, 10K DAU)
- Impact percentages (30% reduction)
- User/participant counts (1000 students)

### Job Descriptions

Structure each role with:
1. One-sentence summary of scope/responsibility
2. Bullet points with specific achievements
3. Skill tags for technologies used

### Date Formatting

Use format: `Mon YYYY – Mon YYYY` or `Mon YYYY – Present`

---

## Improvement Roadmap

### Phase 1: Content Optimization (Current)
- [x] Evaluate ATS compatibility
- [ ] Add Professional Summary section
- [ ] Add dedicated Skills section

### Phase 2: Dual-Version Support
- [ ] Create `main-ats.typ` with plain formatting
- [ ] Add build command for ATS version
- [ ] Test ATS parsing with online tools

### Phase 3: Keyword Optimization
- [ ] Research target job posting keywords
- [ ] Add acronym expansions
- [ ] Optimize for specific roles

---

## Research Sources

- [ATS Resume Optimization Guide 2025](https://blog.theinterviewguys.com/ats-resume-optimization/)
- [How to Optimize Resume for ATS 2026](https://scale.jobs/blog/optimize-resume-for-ats-2026-guide)
- [Can ATS Read Two-Column Resumes](https://yotru.com/blog/resume-columns-ats-single-vs-double-column)
- [ATS Formatting Mistakes to Avoid](https://www.jobscan.co/blog/ats-formatting-mistakes/)
- [Skills Section Best Practices](https://blog.theinterviewguys.com/best-ats-format-resume-for-2025/)
- [Hidden Text Detection](https://blog.theinterviewguys.com/job-seekers-are-hiding-secret-text-in-their-resumes/)
- [Keyword Stuffing Risks](https://www.jobscan.co/blog/resume-keyword-stuffing/)
