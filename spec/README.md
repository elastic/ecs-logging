# Specification

The specification aims to keep uniformity accross the libraries and to provide a human digestible output while producing a structured format.

The ordering of the next three keys must be respected in every ecs-logging library:

1. `@timestamp`, base field
2. `log.level`, log field
3. `message`, base field

With the fourth key, `ecs.version` ([core](https://www.elastic.co/guide/en/ecs/current/ecs-ecs.html) field) in the [ND-JSON](https://github.com/ndjson/ndjson-spec) output, we define the *minimum viable product* (MVP) for a log line.
`ecs.version` must be present in case of appenders that are not adding the `ecs.version` automatically.

All other keys are not subjected to an order until decided differently and can hence be appended to the log line.

## Examples

### Minimum Viable Product

The following example highlights the minimum set of keys in a ND-JSON output.

```json
{
    "@timestamp": "2016-05-23T08:05:34.853Z",
    "log.level": "NOTICE",
    "message": "Hi, I am the spec for the ECS logging libraries.",
    "ecs.version": "1.3.1"
}
```

## Nesting  & De-Dot'ing

### Labels
All keys in `labels` must not contain `.`, `*` and `\`; as Elasticsearch will handle theses keys as nested and that violates the purpose `labels` ([ref](https://www.elastic.co/guide/en/ecs/current/ecs-base.html)).
The substitution character must be `_`, yielding a [snake cased](https://en.wikipedia.org/wiki/Snake_case) string.

## References
* [ECS base fields](https://www.elastic.co/guide/en/ecs/current/ecs-base.html)
* [ECS log fields](https://www.elastic.co/guide/en/ecs/current/ecs-log.html)
