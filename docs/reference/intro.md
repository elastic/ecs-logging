---
mapped_pages:
  - https://www.elastic.co/guide/en/ecs-logging/overview/current/intro.html
  - https://www.elastic.co/guide/en/ecs-logging/overview/current/index.html
---

# ECS logging libraries [intro]

Centralized application logging with the Elastic stack made easy.

![62682932 9cac3600 b9bd 11e9 9cc3 39e907280f8e](https://user-images.githubusercontent.com/2163464/62682932-9cac3600-b9bd-11e9-9cc3-39e907280f8e.png "")


## What is ECS? [_what_is_ecs]

Elastic Common Schema (ECS) defines a common set of fields for ingesting data into Elasticsearch. For more information about ECS, visit the [ECS Reference Documentation](ecs://reference/index.md).


## What is ECS logging? [_what_is_ecs_logging]

ECS loggers are plugins for your favorite logging library. They make it easy to format your logs into ECS-compatible JSON. For example:

```json
{"@timestamp":"2019-08-06T12:09:12.375Z", "log.level": "INFO", "message":"Tomcat started on port(s): 8080 (http) with context path ''", "service.name":"spring-petclinic","process.thread.name":"restartedMain","log.logger":"org.springframework.boot.web.embedded.tomcat.TomcatWebServer"}
{"@timestamp":"2019-08-06T12:09:12.379Z", "log.level": "INFO", "message":"Started PetClinicApplication in 7.095 seconds (JVM running for 9.082)", "service.name":"spring-petclinic","process.thread.name":"restartedMain","log.logger":"org.springframework.samples.petclinic.PetClinicApplication"}
{"@timestamp":"2019-08-06T14:08:40.199Z", "log.level":"DEBUG", "message":"init find form", "service.name":"spring-petclinic","process.thread.name":"http-nio-8080-exec-8","log.logger":"org.springframework.samples.petclinic.owner.OwnerController","transaction.id":"28b7fb8d5aba51f1","trace.id":"2869b25b5469590610fea49ac04af7da"}
```


## Get started [_get_started]

Refer to the installation instructions of the individual loggers:

* [.NET](ecs-dotnet://reference/setup.md)
* Go: [zap](ecs-logging-go-zap://reference/setup.md), [logrus](ecs-logging-go-logrus://reference/setup.md), [zerolog](ecs-logging-go-zerolog://reference/setup.md)
* [Java](ecs-logging-java://reference/setup.md)
* Node.js: [morgan](ecs-logging-nodejs://reference/morgan.md), [pino](ecs-logging-nodejs://reference/pino.md), [winston](ecs-logging-nodejs://reference/winston.md)
* [PHP](ecs-logging-php://reference/setup.md)
* [Python](ecs-logging-python://reference/installation.md)
* [Ruby](ecs-logging-ruby://reference/setup.md)


## Why ECS logging? [_why_ecs_logging]

**Simplicity: no manual parsing**
:   Logs arrive pre-formatted, pre-enriched and ready to add value, making problems quicker and easier to identify. No more tedious grok parsing that has to be customized for every application.


**Decently human-readable JSON structure**
:   The first three fields are `@timestamp`, `log.level` and `message`. This lets you easily read the logs in a terminal without needing a tool that converts the logs to plain-text.


**Enjoy the benefits of a common schema**
:   Use the Kibana [Logs app](docs-content://solutions/observability/logs/explore-logs.md) without additional configuration.

Using a common schema across different services and teams makes it possible create reusable dashboards and avoids [mapping explosions](docs-content://manage-data/data-store/mapping.md#mapping-limit-settings).


**APM Log correlation**
:   If you are using an [Elastic APM agent](docs-content://reference/apm-agents/index.md), you can leverage the log correlation feature without any additional configuration. This lets you jump from the [Span timeline in the APM UI](docs-content://solutions/observability/apps/trace-sample-timeline.md) to the [Logs app](docs-content://solutions/observability/logs/explore-logs.md), showing only the logs which belong to the corresponding request. Vice versa, you can also jump from a log line in the Logs UI to the Span Timeline of the APM UI. For more information about the log correlation feature, refer to [](docs-content://solutions/observability/logs/stream-application-logs.md).

### Additional advantages when using in combination with Filebeat [_additional_advantages_when_using_in_combination_with_filebeat]

We recommend shipping the logs with Filebeat. Depending on the way the application is deployed, you may log to a log file or to stdout (for example in Kubernetes).

Here are a few benefits to this over directly sending logs from the application to Elasticsearch:

**Resilient in case of outages**
:   [Guaranteed at-least-once delivery](beats://reference/filebeat/how-filebeat-works.md#at-least-once-delivery) without buffering within the application, thus no risk of out of memory errors or lost events. There’s also the option to use either the JSON logs or plain-text logs as a fallback.


**Loose coupling**
:   The application does not need to know the details of the logging backend (URI, credentials, etc.). You can also leverage alternative [Filebeat outputs](beats://reference/filebeat/configuring-output.md), like Logstash, Kafka or Redis.


**Index Lifecycle management**
:   Leverage Filebeat’s default [index lifecycle management settings](beats://reference/filebeat/ilm.md). This is much more efficient than using daily indices.


**Efficient Elasticsearch mappings**
:   Leverage Filebeat’s default ECS-compatible [index template](beats://reference/filebeat/configuration-template.md).



## Field mapping [_field_mapping]


### Default fields [_default_fields]

These fields are populated by the ECS loggers by default. Some of them, such as the `log.origin.*` fields, may have to be explicitly enabled. Others, such as `process.thread.name`, are not applicable to all languages. Refer to the documentation of the individual loggers for more information.

| ECS field | Description | Example |
| --- | --- | --- |
| [`@timestamp`](ecs://reference/ecs-base.md) | The timestamp of the log event. | `"2019-08-06T12:09:12.375Z"` |
| [`log.level`](ecs://reference/ecs-log.md) | The level or severity of the log event. | `"INFO"` |
| [`log.logger`](ecs://reference/ecs-log.md) | The name of the logger inside an application. | `"org.example.MyClass"` |
| [`log.origin.file.name`](ecs://reference/ecs-log.md) | The name of the file containing the source code which originated the log event. | `"App.java"` |
| [`log.origin.file.line`](ecs://reference/ecs-log.md) | The line number of the file containing the source code which originated the log event. | `42` |
| [`log.origin.function`](ecs://reference/ecs-log.md) | The name of the function or method which originated the log event. | `"methodName"` |
| [`message`](ecs://reference/ecs-base.md) | The log message. | `"Hello World!"` |
| [`error.type`](ecs://reference/ecs-error.md) | Only present for logs that contain an exception or error. The type or class of the error if this log event contains an exception. | `"java.lang.NullPointerException"` |
| [`error.message`](ecs://reference/ecs-error.md) | Only present for logs that contain an exception or error. The message of the exception or error. | `"The argument cannot be null"` |
| [`error.stack_trace`](ecs://reference/ecs-error.md) | Only present for logs that contain an exception or error. The full stack trace of the exception or error as a raw string. | `"Exception in thread "main" java.lang.NullPointerException\n\tat org.example.App.methodName(App.java:42)"` |
| [`process.thread.name`](ecs://reference/ecs-process.md) | The name of the thread the event has been logged from. | `"main"` |


### Configurable fields [_configurable_fields]

Refer to the documentation of the individual loggers on how to set these fields.

| ECS field | Description | Example |
| --- | --- | --- |
| [`service.name`](ecs://reference/ecs-service.md) | Helps to filter the logs by service. | `"my-service"` |
| [`service.version`](ecs://reference/ecs-service.md) | Helps to filter the logs by service version. | `"1.0"` |
| [`service.environment`](ecs://reference/ecs-service.md) | Helps to filter the logs by environment. | `"production"` |
| [`service.node.name`](ecs://reference/ecs-service.md) | Allow for two nodes of the same service, on the same host to be differentiated. | `"instance-0000000016"` |
| [`event.dataset`](ecs://reference/ecs-event.md) | Enables the [log rate anomaly detection](docs-content://solutions/observability/logs/inspect-log-anomalies.md). | `"my-service"` |


### Custom fields [_custom_fields]

Most loggers allow you to add additional custom fields. This includes both, static and dynamic ones. Examples for dynamic fields are logging structured objects, or fields from a thread local context, such as `MDC` or `ThreadContext`.

When adding custom fields, we recommend using existing [ECS fields](ecs://reference/ecs-field-reference.md) for these custom values. If there is no appropriate ECS field, consider prefixing your fields with `labels.`, as in `labels.foo`, for simple key/value pairs. For nested structures, consider prefixing with `custom.`. This approach protects against conflicts in case ECS later adds the same fields but with a different mapping.

