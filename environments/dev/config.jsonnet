local secrets = import 'secrets.jsonnet';
local globalConfig = import '../config.jsonnet';

{
  space: "dev",
  app_version: '0.1.0'
} + secrets + globalConfig