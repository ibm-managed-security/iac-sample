local secrets = import 'secrets.jsonnet';
{
  org: "iac-sample",
  route: "iac-sample",
  manager: "kdwalton@us.ibm.com",
  developer: "kdwalton@us.ibm.com",
  app_repo: "https://github.com/IBM-Cloud/node-helloworld"
} + secrets