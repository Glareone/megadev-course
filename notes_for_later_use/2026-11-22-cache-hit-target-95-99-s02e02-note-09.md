# Raise my cache hit rate from 75-89% to 95-99%

Date: 2026-11-22
Topic: my agent on GPT-6-luna has a hit rate of about 75-89%; I presume 95-99% improves performance, especially P90, and cuts cost
Lecture: S02E02 Building an Agent, architecture question "Cache: 99% hit rate, and that's critical"

I presume that at 95-99% cached input the agent gets much faster at P90 and cheaper. The note says what that can and cannot buy. I want to find where my missing 11-25% sits and test the P90 claim inside buckets of equal input length.

Status: [Lecture 2: 09](../Week2_Lecture_2_Building_an_Agent/09_Cache_Hit_Rate_And_P90_Latency.md) has the arithmetic, nine suspects with a log check each, and the P90 test. Still open: GPT-6-luna's cached-read price ratio and TTL, and the real log numbers.
