# Specification

The specification aims to keep uniformity accross the libraries and to provide a human digestible output while producing a structured format.

The ordering of the next three keys must be respected in every ecs-logging library (unless the logging framework makes this impossible):

1. `@timestamp`, base field
2. `log.level`, log field
3. `message`, base field

With the fourth key, `ecs.version` ([core](https://www.elastic.co/guide/en/ecs/current/ecs-ecs.html) field) in the [ND-JSON](https://github.com/ndjson/ndjson-spec) output, we define the *minimum viable product* (MVP) for a log line.
`ecs.version` must be present in case of appenders that are not adding the `ecs.version` automatically.

All other keys are not subjected to an order until decided differently and can hence be appended to the event.

## Examples

### Minimum Viable Product

The following example highlights the minimum set of keys in a ND-JSON output.

```json
{
    "@timestamp": "2016-05-23T08:05:34.853Z",
    "log.level": "NOTICE",
    "message": "Hi, I am the spec for the ECS logging libraries.",
    "ecs.version": "1.4.0"
}
```

### A richer Event Context

The following example describes a richer set of fields in an event that has not an error context (see [here](#example-error-event)). The mapping can of the example is taken from `ecs-logging-java` and can be found [here](https://github.com/elastic/ecs-logging-java#mapping).


```json
{
    "@timestamp": "2016-05-23T08:05:36.789Z",
    "log.level": "NOTICE",
    "message": "This is an event with a more elaborate context",
    "ecs.version": "1.4.0",
    "log": {
        "logger": "MyLogger",
        "origin": {
            "file": {
                "name": "App.java",
                "line": 42
            },
            "function": "methodName"
        }
    },
    "process": {
        "thread": {
            "name": "my-thread-name-001"
        }
    },
    "labels": {
        "app_version": "1.0.42",
        "app_region": "europe-02",
        "app_uptime": "2016-05-15T14:03:12.345Z"
    },
    "tags": ["production", "env001"],
    "trace.id": "4bf92f3577b34da6a3ce929d0e0e4736",
    "transaction.id": "00f067aa0ba902b7",
    "service.name": "opbeans",
    "event.dataset": "opbeans.log"
}
```

### [Error Event with richer Context](#example-error-event)

This example adds the [error](https://www.elastic.co/guide/en/ecs/current/ecs-error.html) fields to the event.

```json
{
    "@timestamp": "2016-05-23T08:05:37.123Z",
    "log.level": "ERROR",
    "message": "An error happened!",
    "ecs.version": "1.4.0",
    "log": {
        "logger": "MyLogger",
        "origin": {
            "file": {
                "name": "App.java",
                "line": 42,
            },
            "function": "methodName"
        }
    },
    "process": {
        "thread": {
            "name": "my-thread-name-042"
        }
    },
    "error": {
        "type": "java.lang.NullPointerException",
        "message": "The argument cannot be null"
    },
    "labels": {
        "app_version": "1.0.42",
        "app_region": "europe-02",
        "app_uptime": "2016-05-15T14:03:12.345Z"
    },
    "tags": ["production", "env042"],
}
```

## De-Dot'ing/Sanitize of Keys in Labels
All keys in `labels` must not contain `.`, `*` and `\`; as Elasticsearch will handle theses keys as nested and that violates the purpose `labels` ([ref](https://www.elastic.co/guide/en/ecs/current/ecs-base.html)).
The substitution character must be `_`, yielding a [snake cased](https://en.wikipedia.org/wiki/Snake_case) string.

## References
* [ECS base fields](https://www.elastic.co/guide/en/ecs/current/ecs-base.html)
* [ECS log fields](https://www.elastic.co/guide/en/ecs/current/ecs-log.html)
