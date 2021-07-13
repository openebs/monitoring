local mixin = (import '../mixin.libsonnet').grafanaDashboards;

{
  [name]: mixin[name]
  for name in std.objectFields(mixin)
}
