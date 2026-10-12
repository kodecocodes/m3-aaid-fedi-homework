Create an iOS development plan from this feature brief.

# Feature Brief

This feature brief is for **Traverse v2**, called as v2 in this brief.

## Feature context for v2

- This v2 is intentionally simple and clean.
- v2 adds local information to each destination. 
- Local information is locally persistent on the device.
- Destination to local information is one: many relationship.
- Local information is mapped to each destination.
- Local information has **info_name** and **info_note**.
- Local information is optional.
- info_name is fixed like: Currency, Language Spoken, Must try foods, Transport, Weather, Events, Etiquette, Shopping, Essentials and Others.
- info_notes is mapped to each info_name (its like 1:1).
- After basic adding local information is added, users must be able to edit and delete the local informations (just like trips or destinations in v1). 

## Known constraints:

- Do not use an LLM inside the app at runtime.
- v2 is intentionally small enough to plan clearly.
- Do not add features beyond the scope defined in this brief.
- Do not add user-facing data fields beyond those defined in this brief. Internal identifiers, relationships and ordering metadata needed to support the existing data are allowed.
- Do not add any additional info_names, other than ones in this brief.
- Unsaved forms remain editable.
- Do not add tests to v2.
- Do not add localization to v2.

## Focus on

- Following the v1's code for design, architecture for this v2 version.
- Any variation from v1 is confirmed first.

## v2 Scope

By the end of v2, a user should be able to:

- Add local information like Currency, Language Spoken, Must try foods, Transport, Weather, Events, Etiquette, Shopping, Essentials and Others.
- See the newly added local informations.
- Destinations -> Local information is one to many relationship.
- Deleting destinations also deletes all local informations.

## UI Direction Goals

- Follow v1's design.
- Tapping on a destination row takes to the list of local information screen.
- Local information to be added is shown on full screen.
- When the local information is added, a list of all the local informations is shown.

## Screen Flow

- Tapping on a destination opens Local Information screen, with either an empty list or all saved local information list.
- Follow v1 Trips Detail screen (Destination screen) to edit/ delete local information.
- Local information can be edited or deleted one by one only.

## Return the output using this structure

## Student TODO

[Add your points here]


Be specific enough that a developer or AI coding agent could implement the plan later, but do not write the code. Do not expand the feature beyond this brief. Do not silently tweak anything. If you have any questions, ask me.

