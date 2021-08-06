local mixin = (import '../mixin.libsonnet').grafanaDashboards;

{
  // To generate dashboards json
  [name]: mixin[name]
  for name in std.objectFields(mixin)
}
