local dashboards = (import 'dashboards/dashboards.libsonnet');
local rules = (import 'rules/rules.libsonnet');

(import 'config.libsonnet') +
{
  grafanaDashboards: dashboards($._config).grafanaDashboards,
  prometheusRules: rules($._config).prometheusRules,
}
