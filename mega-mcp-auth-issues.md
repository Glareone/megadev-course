# MEGA MCP Auth Issues

## Date: 2024-11-04

## Problem
Cannot access MEGA MCP server operations. All calls return `forge.membership_required` (HTTP 403): "forging is open to program members during the cohort; this account is not enrolled."

## What we tried

### 1. Authentication with work email (FIXED, using 6 digit code)
- Ran `claude mcp login mega`
- The MEGA OAuth form kept pre-filling a personal email instead of the work email
- Auth emails to the work address arrived with significant delay (corporate email filtering)
- Eventually authenticated successfully, but the 403 error persisted

### 2. OAuth form caching issue (FIXED)
- The MEGA OAuth authorize page at mega.dev cached the previously logged-in account 
- Workaround: open the auth URL in an incognito/private browser window to force a fresh login
- Clearing mega.dev cookies also works

### 3. Post-auth result (FIXED, returned)
- Authentication completed successfully with the work email: "Authenticated with mega. Its tools are now available in Claude Code."
- However, API calls still return 403 membership_required
- This suggests the account (<ME>@<COMPANY>.com) is not enrolled in the current MEGA cohort on the server side

## Available MCP tools found
The MEGA MCP server exposes these operations:
- `forge.start` — start forging a MEGA card (requires enrollment)
- `forge.submit` — submit a forge proposal
- `forge.reforge` — re-forge a published card
- `forge.digest` — read daily digest email status
- `forge.setDigest` — toggle daily digest on/off
- `cards.collect` — add a published card to your deck
- `cards.view` — view a published card's details

No "daily brief" or "mega start" operation was found among these. The course dashboard mentions running `mega start` daily, but this may require active cohort enrollment to appear as an available operation.

## Next steps
- Verify which email was used to enroll in the MEGA course (tried both work email and personal, no good effect)
- Check if the "Take the assessment" step on the MEGA website is a prerequisite for API access
- Contact MEGA support if enrollment status doesn't match expectations
- Try re-authenticating with enlarius@gmail.com if that was the original enrollment email
