local dashboards = (import 'dashboards/dashboards.libsonnet');
local rules = (import 'rules/rules.libsonnet');
local prometheusRules = (import 'rules/prometheus-rules.libsonnet');

(import 'config.libsonnet') +
{
  grafanaDashboards: dashboards($._config).grafanaDashboards,
  rules: rules($._config).prometheusRules,
  prometheusRules: prometheusRules($._config).prometheusRules,
}
